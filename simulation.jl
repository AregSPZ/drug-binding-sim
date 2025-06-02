using Plots
using DifferentialEquations

# define rate constants
kon = 1.0 # association rate
koff = 0.1 # dissociation rate

# initial concentrations (in M)
D = 1.0 # Drug
T = 1.0 # Target
C = 0.0 # Complex

# initial conditions vector
u = [D, T, C]

# define the ODE function
function binding_kinetics!(du, u, p, t)
    D, T, C = u
    kon, koff = p
    # compute derivatives of each concentrations w.r.t. time
    du[1] = -kon * D * T + koff * C # d[D]/dt
    du[2] = -kon * D * T + koff * C # d[T]/dt = d[D]/dt
    du[3] = kon * D * T - koff * C # d[C]/dt = -d[D]/dt
end

# time span for the simulation
tspan = (0.0, 100.0) # seconds

# parameters
p = (kon, koff)

# define the problem and solve it
prob = ODEProblem(binding_kinetics!, u, tspan, p)
sol = solve(prob, Tsit5(), saveat=0.5)

# plot the results
plot(
    sol,
    title="Drug-Target Binding Kinetics",
    xlabel="Time (s)",
    ylabel="Concentration (M)",
    labels=["[Drug]", "[Target]", "[Complex]"],
    lw=2
)