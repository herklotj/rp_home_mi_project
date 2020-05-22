view: lk_h_policy_history {
  derived_table: {
    sql:

    SELECT *
    FROM actian.lk_h_policy_history_scored
    WHERE SCHEDULE_COVER_START_DTTM = ANNUAL_COVER_START_DTTM
    AND   CFI_IND = 0
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

  dimension: aauicl_modelled_loss_ratio_inf {
    description: "Modelled Net Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_written_premium_bds + ${TABLE}.net_written_premium_cts),0));;
  }

  dimension: aauicl_modelled_loss_ratio_wlc {
    description: "Modelled Net Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_written_premium_bds + ${TABLE}.net_written_premium_cts),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_inf {
    description: "Modelled Gross Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_written_premium_bds + ${TABLE}.net_written_premium_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_wlc {
    description: "Modelled Gross Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_written_premium_bds + ${TABLE}.net_written_premium_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  ### Measures

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

  measure: broker_commission_bds {
    label: "Commission BDS"
    type: sum
    sql:  ${TABLE}.broker_commission_bds ;;
    value_format_name: decimal_0
  }

  measure: broker_commission_cts {
    label: "Commission CTS"
    type: sum
    sql:  ${TABLE}.broker_commission_cts ;;
    value_format_name: decimal_0
  }

  measure: broker_commission_tot {
    label: "Commission TOT"
    type: sum
    sql:  ${TABLE}.broker_commission_bds + ${TABLE}.broker_commission_cts ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_inf_bds {
    label: "RPM Incurred INF BDS"
    type: sum
    sql:  ${TABLE}.rpm_inc_inf_bds ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_inf_cts {
    label: "RPM Incurred INF CTS"
    type: sum
    sql:  ${TABLE}.rpm_inc_inf_cts ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_inf_tot {
    label: "RPM Incurred INF TOT"
    type: sum
    sql:  ${TABLE}.rpm_inc_inf_bds + ${TABLE}.rpm_inc_inf_cts ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_wlc_bds {
    label: "RPM Incurred WLC BDS"
    type: sum
    sql:  ${TABLE}.rpm_inc_wlc_bds ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_wlc_cts {
    label: "RPM Incurred WLC CTS"
    type: sum
    sql:  ${TABLE}.rpm_inc_wlc_cts ;;
    value_format_name: decimal_0
  }

  measure: rpm_inc_wlc_tot {
    label: "RPM Incurred WLC TOT"
    type: sum
    sql:  ${TABLE}.rpm_inc_wlc_bds + ${TABLE}.rpm_inc_wlc_cts ;;
    value_format_name: decimal_0
  }



}
