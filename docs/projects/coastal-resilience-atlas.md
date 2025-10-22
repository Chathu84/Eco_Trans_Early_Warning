# Coastal Resilience Atlas

!!! abstract "At a glance"
    - **Role:** Product strategist & geospatial developer
    - **Objective:** Equip coastal planners with forward-looking insights on blue-carbon habitats
    - **Status:** Interactive prototype with stakeholder workshop feedback baked in
    - **Stack:** Python (`xarray`, `rasterio`, `geopandas`), R Shiny, Mapbox GL JS, NetCDF processing pipelines

## Project overview
Mangroves and tidal marshes act as natural buffers while storing vast amounts of carbon. Rising seas, subsidence, and human alteration, however, threaten these systems. The Coastal Resilience Atlas synthesises Earth observation records and scenario modelling into digestible layers that guide protection and restoration investments.

## Key ingredients
- **Habitat extent & change** — derived from Landsat time series, Sentinel-1 coherence, and national wetland inventories.
- **Stress indicators** — blend relative sea-level rise projections, sediment supply proxies, and shoreline change rates.
- **Human pressure metrics** — track aquaculture expansion, urban encroachment, and infrastructure using night lights and OSM data.
- **Blue-carbon accounting** — estimate avoided carbon loss and potential sequestration under alternative management actions.

## Atlas experience
- Curated story maps walk users through hotspots, resilience metrics, and community voices.
- Interactive filters allow planners to combine sea-level rise scenarios with habitat condition to find resilient refugia.
- Download packages ship GIS-ready layers, summary tables, and briefing templates for grant proposals.

## Collaboration highlights
- Co-designed decision workflows with NGOs working in Sri Lanka, Myanmar, and Indonesia.
- Presented prototype at a coastal resilience roundtable, collecting qualitative feedback that shaped roadmap priorities.
- Advanced discussions toward integrating the atlas into a regional early-warning clearinghouse.

## Roadmap
1. Incorporate high-resolution commercial imagery to resolve narrow mangrove fringes.
2. Expand socio-economic vulnerability indicators (livelihood dependence, adaptive capacity, relocation risk).
3. Launch an open-data portal with APIs for developers and local researchers.

## Learn more
- Technical notebooks (under development) will live in `notebooks/coastal-resilience/`.
- Reach out via GitHub to request a walkthrough or contribute data partnerships.
