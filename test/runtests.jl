using Simulacoes
using Test

@testset "Distance function" begin

   p1 = [ 0, 0 ]
   p2 = [ 12, 12 ]
   side = 10
   @test Simulacoes.minimg(p1,p2,10) ≈ sqrt(8)
   p2 = [ 17, 17 ]
   @test Simulacoes.minimg(p1,p2,10) ≈ sqrt(18)

end

@testset "Potential Energy" begin

  data = Data()
 
  @test Simulacoes.upair(π,data) ≈ -0.0003250451775148634

  p = initial_point(data)
  print
  @test utotal(p,data) ≈ -7472.164849146468

end

@testset "LJ Simulation" begin

  data = Data()
  p = initial_point(data)
  first_atom, next_atom = initiate_list(data, p)
  gen_lists!(data, p, first_atom, next_atom)
  @test lj_pot(p,  data, first_atom, next_atom) ≈  -247958.67014661833

end

