view: lk_h_policy_history {


  derived_table: {
    sql: SELECT
          *
          from
         lk_h_policy_history
        where schedule_cover_start_dttm = annual_cover_start_dttm and status = 'P' and cfi_ind = 0

     ;;
  }


  dimension_group: policy_written_date {
    label: "Policy Written"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.transaction_date ;;
  }


  dimension_group: policy_start_date {
    label: "Policy Start"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.policy_start_date ;;
  }


  dimension: cfi_ind_lapse {
    label: "CFI IND Lapse"
    type: number
    sql: ${TABLE}.cfi_ind_lapse ;;
  }

  dimension: mta_ind {
    label: "MTA IND"
    type: number
    sql: ${TABLE}.mta_ind ;;
  }

  dimension: broker_nb_rb {
    label: "Broker NB/RB"
    type: string
    sql: ${TABLE}.broker_nb_rb ;;
  }

  dimension: insurer_nb_rb {
    label: "Insurer NB/RB"
    type: string
    sql: ${TABLE}.insurer_nb_rb ;;
  }

  dimension: channel {
    label: "Channel"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: cover_type {
    label: "Cover Type"
    type: string
    sql: ${TABLE}.cover_type ;;
  }

  dimension: cover_type_customer {
    label: "Cover Type Customer"
    type: string
    sql: ${TABLE}.cover_type_customer ;;
  }

  dimension: home_cover_level {
    label: "Home Cover Level"
    type: string
    sql: ${TABLE}.home_cover_level ;;
  }


  measure: broker_covers_bds {
    label: "Broker Covers BDS"
    type: sum
    sql: ${TABLE}.broker_ind_bds ;;
    value_format_name: decimal_0
  }

  measure: broker_covers_cts {
    label: "Broker Covers CTS"
    type: sum
    sql: ${TABLE}.broker_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: broker_covers_tot {
    label: "Broker Covers TOT"
    type: sum
    sql: ${TABLE}.broker_ind_bds + ${TABLE}.broker_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_bds {
    label: "AAUICL Covers BDS"
    type: sum
    sql: ${TABLE}.aauicl_ind_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_cts {
    label: "AAUICL Covers CTS"
    type: sum
    sql: ${TABLE}.aauicl_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_covers_tot {
    label: "AAUICL Covers TOT"
    type: sum
    sql: ${TABLE}.aauicl_ind_bds + ${TABLE}.aauicl_ind_cts ;;
    value_format_name: decimal_0
  }

  measure: cover_share_bds {
    label: "Cover Share BDS"
    type: number
    sql:  1.0*${aauicl_covers_bds}/nullif(${broker_covers_bds},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_cts {
    label: "Cover Share CTS"
    type: number
    sql:  1.0*${aauicl_covers_cts}/nullif(${broker_covers_cts},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_tot {
    label: "Cover Share TOT"
    type: number
    sql:  1.0*${aauicl_covers_tot}/nullif(${broker_covers_tot},0) ;;
    value_format_name: percent_1
  }

  measure: net_premium_bds {
    label: "Net Written Premium BDS"
    type: sum
    sql:  ${TABLE}.net_written_premium_bds ;;
    value_format_name: decimal_0
  }

  measure: net_premium_cts {
    label: "Net Written Premium CTS"
    type: sum
    sql:  ${TABLE}.net_written_premium_cts ;;
    value_format_name: decimal_0
  }

  measure: net_premium_tot {
    label: "Net Written Premium TOT"
    type: sum
    sql:  ${TABLE}.net_written_premium_bds + ${TABLE}.net_written_premium_cts ;;
    value_format_name: decimal_0
  }

  measure: avg_premium_bds {
    label: "Average Premium BDS"
    type: number
    sql:  1.0*${net_premium_bds}/nullif(${broker_covers_bds},0) ;;
    value_format_name: decimal_0
  }

  measure: avg_premium_cts {
    label: "Average Premium CTS"
    type: number
    sql:  1.0*${net_premium_cts}/nullif(${broker_covers_cts},0) ;;
    value_format_name: decimal_0
  }






  measure: count {
    type: count
    drill_fields: []
  }
}
