## calcular o gradiente
function force_pair(delta_x, delta_y, r, data)

    drdx = (delta_x)/r #delta_x -> calculado com imagem mínima
    drdy = (delta_y)/r #delya_y -> calculado com iamgem mínima 

    dudr = (6*data.eps4*data.sig6)*(r^6-(2*data.sig6))/r^13
 
    dudx = dudr*drdx
    dudy = dudr*drdy
    return (-dudx, -dudy) 

end


# calcular a resultante das forças atuando em cada partícula
function lj_force!(p,  data, first_atom, next_atom, forces_list)
    np = length(p) # Number of particles
    u = 0
    for ip in 1:np  
        icell = trunc(Int64,p[ip][1]/data.cutoff)+1
        jcell = trunc(Int64,p[ip][2]/data.cutoff)+1
        for k in icell-1:icell+1          
          for l in jcell-1:jcell+1
                i, j = wrap_cell([data.nc, data.nc], k, l)
                jp = first_atom[i, j]
                while jp > 0
                    if ip < jp
                        r, delta_x, delta_y = minimg(p[ip], p[jp], data.side)
                        if r <= data.cutoff
                            force = force_pair(delta_x, delta_y, r, data)
                            forces_list[ip] += [force[1], force[2]]
                            forces_list[jp] -= [force[1], force[2]]
                            u += upair(r,data) 
                        end  
                    end
                    jp = next_atom[jp]
                end 
            end
        end
    end
    return u   
end



