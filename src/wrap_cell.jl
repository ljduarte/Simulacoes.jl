function wrap_cell(nc, ic, jc) #ic e jc são os indices de uma celula
    a = ic%nc[1] 
    if a == 0
        iw = nc[1]
    elseif a > 0
        iw = a
    else
        iw = a+nc[1]
    end
    b = jc%nc[2] 
    if b == 0
        jw = nc[2]
    elseif b > 0
        jw = b
    else
        jw = b+nc[2]
    end
    return iw, jw
end
   
