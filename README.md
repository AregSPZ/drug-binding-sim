# Drug-Target Binding Simulation in Julia

This project is a work-in-progress simulation and ML toolkit built in Julia, designed to model reversible drug-target binding kinetics — a foundational process in drug discovery. It combines mechanistic modeling (ODEs) with machine learning to predict binding dynamics from molecular and kinetic features.

## 🚀 Goals

- Model reversible binding kinetics using `DifferentialEquations.jl`
- Generate synthetic datasets by sweeping kinetic parameters (`kon`, `koff`)
- Train ML models to predict binding rates from molecular descriptors (future step)
- Build a reproducible, modular scientific workflow aligned with modern drug discovery pipelines

## 🧠 Why This Matters

Understanding and predicting how strongly a drug binds to its target is a critical step in early-stage drug development. This simulation aims to provide a lightweight, reproducible environment for exploring these dynamics computationally — before moving to wet-lab experiments.

## 🛠️ Technologies

- Julia (`DifferentialEquations.jl`, `Plots.jl`, `Flux.jl`)
- Scientific simulation and ODE modeling
- ML integration (future phase)
- Reproducibility with `DrWatson.jl` (planned)

## 📈 Status

🔧 Currently under development — simulations of reversible kinetics are the initial focus. ML components and data pipelines will be added incrementally.

## 📂 Structure

/src # Simulation scripts
/data # Synthetic datasets (to be generated)
/notebooks # Interactive demos (Pluto or Jupyter)

## 📌 Live Updates

This project is being actively developed. Work will be pushed in progressive stages — stay tuned for updates.