view: lk_h_adjustment_summary {
  sql_table_name: dbuser.sas_h_adjustment_summary ;;

  dimension: aa_membership {
    type: string
    sql: ${TABLE}.aa_membership ;;
  }

  dimension: aa_tenure {
    type: number
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: aauicl_scheme {
    type: number
    sql: ${TABLE}.aauicl_scheme ;;
  }

  dimension: broker_nb_rb {
    type: string
    sql: ${TABLE}.broker_nb_rb ;;
  }

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: cover_type {
    type: string
    sql: ${TABLE}.cover_type ;;
  }

  dimension: cover_type_customer {
    type: string
    sql: ${TABLE}.cover_type_customer ;;
  }

  dimension: installment_flag {
    type: string
    sql: ${TABLE}.installment_flag ;;
  }

  dimension: insurer_nb_rb {
    type: string
    sql: ${TABLE}.insurer_nb_rb ;;
  }

  dimension_group: load_dttm {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.load_dttm ;;
  }

  dimension: mta_add_broker_commission {
    type: number
    sql: ${TABLE}.mta_add_broker_commission ;;
  }

  dimension: mta_add_broker_commission_bds {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_bds ;;
  }

  dimension: mta_add_broker_commission_cts {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_cts ;;
  }

  dimension: mta_add_broker_commission_disc {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_disc ;;
  }

  dimension: mta_add_broker_commission_woff {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_woff ;;
  }

  dimension: mta_add_broker_commission_xfees {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_xfees ;;
  }

  dimension: mta_add_broker_iaf {
    type: number
    sql: ${TABLE}.mta_add_broker_iaf ;;
  }

  dimension: mta_add_broker_iaf_ipt {
    type: number
    sql: ${TABLE}.mta_add_broker_iaf_ipt ;;
  }

  dimension: mta_add_commission_aauicl {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl ;;
  }

  dimension: mta_add_commission_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl_bds ;;
  }

  dimension: mta_add_commission_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl_cts ;;
  }

  dimension: mta_add_commission_other {
    type: number
    sql: ${TABLE}.mta_add_commission_other ;;
  }

  dimension: mta_add_commission_other_bds {
    type: number
    sql: ${TABLE}.mta_add_commission_other_bds ;;
  }

  dimension: mta_add_commission_other_cts {
    type: number
    sql: ${TABLE}.mta_add_commission_other_cts ;;
  }

  dimension: mta_add_net_premium_aauicl {
    type: number
    sql: ${TABLE}.mta_add_net_premium_aauicl ;;
  }

  dimension: mta_add_net_premium_bds {
    type: number
    sql: ${TABLE}.mta_add_net_premium_bds ;;
  }

  dimension: mta_add_net_premium_cts {
    type: number
    sql: ${TABLE}.mta_add_net_premium_cts ;;
  }

  dimension: mta_add_net_premium_other {
    type: number
    sql: ${TABLE}.mta_add_net_premium_other ;;
  }

  dimension: mta_add_net_written_premium {
    type: number
    sql: ${TABLE}.mta_add_net_written_premium ;;
  }

  dimension: mta_add_premium_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_add_premium_aauicl_bds ;;
  }

  dimension: mta_add_premium_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_add_premium_aauicl_cts ;;
  }

  dimension: mta_add_premium_other_bds {
    type: number
    sql: ${TABLE}.mta_add_premium_other_bds ;;
  }

  dimension: mta_add_premium_other_cts {
    type: number
    sql: ${TABLE}.mta_add_premium_other_cts ;;
  }

  dimension: mta_cov_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_cov_aauicl_bds ;;
  }

  dimension: mta_cov_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_cov_aauicl_cts ;;
  }

  dimension: mta_cov_bds {
    type: number
    sql: ${TABLE}.mta_cov_bds ;;
  }

  dimension: mta_cov_cts {
    type: number
    sql: ${TABLE}.mta_cov_cts ;;
  }

  dimension: mta_cov_other_bds {
    type: number
    sql: ${TABLE}.mta_cov_other_bds ;;
  }

  dimension: mta_cov_other_cts {
    type: number
    sql: ${TABLE}.mta_cov_other_cts ;;
  }

  dimension: mta_ind {
    type: number
    sql: ${TABLE}.mta_ind ;;
  }

  dimension_group: policy_mta_mth {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.policy_mta_mth ;;
  }

  dimension: policy_mta_yr {
    type: number
    sql: ${TABLE}.policy_mta_yr ;;
  }

  dimension_group: policy_start_mth {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.policy_start_mth ;;
  }

  dimension: policy_start_yr {
    type: number
    sql: ${TABLE}.policy_start_yr ;;
  }

  dimension: uw_tenure {
    type: number
    sql: ${TABLE}.uw_tenure ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
