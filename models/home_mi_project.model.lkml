connection: "echo_actian"

# include all the views
include: "/views/**/*.view"
fiscal_month_offset: -11

map_layer: oslaua_map {
  file: "/oslaua_espg4326_JSON.json"
  format: topojson
  property_key: "geo_code"
}

datagroup: home_mi_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: home_mi_project_default_datagroup

explore: lk_h_policy_history {}
explore: lk_h_adjustment_summary {}
explore: lk_h_cancel_history {}
# explore: lk_h_cancel_summary {}
explore: lk_h_expoclm_mth {}
explore: lk_h_forecast {}
# explore: lk_h_policy_history_scored {}
# explore: lk_h_policy_summary {}
# explore: lk_h_retention {}
# explore: lk_h_retention_summary {}
explore: lk_h_tcs_claims {}
