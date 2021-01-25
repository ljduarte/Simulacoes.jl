function lj_pot_parallel(p,  data, first_atom, next_atom)
    np = length(p) # Number of particles
    nthreads= Threads.nthreads()
    u = zeros(nthreads)
    Threads.@threads for ip in 1:np
        id = Threads.threadid()  
        icell = trunc(Int64,p[ip][1]/data.cutoff)+1
        jcell = trunc(Int64,p[ip][2]/data.cutoff)+1
        for k in icell-1:icell+1          
          for l in jcell-1:jcell+1
                i, j = wrap_cell([data.nc, data.nc], k, l)
                jp = first_atom[i, j]
                while jp > 0
                    if ip < jp
                        r = minimg(p[ip], p[jp], data.side)[1]
                        if r < data.cutoff
                            u[id] = u[id] + upair(r, data)
                        end
                    end           
                    jp = next_atom[jp] 
                end
            end
        end
    end
    return sum(u)
end