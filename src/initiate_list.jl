function initiate_list(data, p)
    first_atom = zeros(Int64,data.nc,data.nc) 
    next_atom = zeros(Int64, length(p))
    return first_atom, next_atom
end
    
