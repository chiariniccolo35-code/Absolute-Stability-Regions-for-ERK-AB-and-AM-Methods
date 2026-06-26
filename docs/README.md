# Documentation

## reportDEF.pdf

The complete technical report (11 pages), co-authored with Jolente Bleijs and Alberto Cozzani, University of Bologna, February 2024.

**Contents:**

1. **Description of the problem and objectives** — defines absolute stability regions and A-stable methods via the scalar test problem `y' = λy`
2. **Numerical methods and utilized software tools**
   - **2.1** A-stability regions for ERK — Taylor-expansion stability function, `contour`-based plotting, the 6-stage `p=5` Butcher tableau used
   - **2.2** A-stability for LMM (AB, AM) — boundary-locus method derivation (`z = ρ(e^{iθ})/σ(e^{iθ})`), special handling of AB1/AM1 (circles) and AM2 (half-plane shading)
   - **2.3** The MATLAB GUI Tool — describes the two-tab design and the rationale for not allowing multi-order comparisons
3. **Discussion and analysis of the results** — the Dahlquist barrier connection, comparative observations between ERK/AB/AM as `p` increases, with annotated screenshots from the GUI
4. **Conclusions** — practical recommendations (ERK generally preferable to AB for explicit problems; AM's preferability depends on function-evaluation cost, which varies by IVP)

**Bibliography:**
- Butcher, J. C. *Numerical methods for ordinary differential equations.* John Wiley & Sons, 2016.
- LeVeque, R. J. *Finite difference methods for ordinary and partial differential equations: steady-state and time-dependent problems.* SIAM, 2007.

## app_screenshot.png

A screenshot of the GUI tool in its initial/blank state (Tab 1 selected, ERK chosen in the dropdown, no plot yet generated) — automatically captured by MATLAB App Designer when the `.mlapp` file was last saved. Included here so the GUI's layout is visible without needing MATLAB installed.

## Reading Guide

| If you want to understand... | Read... |
|---|---|
| The mathematical definition of absolute stability | Report Chapter 1 |
| Why ERK regions are always bounded | Report Chapter 2.1 / Chapter 3 |
| The boundary-locus method for AB/AM | Report Chapter 2.2 |
| Why AM1/AM2 are handled as special cases in the code | Report Chapter 2.2 (end) |
| The GUI's two-tab design rationale | Report Chapter 2.3 |
| The Dahlquist-barrier connection to the results | Report Chapter 3 |
| Final method recommendations | Report Chapter 4 |

## Code ↔ Report Mapping

| Report Section | Code |
|---|---|
| 2.1 ERK stability functions | `absolute_regions_ERK` (Tab 1) / `case '1'`–`'5'` ERK blocks inside `func` (Tab 2) |
| 2.2 AB/AM boundary-locus formulas | `absolute_regions_AB`, `absolute_regions_AM` (Tab 1) / `case '1'`–`'5'` AB/AM blocks inside `func` (Tab 2) |
| 2.3 GUI tool design | `createComponents`, the dropdown/checkbox callback functions |

## Authors

**Niccolò Chiari**, Jolente Bleijs, Alberto Cozzani — University of Bologna, February 2024.
