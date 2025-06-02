using CSV, DataFrames
using Flux
using Statistics
using Random
using Plots

# --------------------------------
# Load data and filter for t = 60s (final time point)
df = CSV.read("binding_sweep_data.csv", DataFrame)
final_df = filter(row -> row.t == 60.0, df)

# Normalize input features
X = hcat(final_df.kon, final_df.koff)'  # 2 x N matrix
y = final_df.complex                   # 1 x N vector

# Optional: Normalize inputs
X_mean = mean(X, dims=2)
X_std = std(X, dims=2)
X_norm = (X .- X_mean) ./ X_std

# Normalize outputs (optional but helps learning)
y_mean = mean(y)
y_std = std(y)
y_norm = (y .- y_mean) ./ y_std

# Split into train/test
Random.seed!(42)
n = size(X, 2)
train_idx = rand(Bool, n)  # random mask
X_train, X_test = X_norm[:, train_idx], X_norm[:, .!train_idx]
y_train = reshape(y_norm[train_idx], 1, :)  # ensure (1, N)
y_test = reshape(y_norm[.!train_idx], 1, :)  # ensure (1, N)

# Convert all model input data to Float32
X_train = Float32.(X_train)
X_test = Float32.(X_test)
y_train = Float32.(y_train)
y_test = Float32.(y_test)

# --------------------------------
# Define model
model = Chain(
    Dense(2, 8, relu),
    Dense(8, 8, relu),
    Dense(8, 1)
)

loss(model, x, y) = Flux.mse(model(x), y)
opt = Flux.setup(ADAM(), model)  # Proper optimizer setup

# Train loop
epochs = 200
losses = []

for epoch in 1:epochs
    Flux.train!(loss, model, [(X_train, y_train)], opt)  # Use y_train, not y_train'
    push!(losses, loss(X_test, y_test))
end

# --------------------------------
# Evaluate performance
y_pred_norm = model(X_test) |> vec
y_pred = y_pred_norm .* y_std .+ y_mean  # denormalize
y_true = y_test .* y_std .+ y_mean

# --------------------------------
# Plot predictions vs actuals
scatter(y_true, y_pred,
    xlabel="Actual [Complex] (μM)",
    ylabel="Predicted [Complex] (μM)",
    title="ML Prediction of Complex Formation",
    label="",
    legend=false)
plot!(identity, lw=2, label="Ideal Fit")

println("✅ ML model trained. R² ≈ $(round(cor(vec(y_true), vec(y_pred))^2, digits=3))")
