# Digital Signal Processing
**AGH Course repository**

## Requirements
1. Julia 1.11+
2. `GLMakie` installed
3. `CarioMakie` installed

### Downloading depedencies
Run julia:
``` bash
julia
```
You can install packages through command line or by code.
#### Julia Command Line
```
]   #enter pkg
add GLMakie
add CarioMakie

]st GLMakie #check version
```
#### Julia code
Run in repo directory:
``` julia
using Pkg
Pkg.activate(".")
Pkg.add("CarioMakie")
Pkg.add("GLMakie")
```
If everything worked:
``` julia
using CarioMakie
using GLMakie
```

## Course sylabus
Sylabus for this course is aviable in `/resources` directory of this repository

### Disclaimer
This repository consists Julia programs for exercises made specifically to cover course's syllabus. Results may not be valid, programs can not work, be efficient or algorythmically correct.
*Usage in projects is not advised*
Racuun @ 2025
