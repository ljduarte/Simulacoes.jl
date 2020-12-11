function minimg(p1 , p2 , side)
    distx = abs(p1[1]-p2[1])
    disty = abs(p1[2]-p2[2])
    rx = distx%side #resto em x
    ry = disty%side #resto em y
    
    if rx%side <= side/2
        minimgx = rx%side
    else
        minimgx = side  - rx%side
    end
    
    if ry%side <= side/2
        minimgy = ry%side
    else
        minimgy = side  - ry%side
    end
    
    minimg = sqrt(minimgx^2+minimgy^2)
    return minimg
end
