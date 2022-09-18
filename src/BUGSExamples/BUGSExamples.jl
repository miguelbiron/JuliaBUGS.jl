module BUGSExamples

using SymbolicPPL
using MCMCChains
using MCMCChains: summarize
using StatsPlots

const NA = missing

function compile(m::NamedTuple)
    @assert keys(m) == (:name, :model_def, :data, :inits)
    chains = []
    for init in m[:inits]
        push!(chains, compile_graphppl(model_def = m[:model_def], data = m[:data], initials = init))
    end
    return chains
end

row_major_reshape(v::Vector, dim) = permutedims(reshape(v, dim), Tuple(reverse([i for i in 1:length(dim)])))

include("Volume_I/Blocker.jl")
include("Volume_I/Bones.jl")
include("Volume_I/Dogs.jl")
include("Volume_I/Dyes.jl")
include("Volume_I/Epil.jl")
include("Volume_I/Equiv.jl")
include("Volume_I/Inhalers.jl")
include("Volume_I/Kidney.jl")
include("Volume_I/Leuk.jl")
include("Volume_I/LeukFr.jl")
include("Volume_I/LSAT.jl")
include("Volume_I/Magnesium.jl")
include("Volume_I/Mice.jl")
include("Volume_I/Oxford.jl")
include("Volume_I/Pumps.jl")
include("Volume_I/Rats.jl")
include("Volume_I/Salm.jl")
include("Volume_I/Seeds.jl")
include("Volume_I/Stacks.jl")
include("Volume_I/Surgical.jl")

links = (
    blocker = "https://chjackson.github.io/openbugsdoc/Examples/Blockers.html",    
    bones = "https://chjackson.github.io/openbugsdoc/Examples/Bones.html",
    dogs = "https://chjackson.github.io/openbugsdoc/Examples/Dogs.html",
    dyes = "https://chjackson.github.io/openbugsdoc/Examples/Dyes.html",
    epil = "https://chjackson.github.io/openbugsdoc/Examples/Epil.html",
    equiv = "https://chjackson.github.io/openbugsdoc/Examples/Equiv.html",
    inhalers ="https://chjackson.github.io/openbugsdoc/Examples/Inhalers.html",
    kidney = "https://chjackson.github.io/openbugsdoc/Examples/Kidney.html",
    leuk = "https://chjackson.github.io/openbugsdoc/Examples/Leuk.html",
    leukfr = "https://chjackson.github.io/openbugsdoc/Examples/Leukfr.html",
    last = "https://chjackson.github.io/openbugsdoc/Examples/Lsat.html",
    magnesium = "https://chjackson.github.io/openbugsdoc/Examples/Magnesium.html",
    mice = "https://chjackson.github.io/openbugsdoc/Examples/Mice.html",
    oxford = "https://chjackson.github.io/openbugsdoc/Examples/Oxford.html",
    pumps = "https://chjackson.github.io/openbugsdoc/Examples/Pumps.html",
    rats = "https://chjackson.github.io/openbugsdoc/Examples/Rats.html",
    salm = "https://chjackson.github.io/openbugsdoc/Examples/Salm.html",
    seeds = "https://chjackson.github.io/openbugsdoc/Examples/Seeds.html",
    stacks = "https://chjackson.github.io/openbugsdoc/Examples/Stacks.html",
    surgical_simple = "https://chjackson.github.io/openbugsdoc/Examples/Surgical.html",
    surgical_realistic = "https://chjackson.github.io/openbugsdoc/Examples/Surgical.html", 
)

examples = (
    blocker = blockers,
    bones = bones,
    dogs = dogs,
    dyes = dyes,
    epil = epil,
    equiv = equiv,
    inhalers = inhalers,
    kidney = kidney,
    leuk = leuk,
    leukfr = leukfr,
    last = last,
    magnesium = magnesium,
    mice = mice,
    oxford = oxford,
    pumps = pumps,
    rats = rats,
    salm = salm,
    seeds = seeds,
    stacks = stacks,
    surgical_simple = surgical_simple,
    surgical_realistic = surgical_realistic
)

export examples

end
