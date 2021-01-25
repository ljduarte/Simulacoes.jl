using Simulacoes
using Test
function isapprox(x ::Tuple, y::Tuple)
  for i in 1:length(x)
    if ! (x[i] ≈ y[i])
      return false
    end
    return true
  end
end 

function isapprox(x ::Array, y::Array)
  for i in 1:length(x)
    if ! (x[i] ≈ y[i])
      return false
    end
    return true
  end
end 

@testset "Distance function" begin

   p1 = [ 0, 0 ]
   p2 = [ 12, 12 ]
   side = 10
   @test Simulacoes.minimg(p1,p2,10)[1] ≈ sqrt(8)
   p2 = [ 17, 17 ]
   @test Simulacoes.minimg(p1,p2,10)[1] ≈ sqrt(18)

end

@testset "Potential Energy" begin

  data = Data()
 
  @test Simulacoes.upair(π,data) ≈ -0.0003250451775148634

  p = initial_point(data)
    @test utotal(p,data) ≈ -7472.164849146468

end

@testset "LJ Simulation" begin

  data = Data()
  p = initial_point(data)
  first_atom, next_atom = initiate_list(data, p)
  gen_lists!(data, p, first_atom, next_atom)
  @test lj_pot(p,  data, first_atom, next_atom) ≈ -7472.164849146468
end

@testset "LJ - Parallel Simulation" begin

  data = Data()
  p = initial_point(data)
  first_atom, next_atom = initiate_list(data, p)
  gen_lists!(data, p, first_atom, next_atom)
  @test lj_pot_parallel(p,  data, first_atom, next_atom) ≈ -7472.164849146468
  
end

@testset "Forces" begin
  data = Data()
  p = initial_point(data)
  first_atom, next_atom = initiate_list(data, p)
  gen_lists!(data, p, first_atom, next_atom)
  forces_list = [[0.0,0.0] for i=1:length(p)]
 
  r, delta_x, delta_y = minimg(p[1], p[2], data.side)
  @test upair(r, data) ≈ -0.2955814601750326
  @test isapprox(force_pair(delta_x, delta_y, r, data), (0.026979429768742007, 1.7345026569041166))
  u = lj_force!(p,  data, first_atom, next_atom, forces_list)
  @test isapprox(forces_list[1], [2.9749744219446326, 1.730790463586403])
  @test isapprox(forces_list[10000], [-3.1208157043186255, -2.051342533620307])
  @test u ≈ -7472.164849146468
  println("Soma das forças:")
  println(sum(forces_list))
end

