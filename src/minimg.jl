function minimg(p1 , p2 , side)

    delta_x = (p1[1] - p2[1]) % side
    if delta_x > side/2
        delta_x -= side
    elseif delta_x < -side/2
        delta_x += side
    end

    delta_y = (p1[2] - p2[2]) % side
    if delta_y > side/2
        delta_y -= side
    elseif delta_y < -side/2
        delta_y += side 
    end
    minimg = sqrt(delta_x^2+delta_y^2)
    return (minimg, delta_x, delta_y)
end
