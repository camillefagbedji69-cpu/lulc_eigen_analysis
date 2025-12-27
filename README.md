# LULC-Stability: Eigen-Analysis of Land Cover Transitions

## 📌 Context & Overview
Land Use and Land Cover (LULC) changes are often viewed as simple gains or losses. However, ecosystems behave as dynamic systems with underlying stability properties. This project uses imagery from **Copernicus (2015-2019)** to construct a transition matrix and applies **population biology mathematics** to quantify the long-term stability and sensitivity of the landscape.

## 🎯 Objectives
* **Transition Modeling:** Constructing a normalized probability matrix of LULC changes.
* **System Stability:** Using Eigen-analysis to determine the asymptotic growth rate ($\lambda$) of land classes.
* **Sensitivity & Elasticity:** Identifying which land classes have the most significant impact on the overall landscape structure.

## 🛠️ Tech Stack & Methodology
* **Language:** R 📊
* **Core Library:** `popbio` (typically used for demographic modeling).
* **Data Source:** Copernicus LULC Rasters (Forest, Agriculture, Urban, Wetlands).
* **Mathematical Tools:** * **Dominant Eigenvalue ($\lambda_1$):** To assess system equilibrium.
    * **Stable Stage Distribution:** To predict the long-term composition of the landscape.
    * **Damping Ratio:** To measure the speed of recovery after a disturbance.



## 🚀 Key Results
* **Equilibrium Confirmed:** A dominant eigenvalue of **$\lambda_1 = 1.0$** indicates a stable system where total surface area is conserved over time.
* **Stable Stage Composition:** * **Class 20 (Forest/Dominant):** Predicted to occupy **83%** of the landscape at equilibrium.
    * **Class 50 (Agriculture):** Predicted to occupy **15%**.
    * Other classes remain marginal, suggesting a landscape highly polarized between two main types.
* **Sensitivity Analysis:** The dominant class has the highest sensitivity, meaning small changes in its transition probability would have the largest impact on the entire regional system.
* **Damping Ratio (~1):** Indicates a slow return to equilibrium, suggesting that the landscape is sensitive to prolonged disturbances (like urbanization or persistent drought).

## 🔮 Perspectives for Improvement
* **Longitudinal Series:** Extending the timeframe (e.g., 2000–2025) to capture more robust transition trends.
* **Service Coupling:** Linking transition elasticities with carbon sequestration rates to identify "high-leverage" conservation targets.
* **Spatial Projection:** Developing visualization tools to map where the system is furthest from its "stable stage."
* **Advanced Normalization:** Separating gross gains and losses to refine the sensitivity of minority classes (wetlands, urban).
