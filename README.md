# Drug-Target Binding Simulation in Julia

This project is a simulation and ML toolkit built in Julia, designed to model reversible drug-target binding kinetics — a foundational process in drug discovery. It combines mechanistic modeling (ODEs) with machine learning to predict binding dynamics from molecular and kinetic features.

## 🚀 Goals

- Model reversible binding kinetics using `DifferentialEquations.jl`
- Generate synthetic datasets by sweeping kinetic parameters (`kon`, `koff`)
- Train ML models to predict binding rates from molecular descriptors
- Build a reproducible, modular scientific workflow aligned with modern drug discovery pipelines

## 🧠 Why This Matters

Understanding and predicting how strongly a drug binds to its target is a critical step in early-stage drug development. This simulation aims to provide a lightweight, reproducible environment for exploring these dynamics computationally — before moving to wet-lab experiments.

## 🛠️ Technologies

- Julia (`DifferentialEquations.jl`, `Plots.jl`, `Flux.jl`)
- Scientific simulation and ODE modeling
- ML integration

## ⚡ Quickstart: Setup & Running

### 1. Install Julia
- Download and install Julia from [julialang.org](https://julialang.org/downloads/).

### 2. Install dependencies
Open a terminal in this project folder and run:
```julia
julia --project -e 'using Pkg; Pkg.instantiate()'
```
This will install all required packages as specified in `Project.toml` and `Manifest.toml`.

### 3. Generate synthetic data
Run the simulation script to generate the dataset:
```julia
julia src/simulation.jl
```
This will create `binding_sweep_data.csv` and a 3D plot image in the project folder.

### 4. Train the ML model
Run the machine learning script:
```julia
julia src/ml.jl
```
This will train a neural network to predict complex formation and display a results plot.

## 📁 File Overview
- `src/simulation.jl` — Simulates binding kinetics and generates synthetic data
- `src/ml.jl` — Trains and evaluates a neural network on the generated data
- `binding_sweep_data.csv` — Output data from the simulation
- `kon_koff_complex_3dplot.png` — Visualization of simulation results