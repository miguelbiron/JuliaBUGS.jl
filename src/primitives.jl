using Distributions
using LogExpFunctions
import LogExpFunctions: logistic, logit, cloglog, cexpexp, log1pexp
import Base: step
using SpecialFunctions
import SpecialFunctions: gamma
using LinearAlgebra
import LinearAlgebra: logdet
import AbstractPPL
using Symbolics
using Statistics
using IfElse
using Turing:Flat

""" 
    NA

`NA` is alias for [`missing`](@ref).
"""
const NA = :missing

const DISTRIBUTIONS = [:truncated, :censored, :dgamma, :dnorm, :dbeta, :dbin, :dcat, :dexp, :dpois, :dflat, :dunif, :dbern]

const INVERSE_LINK_FUNCTION =
    (logit = :logistic, cloglog = :cexpexp, log = :exp, probit = :phi)

# Reload `set_node_value!`, sampling a Binomial will give a Integer type, while GraphPPL
# only support Float right now, this is a work around
function AbstractPPL.GraphPPL.set_node_value!(m::AbstractPPL.GraphPPL.Model, ind::AbstractPPL.VarName, value::Integer)
    @assert typeof(m[ind].value[]) <: AbstractFloat
    m[ind].value[] = Float64(value)
end
    

""" 
    Distributions
"""

@register_symbolic dnorm(mu::Num, tau::Num)
dnorm(mu, tau) = Normal(mu, 1 / sqrt(tau))

@register_symbolic dbern(p::Num)
dbern(p) = Bernoulli(p)

dbin(p, n::Integer) = Binomial(n, p)
function dbin(p, n::AbstractFloat) 
    if isinteger(n)
        return Binomial(n, p)
    else
        error("Second argument of dbin has to be integer.")
    end
end

@macroexpand @register_symbolic dcat(p::Vector{Num})
@register_symbolic dcat(p::Vector{Num})
dcat(p) = Categorical(p, check_args=false)
dnegbin(p, r) = NegativeBinomial(r, p)

@register_symbolic dpois(lambda::Num)
dpois(lambda) = Poisson(lambda)
dgeom(p) = Geometric(p)
dunif(a, b) = Uniform(a, b)
dflat() = Flat()

dbeta(a, b) = Beta(a, b, check_args=false)
dexp(lambda) = Exponential(1/lambda)
dgamma(r, mu) = Gamma(r, 1/mu, check_args=false) 

"""
    Functions
"""
phi(x) = Distributions.cdf(Normal(0, 1), x)

arccos(x) = acos(x)
arccosh(x) = acosh(x)
arcsin(x) = asin(x)
arcsinh(x) = asinh(x)
arctan(x) = atan(x)
arctanh(x) = atanh(x)
icloglog(x) = cexpexp(x)
ilogit(x) = logistic(x)
logfact(x) = log(factorial(x))
loggram(x) = log(gamma(x))
softplus(x) = log1pexp(x)
step(x::Symbolics.Num) = IfElse.ifelse(x>1,1,0)

pow(base, exp) = base^exp
inprod(v1, v2) = LinearAlgebra.dot(v1, v2)
inverse(v) = inv(v)

mean(v::Symbolics.Arr{Num}) = Statistics.mean(Symbolics.scalarize(v))

# TODO: user can define functions by adding a function definition and `register_symbolic` it, maybe we can provide a macro to do these things.