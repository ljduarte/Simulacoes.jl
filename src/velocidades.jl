function initial_velocity(data, np)
    constante = -2*data.R*data.T/data.m
    p=[rand() for i in 1:np]
    vmod =  [sqrt(constante * log(1-p[i])) for i in 1:np]
    angle = [2*pi*rand() for i in 1:np]   
return [ [vmod[i]*cos(angle[i]), vmod[i]*sin(angle[i])] for i in 1:np ], vmod
end




    