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
                if jp > ip
                    r = minimg(p[ip], p[jp], data.side)
                    r6=(r^2)^3
                    r12=r6^2
                    u[id] = u[id] + data.eps4*(data.sig12/r12 - data.sig6/r6)          
                    while next_atom[jp] > 0
                        if next_atom[jp] > ip
                            r = minimg(p[ip], p[next_atom[jp]], data.side)
                            r6=(r^2)^3
                            r12=r6^2
                            u[id] =  u[id] + data.eps4*(data.sig12/r12 - data.sig6/r6)
                        end
                        jp = next_atom[jp] 
                    end
                end
            end
        end
    end
    return sum(u)
end