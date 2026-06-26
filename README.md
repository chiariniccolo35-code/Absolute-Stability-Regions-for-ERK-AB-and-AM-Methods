# Absolute Stability Regions for ERK, AB, and AM Methods

A MATLAB **App Designer GUI tool** for visualizing the **absolute stability regions** (A-stability regions) of three families of numerical methods for initial value problems (IVPs): **Explicit Runge-Kutta (ERK)**, **Adams-Bashforth (AB)**, and **Adams-Moulton (AM)**, for orders of accuracy `p = 1` to `5`.

> Group project — co-authored with Jolente Bleijs and Alberto Cozzani (University of Bologna).

## Project Overview

Given a numerical method for IVPs applied to the scalar test problem `y' = λy`, `y(0) = 1` (λ ∈ ℂ), the **absolute stability region** is the set of values `hλ ∈ ℂ⁻` for which the numerical solution `yₙ` does not grow (`|yₙ| < |yₙ₋₁|`, mimicking the decaying true solution when `Re(λ) < 0`). A method is **A-stable** if this region contains the entire left half-plane `ℂ⁻`.

This project builds a small interactive tool to **plot and compare** these regions across methods and orders, rather than just deriving them analytically.

## The Three Method Families

### Explicit Runge-Kutta (ERK)

For `p ≤ 4`, applying an ERK method of order `p` to `y' = λy` gives a stability function that is simply the truncated Taylor expansion of `e^z`:

```
R(z) = 1 + z + z²/2! + ... + z^p/p!,      z = hλ
```

The stability region boundary `|R(z)| = 1` is plotted via MATLAB's `contour` command. For `p = 5`, a 5th-order method needs **6 stages**, and the stability function becomes:

```
R(z) = 1 + z + z²/2 + z³/6 + z⁴/24 + z⁵/120 + C·z⁶
```

with `C` depending on the chosen Butcher tableau — the project selects a specific 6-stage Butcher tableau (given in the report) for which `C = 1/1280`.

### Adams-Bashforth (AB) and Adams-Moulton (AM) — Linear Multistep Methods

For linear multistep methods (LMM), the stability region boundary is derived from the **boundary-locus method**: writing the characteristic root as `r = e^{iθ}`, the boundary of the stability region is given by

```
z = ρ(e^{iθ}) / σ(e^{iθ})
```

where `ρ` and `σ` are the first and second characteristic polynomials of the LMM. This parametric curve (θ ∈ [0, 2π]) is plotted directly for `θ` swept over 500 points.

**Special cases handled explicitly:**
- **AB1** (= Explicit Euler) and **AM1** (= Backward Euler): simple circles of radius 1, centered at −1 and +1 respectively
- **AM2** (= Trapezoidal method): the stability region is the entire left half-plane, plotted via MATLAB's `xregion` to shade the half-plane rather than drawing a closed contour
- For **AM1**, since its stability region is the *exterior* of the unit circle centered at +1 (an unbounded region), the boundary is drawn with a **dashed line** to visually indicate "stability is outside this curve"

## The MATLAB GUI Tool

Built with **MATLAB App Designer**, the tool (`project2AS.mlapp`) has two tabs:

### Tab 1 — "Absolute Stability Regions, varying method"
- Select a method (ERK / AB / AM) from a dropdown
- Press **Plot** to draw that method's stability region boundary for **all orders p = 1 to 5 simultaneously**, each in a different color, with a legend

### Tab 2 — "Absolute Stability Regions, varying p"
- Select an order `p` (1 to 5) from a dropdown
- Use **checkboxes** to choose which of the three methods (ERK / AB / AM) to overlay for that fixed order
- The selected curves are drawn together on one set of axes, recomputed live as checkboxes are toggled

**Design choice (explained in the report):** the tool intentionally does **not** allow comparing different methods across *multiple* values of `p` at once — both to keep the "fixed-order, which-method-is-more-stable" comparison meaningful, and to keep the plots readable (these regions are mostly bounded and clustered near the origin, so overlaying too many curves becomes unreadable).

## Project Structure

```
.
├── README.md                       # This file
├── docs/
│   ├── README.md
│   ├── reportDEF.pdf                # Full technical report
│   └── app_screenshot.png           # Screenshot of the GUI (blank/initial state)
└── src/
    ├── README.md
    ├── project2AS.mlapp              # The MATLAB App Designer GUI tool (run this in MATLAB)
    └── project2AS_source.m           # Plain-text extraction of the app's MATLAB code (for GitHub readability only)
```

## How to Use

### Prerequisites

- MATLAB R2019b or later (App Designer / `uifigure`-based apps require a reasonably recent MATLAB release)

### Running the Tool

1. Open MATLAB
2. Open `src/project2AS.mlapp` in App Designer (or simply double-click it in the MATLAB file browser)
3. Press **Run**
4. In the app:
   - **Tab 1:** pick a method from the dropdown, press **Plot** → see its stability regions for `p = 1..5`
   - **Tab 2:** pick an order `p` from the dropdown, then tick the **ERK / ADB / ADM** checkboxes to overlay the corresponding stability region boundaries for that order

## Summary of Findings (from the report)

- All **ERK** stability regions are **bounded**, since `R(z)` is a polynomial (and polynomials diverge as `|z| → ∞`)
- The only **unbounded** regions are **AM1** (Backward Euler) and **AM2** (Trapezoidal) — consistent with the **Dahlquist barrier**: *no LMM method of order greater than 2 is A-stable*
- For `p > 2` (where both AB and AM regions are bounded), the **AM (implicit)** region is consistently larger than the corresponding **AB (explicit)** region
- **ERK** regions are larger than **AB** regions for every `p` except `p = 1` (where both reduce to Explicit Euler)
- As `p` increases, **ERK** regions tend to **grow**, while **AB** and **AM** regions tend to **shrink**

See `docs/README.md` and the full report for the complete discussion, including the explicit reasoning about which method should be preferred once function-evaluation cost is also taken into account.

## Author

**Niccolò Chiari**, with Jolente Bleijs and Alberto Cozzani  
University of Bologna — February 2024

## License

Educational project. Available for academic use.
