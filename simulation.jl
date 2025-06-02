using CSV
using Plots
using DataFrames
using ProgressMeter
using DifferentialEquations

# Reuse the ODE model
function binding_kinetics!(du, u, p, t)
    D, T, C = u
    kon, koff = p
    du[1] = -kon * D * T + koff * C
    du[2] = -kon * D * T + koff * C
    du[3] = kon * D * T - koff * C
end

# parameters to sweep over
kon_values = 0.5:0.5:3.0
koff_values = 0.05:0.05:0.3

# initial conditions
u = [1.0, 1.0, 0.0]
tspan = (0.0, 60.0) # Simulate for 60 seconds
save_times = 0:2:60 # Sample every 2 seconds

# data container
results = DataFrame(kon=Float64[], koff=Float64[], t=Float64[], complex=Float64[])

@showprogress for kon in kon_values, koff in koff_values
    p = (kon, koff)
    prob = ODEProblem(binding_kinetics!, u, tspan, p)
    sol = solve(prob, Tsit5(), saveat=save_times)
    for (i, t) in enumerate(sol.t)
        C = sol[i][3] # Complex concentration
        push!(results, (kon, koff, t, C))
    end
end

# Save to CSV
CSV.write("binding_sweep_data.csv", results)
println(" Synthetic data written to 'binding_sweep_data.csv'")


# 3D plot of (kon, koff, complex) triplets when t=60

# filter results
t = 60
final_data = filter(row -> row.t == t, results)

# extract data for plotting
x = final_data.kon
y = final_data.koff
z = final_data.complex

plt = scatter(
    x, y, z,
    xlabel="k_on",
    ylabel="k_off",
    zlabel="[Complex] at t=60",
    title="Complex concentration at t=60",
    legend=false,
    markerstrokewidth=0.5,
    markersize=5
)

savefig(plt, "kon_koff_complex_3dplot.png")
println(" Saved the plot at 'kon_koff_complex_3dplot.png'")