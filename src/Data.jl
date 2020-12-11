#
# Data for the simulation
#

using Parameters

@with_kw struct Data

  eps :: Float64 = 5.0
  sig :: Float64 = 0.5

  cutoff :: Float64 = 2.0
  side :: Float64 = 100.

  N :: Int64 = 10_000

  # Data for computation
  eps4 :: Float64 = 4*eps
  sig6 :: Float64 = sig^6
  sig12 :: Float64 = sig^12
  nc  = trunc(Int64, side/cutoff)

end



