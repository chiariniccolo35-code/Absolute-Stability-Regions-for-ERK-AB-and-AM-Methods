# Source Code

## project2AS.mlapp

The actual deliverable — a **MATLAB App Designer** app (`classdef project2AS < matlab.apps.AppBase`). This is a binary/zipped container (App Designer's native format), not plain text, so **this is the file to open and run in MATLAB** — see the main `README.md` for usage instructions.

### App Components

| Component | Type | Role |
|---|---|---|
| `UIFigure` | Figure | Main window (640×480) |
| `TabGroup` | Tab group | Hosts the two tabs described below |
| `AbsoluteStabilityRegionsvaryingmethodTab` | Tab | Tab 1 |
| `SelectDrop2` | Dropdown | Method selector (ERK / AM / AB) — Tab 1 |
| `PlotButton` | Button | Triggers plotting of all 5 orders for the selected method — Tab 1 |
| `UIAxes2` | Axes | Plot area — Tab 1 |
| `AbsoluteStabilityRegionsvaryingpTab` | Tab | Tab 2 |
| `SelectorderpDropDown` | Dropdown | Order selector (`--`, 1–5) — Tab 2 |
| `ERKCheckBox`, `ADBCheckBox`, `ADMCheckBox` | Checkboxes | Toggle which method(s) to overlay for the selected order — Tab 2 |
| `UIAxes` | Axes | Plot area — Tab 2 |

### Key Methods (private, in the app's `classdef`)

- **`absolute_regions_ERK(app)`, `absolute_regions_AB(app)`, `absolute_regions_AM(app)`** — each plots all 5 orders (`p = 1..5`) for one method family onto `UIAxes2` (used by Tab 1's Plot button)
- **`func(app, k)`** — given an order `k` (as a string `'1'`...`'5'`, or `'--'` to clear), plots whichever of ERK/AB/AM are currently checked onto `UIAxes` (used by Tab 2)
- **Callback functions** (`SelectorderpDropDownValueChanged`, `ERKCheckBoxValueChanged`, `ADBCheckBoxValueChanged`, `ADMCheckBoxValueChanged`, `PlotButtonPushed`) — standard App Designer event handlers wiring the UI controls to the plotting methods above
- **`createComponents(app)`** — auto-generated layout code defining every UI component's position/properties

## project2AS_source.m

A **plain-text extraction** of the MATLAB code embedded inside `project2AS.mlapp` (App Designer apps store their source as a CDATA block inside an internal `matlab/document.xml`, which isn't readable directly on GitHub). This file exists purely so the code can be **browsed and reviewed on GitHub** — it is not a runnable standalone script, since the GUI layout/component wiring lives inside the `.mlapp` container itself, not in this extracted text.

**To actually run the tool, always use `project2AS.mlapp` in MATLAB**, not this file.

### Stability-region formulas implemented (by order p)

**Adams-Bashforth** (boundary-locus method, `z = ρ(e^{iθ})/σ(e^{iθ})`):

| p | Formula (in terms of `xi = e^{iθ}`) |
|---|---|
| 1 | `xi - 1` |
| 2 | `xi*(xi-1) / (1.5*xi - 0.5)` |
| 3 | `12*xi²*(xi-1) / (23*xi² - 16*xi + 5)` |
| 4 | `24*xi³*(xi-1) / (55*xi³ - 59*xi² + 37*xi - 9)` |
| 5 | `720*xi⁴*(xi-1) / (1901*xi⁴ - 2774*xi³ + 2616*xi² - 1274*xi + 251)` |

**Adams-Moulton** (same method; p=1 and p=2 handled as special cases — see main README):

| p | Formula |
|---|---|
| 1 | `1 - 1/xi` (equivalently, a unit circle centered at +1; plotted with a dashed line since the *exterior* is the stable region) |
| 2 | Not parametrized — instead the whole left half-plane is shaded directly (`xregion`/`patch`), since AM2 ≡ Trapezoidal method is A-stable |
| 3 | `12*xi*(xi-1) / (5*xi² + 8*xi - 1)` |
| 4 | `24*xi²*(xi-1) / (9*xi³ + 19*xi² - 5*xi + 1)` |
| 5 | `720*xi³*(xi-1) / (251*xi⁴ + 646*xi³ - 264*xi² + 106*xi - 19)` |

**Explicit Runge-Kutta** (`R(z) = 1 + z + z²/2! + ... `, contour at `|R(z)| = 1`):

| p | Stability function `R(z)` |
|---|---|
| 1 | `1 + z` |
| 2 | `1 + z + z²/2` |
| 3 | `1 + z + z²/2 + z³/6` |
| 4 | `1 + z + z²/2 + z³/6 + z⁴/24` |
| 5 | `1 + z + z²/2 + z³/6 + z⁴/24 + z⁵/120 + z⁶/1280` (6-stage formula; the `1/1280` coefficient comes from the specific Butcher tableau chosen — see report Chapter 2) |

## Dependencies

Only core MATLAB is required — no toolboxes. The app uses:
- `uifigure`, `uitabgroup`, `uitab`, `uiaxes`, `uidropdown`, `uicheckbox`, `uibutton`, `uilabel` (App Designer / UI Figure components)
- `contour`, `plot`, `patch`, `xregion`, `legend`, `grid`, `hold` (standard plotting)
- `meshgrid`, `linspace`, `exp`, `sqrt` (standard math)
