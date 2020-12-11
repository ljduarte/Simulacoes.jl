function gen_lists!(data, p, first_atom, next_atom)
    for iat in 1:length(p)
        ic = trunc(Int64,p[iat][1]/data.cutoff) + 1
        jc = trunc(Int64,p[iat][2]/data.cutoff) + 1
        next_atom[iat] = first_atom[ic, jc]
        first_atom[ic, jc] = iat
    end
    return first_atom, next_atom
end