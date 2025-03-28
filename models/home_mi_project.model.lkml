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
  sql_trigger: SELECT MAX(load_dttm) FROM actian.lk_h_policy_history_scored;;
  max_cache_age: "48 hours"
}

persist_with: home_mi_project_default_datagroup

explore: lk_h_policy_history {
  label: "Home Policy History Scored (Written Records)"
}

explore: lk_h_policy_history_scored_all {
  label: "Home Policy History Scored (All)"
}
# explore: lk_h_adjustment_summary {}
explore: lk_h_cancel_history {
  label: "Home Cancel History"
}
# explore: lk_h_cancel_summary {}
explore: lk_h_expoclm_mth {
  label: "Home Expoclm Month"
}
explore: lk_h_forecast {
  label: "Home Forecast"
}
# explore: lk_h_policy_history_scored {}
# explore: lk_h_policy_summary {}
# explore: lk_h_retention {}
# explore: lk_h_retention_summary {}
explore: lk_h_tcs_claims {
  label: "Home TCS Claims"
}

explore: lk_h_tcs_claims_excess {
  label: "Home TCS Claims - Excess Issue"
}
