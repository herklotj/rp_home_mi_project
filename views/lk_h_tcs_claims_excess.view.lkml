view: lk_h_tcs_claims_excess {
  derived_table: {
    sql:

  SELECT *
  FROM (SELECT a.*,
               b.tia_transation_no AS tia_transation_no_e,
               b.p_volxsbds AS volxs_bds,
               b.p_volxscts AS volxs_cts,
               b.renewal_date,
               timestampadd(YEAR,-1,b.renewal_date) AS policy_year_start
        FROM actian.lk_h_tcs_claims a
          LEFT JOIN actian.home_aau_excess b ON a.uw_policy_no = b.uw_policy_no) x
  WHERE tia_transation_no_e IS NOT NULL
  AND   policy_year_start < incidentdate
  AND   incidentdate < renewal_date

    ;;
  }

  dimension: chargeable_incident_flag {
    label: "Chargeable Incident Flag"
    type: yesno
    sql: ${TABLE}.tcs_claims = 1 ;;
    group_label: "Claim Flags"
  }

  dimension: settled_claim_flag {
    label: "Settled Claim Flag"
    type: yesno
    sql:${TABLE}.FCA_ACCEPTED_PAID + ${TABLE}.FCA_REJECTED + ${TABLE}.FCA_OTHER_SETTLED > 0 ;;
    group_label: "Claim Flags"
  }

  dimension: lcm_label {
    label: "Last Calendar Month"
    type: string
    sql: CASE WHEN (lk_h_tcs_claims.load_dttm  IS NOT NULL) THEN 'Last Calendar Month' else '' end ;;
    hidden: yes
  }

  measure: load_dttm_count {
    label: "DATA_LOOP_COUNT"
    type: count_distinct
    sql: ${TABLE}.load_dttm ;;
    hidden: yes
  }


  dimension: claim_peril {
    label: "Claim Peril"
    type: string
    sql: ${TABLE}.claim_peril ;;
    group_label: "Peril"
  }

  dimension: claimnumber {
    label: "Claim Number"
    type: string
    sql: ${TABLE}.claimnumber ;;
  }

  dimension_group: closeddate {
    label: "Closed"
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
    sql: ${TABLE}.closeddate ;;
    group_label: "Dates"
  }

  dimension: cover {
    label: "Cover"
    type: string
    sql: ${TABLE}.cover ;;
  }

  dimension: cover_type {
    label: "Cover Type"
    type: string
    sql: ${TABLE}.cover_type ;;
  }

  dimension: excess_bds {
    label: "Excess - BDS"
    type: number
    sql: ${TABLE}.excess_bds ;;
    value_format_name: gbp_0
  }

  dimension: excess_cts {
    label: "Excess - CTS"
    type: number
    sql: ${TABLE}.excess_cts ;;
    value_format_name: gbp_0
  }

  dimension: fca_accepted_paid {
    label: "FCA Accepted Paid"
    type: yesno
    sql: ${TABLE}.fca_accepted_paid = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_other_settled {
    label: "FCA Other Settled"
    type: yesno
    sql: ${TABLE}.fca_other_settled = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_registered_claim {
    label: "FCA Registered Claim"
    type: yesno
    sql: ${TABLE}.fca_registered_claims = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_registered_enquiry {
    label: "FCA Registered Enquiry"
    type: yesno
    sql: ${TABLE}.fca_registered_enquiries = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_rejected {
    label: "FCA Rejected"
    type: yesno
    sql: ${TABLE}.fca_rejected = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_rejected_excess {
    label: "FCA Rejected Excess"
    type: yesno
    sql: ${TABLE}.fca_rejected_excess = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension: fca_rejected_fraud {
    label: "FCA Rejected Fraud"
    type: yesno
    sql: ${TABLE}.fca_rejected_fraud = 1 ;;
    group_label: "FCA Claim Flags"
  }

  dimension_group: fnolcompleteddate {
    label: "FNOL Completed"
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
    sql: ${TABLE}.fnolcompleteddate ;;
    group_label: "Dates"
  }

  dimension_group: fnolstarteddate {
    label: "FNOL Start"
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
    sql: ${TABLE}.fnolstarteddate ;;
    group_label: "Dates"
  }

  dimension_group: incidentdate {
    label: "Incident"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.incidentdate ;;
    group_label: "Dates"
  }

  dimension: inmonth_tcs_claim {
    label: "In-Month TCS Claims"
    type: yesno
    sql: ${TABLE}.inmonth_tcs_claims = 1 ;;
    group_label: "In-Month Claim Flags"
  }

  dimension: inmonth_tcs_claim_nc {
    label: "In-Month TCS Claim NC"
    type: yesno
    sql: ${TABLE}.inmonth_tcs_claims_nc = 1 ;;
    group_label: "In-Month Claim Flags"
  }

  dimension: inmonth_tcs_enquiry {
    label: "In-Month TCS Enquiry"
    type: yesno
    sql: ${TABLE}.inmonth_tcs_enquiries = 1 ;;
    group_label: "In-Month Claim Flags"
  }


  dimension_group: load_dttm {
    label: "Load DTTM"
    type: time
    timeframes: [
      raw,
      time,
      date
    ]
    sql: ${TABLE}.load_dttm ;;
    group_label: "Dates"
  }

  dimension_group: notificationdate {
    label: "Notification Date"
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
    sql: ${TABLE}.notificationdate ;;
    group_label: "Dates"
  }

  dimension_group: notificationmonth {
    label: "FNOL Month"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ;;
    group_label: "Dates"
  }

  dimension_group: notificationmonthfees {
    label: "FNOL Month (Fees)"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.notificationmonthfees AS TIMESTAMP WITHOUT TIME ZONE) ;;
    group_label: "Dates"
    hidden: yes
  }

  dimension: notificationweek {
    label: "FNOL Week"
    type: string
    sql: ${TABLE}.notificationweek ;;
    group_label: "Dates"
  }

  dimension: peril {
    label: "TCS Peril"
    type: string
    sql: ${TABLE}.peril ;;
    group_label: "Peril"
  }

  dimension_group: recloseddate {
    label: "Re-closed Date"
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
    sql: ${TABLE}.recloseddate ;;
    group_label: "Dates"
  }

  dimension_group: registeredmonth {
    label: "Registered Month"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.registeredmonth AS TIMESTAMP WITHOUT TIME ZONE) ;;
    group_label: "Dates"
  }

  dimension_group: reopeneddate {
    label: "Re-opened Date"
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
    sql: ${TABLE}.reopeneddate ;;
    group_label: "Dates"
  }

  dimension: reservestatus {
    label: "Reserve Status"
    type: string
    sql: ${TABLE}.reservestatus ;;
  }


  dimension_group: settledmonth {
    label: "Settled Month"
    type: time
    timeframes: [
      month,
      quarter,
      year
    ]
    sql: CAST(${TABLE}.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ;;
    group_label: "Dates"
  }

  dimension: stage {
    label: "Stage"
    type: string
    sql: ${TABLE}.stage ;;
  }

  dimension_group: stageonecompleteddate {
    label: "Stage One Completed Date"
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
    sql: ${TABLE}.stageonecompleteddate ;;
    group_label: "Dates"
  }

  dimension: status {
    label: "Status"
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subperil {
    label: "TCS Sub-Peril"
    type: string
    sql: ${TABLE}.subperil ;;
    group_label: "Peril"
  }

  dimension: substatus {
    label: "Sub-Status"
    type: string
    sql: ${TABLE}.substatus ;;
  }

  dimension: uw_policy_no {
    label: "UW Policy Number"
    type: string
    sql: ${TABLE}.uw_policy_no ;;
  }

  dimension: claim_value {
    description: "Claim Value"
    type: tier
    style:  integer
    tiers: [100,10000,50000]
    value_format_name: gbp_0
    sql: ${TABLE}.totalincurred ;;
  }


  #### Measures ###

  ## Claims ##

  measure: claim_bds_sum {
    label: "Claim BDS"
    type: sum
    sql: ${TABLE}.claim_bds ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_ad_sum {
    label: "Claim BDS AD"
    type: sum
    sql: ${TABLE}.claim_bds_ad ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_eow_sum {
    label: "Claim BDS EoW"
    type: sum
    sql: ${TABLE}.claim_bds_eow ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_fire_sum {
    label: "Claim BDS Fire"
    type: sum
    sql: ${TABLE}.claim_bds_fire ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_flood_sum{
    label: "Claim BDS Flood"
    type: sum
    sql: ${TABLE}.claim_bds_flood ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_other_sum {
    label: "Claim BDS Other"
    type: sum
    sql: ${TABLE}.claim_bds_other ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_storm_sum {
    label: "Claim BDS Storm"
    type: sum
    sql: ${TABLE}.claim_bds_storm ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_subsidence_sum {
    label: "Claim BDS Subsidence"
    type: sum
    sql: ${TABLE}.claim_bds_subsidence ;;
    group_label: "Claim Counts"
  }

  measure: claim_bds_theft_sum {
    label: "Claim BDS Theft"
    type: sum
    sql: ${TABLE}.claim_bds_theft ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_sum {
    label: "Claim CTS"
    type: sum
    sql: ${TABLE}.claim_cts ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_ad_sum {
    label: "Claim CTS AD"
    type: sum
    sql: ${TABLE}.claim_cts_ad ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_eow_sum {
    label: "Claim CTS EoW"
    type: sum
    sql: ${TABLE}.claim_cts_eow ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_fire_sum {
    label: "Claim CTS Fire"
    type: sum
    sql: ${TABLE}.claim_cts_fire ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_flood_sum {
    label: "Claim CTS Flood"
    type: sum
    sql: ${TABLE}.claim_cts_flood ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_other_sum {
    label: "Claim CTS Other"
    type: sum
    sql: ${TABLE}.claim_cts_other ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_pps_sum {
    label: "Claim CTS PPS"
    type: sum
    sql: ${TABLE}.claim_cts_pps ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_storm_sum {
    label: "Claim CTS Storm"
    type: sum
    sql: ${TABLE}.claim_cts_storm ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_subsidence_sum {
    label: "Claim CTS Subsidence"
    type: sum
    sql: ${TABLE}.claim_cts_subsidence ;;
    group_label: "Claim Counts"
  }

  measure: claim_cts_theft_sum {
    label: "Claim CTS Theft"
    type: sum
    sql: ${TABLE}.claim_cts_theft ;;
    group_label: "Claim Counts"
  }

  ### Incurred ###


  measure: total_incurred {
    label: "Incurred - Total"
    type: sum
    sql: ${TABLE}.totalincurred ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_sum {
    label: "Incurred - BDS"
    type: sum
    sql: ${TABLE}.incurred_bds ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_cap50 {
    label: "Incurred - BDS CAP50K"
    type: sum
    sql: ${TABLE}.incurred_bds_cap50k ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_cap100 {
    label: "Incurred - CTS CAP100K"
    type: sum
    sql: ${TABLE}.incurred_cts_cap100k ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_ad_sum {
    label: "Incurred BDS AD"
    type: sum
    sql: ${TABLE}.incurred_bds_ad ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_eow_sum {
    label: "Incurred BDS EoW"
    type: sum
    sql: ${TABLE}.incurred_bds_eow ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_fire_sum {
    label: "Incurred BDS Fire"
    type: sum
    sql: ${TABLE}.incurred_bds_fire ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_flood_sum{
    label: "Incurred BDS Flood"
    type: sum
    sql: ${TABLE}.incurred_bds_flood ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_other_sum {
    label: "Incurred BDS Other"
    type: sum
    sql: ${TABLE}.incurred_bds_other ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_storm_sum {
    label: "Incurred BDS Storm"
    type: sum
    sql: ${TABLE}.incurred_bds_storm ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_subsidence_sum {
    label: "Incurred BDS Subsidence"
    type: sum
    sql: ${TABLE}.incurred_bds_subsidence ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_bds_theft_sum {
    label: "Incurred BDS Theft"
    type: sum
    sql: ${TABLE}.incurred_bds_theft ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_sum {
    label: "Incurred - CTS"
    type: sum
    sql: ${TABLE}.incurred_cts ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_cap15 {
    label: "Incurred - CTS CAP15K"
    type: sum
    sql: ${TABLE}.incurred_cts_cap15k ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_cap25 {
    label: "Incurred - CTS CAP25K"
    type: sum
    sql: ${TABLE}.incurred_cts_cap25k ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_ad_sum {
    label: "Incurred CTS AD"
    type: sum
    sql: ${TABLE}.incurred_cts_ad ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_eow_sum {
    label: "Incurred CTS EoW"
    type: sum
    sql: ${TABLE}.incurred_cts_eow ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_fire_sum {
    label: "Incurred CTS Fire"
    type: sum
    sql: ${TABLE}.incurred_cts_fire ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_flood_sum {
    label: "Incurred CTS Flood"
    type: sum
    sql: ${TABLE}.incurred_cts_flood ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_other_sum {
    label: "Incurred CTS Other"
    type: sum
    sql: ${TABLE}.incurred_cts_other ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_pps_sum {
    label: "Incurred CTS PPS"
    type: sum
    sql: ${TABLE}.incurred_cts_pps ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_storm_sum {
    label: "Incurred CTS Storm"
    type: sum
    sql: ${TABLE}.incurred_cts_storm ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_subsidence_sum {
    label: "Incurred CTS Subsidence"
    type: sum
    sql: ${TABLE}.incurred_cts_subsidence ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  measure: incurred_cts_theft_sum {
    label: "Incurred CTS Theft"
    type: sum
    sql: ${TABLE}.incurred_cts_theft ;;
    value_format_name: "gbp_0"
    group_label: "Incurred"
  }

  ### Payment Amounts ###

  measure: payment_amount_bds {
    label: "Payment Amount BDS"
    type: sum
    sql: ${TABLE}.paymentamount_bds ;;
    value_format_name: "gbp_0"
    group_label: "Payment Amounts"
  }

  measure: payment_amount_cts {
    label: "Payment Amount CTS"
    type: sum
    sql: ${TABLE}.paymentamount_cts ;;
    value_format_name: "gbp_0"
    group_label: "Payment Amounts"
  }

  measure: payment_amount_pps {
    label: "Payment Amount PPS"
    type: sum
    sql: ${TABLE}.paymentamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Payment Amounts"

  }

  measure: payment_amount_tot {
    label: "Payment Amount TOT"
    type: sum
    sql: ${TABLE}.paymentamount_bds + ${TABLE}.paymentamount_cts + ${TABLE}.paymentamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Payment Amounts"
  }

  ### FCA Metrics ###


  measure: fca_accepted_paid_amount {
    label: "FCA Accepted Paid Amount"
    type: sum
    sql: ${TABLE}.fca_accepted_paid_amount ;;
    value_format_name: "gbp_0"
    group_label: "FCA Metrics"
  }

  measure: fca_accepted_paid_claims {
    label: "FCA Accepted Paid Claims"
    type: sum
    sql: ${TABLE}.fca_accepted_paid ;;
    group_label: "FCA Metrics"
  }

  measure: fca_other_settled_claims {
    label: "FCA Other Settled Claims"
    type: sum
    sql: ${TABLE}.fca_other_settled ;;
    group_label: "FCA Metrics"
  }

  measure: fca_registered_claims {
    label: "FCA Registered Claims"
    type: sum
    sql: ${TABLE}.fca_registered_claims ;;
    group_label: "FCA Metrics"
  }

  measure: fca_registered_enquiries {
    label: "FCA Registered Enquiries"
    type: sum
    sql: ${TABLE}.fca_registered_enquiries ;;
    group_label: "FCA Metrics"
  }

  measure: fca_rejected_claim {
    label: "FCA Rejected Claims"
    type: sum
    sql: ${TABLE}.fca_rejected ;;
    group_label: "FCA Metrics"
  }

  measure: fca_rejected_excess_claims{
    label: "FCA Rejected Excess Claims"
    type: sum
    sql: ${TABLE}.fca_rejected_excess ;;
    group_label: "FCA Metrics"
  }

  measure: fca_rejected_fraud_claims{
    label: "FCA Rejected Fraud Claims"
    type: sum
    sql: ${TABLE}.fca_rejected_fraud ;;
    group_label: "FCA Metrics"
  }

  ### Reserve Amounts ###

  measure: reserve_amount_bds{
    label: "Reserve Amount BDS"
    type: sum
    sql: ${TABLE}.reserveamount_bds ;;
    value_format_name: "gbp_0"
    group_label: "Reserves"
  }

  measure: reserve_amount_cts{
    label: "Reserve Amount CTS"
    type: sum
    sql: ${TABLE}.reserveamount_cts ;;
    value_format_name: "gbp_0"
    group_label: "Reserves"
  }

  measure: reserve_amount_pps{
    label: "Reserve Amount PPS"
    type: sum
    sql: ${TABLE}.reserveamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Reserves"
  }

  measure: reserve_amount_tot {
    label: "Reserve Amount TOT"
    type: sum
    sql: ${TABLE}.reserveamount_bds + ${TABLE}.reserveamount_cts + ${TABLE}.reserveamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Reserves"
  }

  ### Excess Amounts ###

  measure: bds_excess{
    label: "Excess Paid BDS"
    type: sum
    sql: ${TABLE}.excess_bds ;;
    value_format_name: "gbp_0"
    group_label: "Excess Amounts"
  }

  measure: cts_excess{
    label: "Excess Paid CTS"
    type: sum
    sql: ${TABLE}.excess_cts ;;
    value_format_name: "gbp_0"
    group_label: "Excess Amounts"
  }

  measure: tot_excess{
    label: "Excess TOT"
    type: sum
    sql: ${TABLE}.excess_bds + ${TABLE}.excess_cts ;;
    value_format_name: "gbp_0"
    group_label: "Excess Amounts"
  }

  ### Recovery Amounts ###

  measure: recovery_paymentamount_bds{
    label: "Recovery Payment Amount BDS"
    type: sum
    sql: ${TABLE}.recoverypaymentamount_bds ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_paymentamount_cts{
    label: "Recovery Payment Amount CTS"
    type: sum
    sql: ${TABLE}.recoverypaymentamount_cts ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_paymentamount_pps{
    label: "Recovery Payment Amount PPS"
    type: sum
    sql: ${TABLE}.recoverypaymentamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_paymentamount_tot {
    label: "Recovery Payment Amount TOT"
    type: sum
    sql: ${TABLE}.recoverypaymentamount_bds + ${TABLE}.recoverypaymentamount_cts + ${TABLE}.recoverypaymentamount_pps  ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_bds{
    label: "Recovery Reserve BDS"
    type: sum
    sql: ${TABLE}.recoveryreserveamount_bds ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_cts{
    label: "Recovery Reserve CTS"
    type: sum
    sql: ${TABLE}.recoveryreserveamount_cts ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_pps{
    label: "Recovery Reserve PPS"
    type: sum
    sql: ${TABLE}.recoveryreserveamount_pps ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_tot {
    label: "Recovery Reserve TOT"
    type: sum
    sql: ${TABLE}.recoveryreserveamount_bds + ${TABLE}.recoveryreserveamount_cts + ${TABLE}.recoveryreserveamount_pps  ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  ### TCS Measures ###

  measure: tcsclaims {
    label: "Chargeable Incidents"
    type: sum
    sql: ${TABLE}.tcs_claims ;;
  }

  measure: tcsclaims_nc {
    label: "Non-Chargeable Incidents"
    type: sum
    sql: ${TABLE}.tcs_claims_nc ;;
  }

  measure: tcsenquiries {
    label: "TCS Enquiries"
    type: sum
    sql: ${TABLE}.tcs_enquiries ;;
  }

  measure: tcsincidents {
    label: "TCS Incidents"
    type: sum
    sql: ${TABLE}.TCS_CLAIMS + ${TABLE}.TCS_CLAIMS_NC + ${TABLE}.TCS_ENQUIRIES ;;
  }

  measure: tcsincidents_undev {
    label: "TCS Incidents (Undeveloped)"
    type: sum
    sql: ${TABLE}.INMONTH_TCS_CLAIMS + ${TABLE}.INMONTH_TCS_CLAIMS_NC + ${TABLE}.INMONTH_TCS_ENQUIRIES ;;
  }

  measure: tcsincidents_weather {
    label: "TCS Incidents - Weather"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('FLOOD','STORM')
        then ${TABLE}.TCS_CLAIMS + ${TABLE}.TCS_CLAIMS_NC + ${TABLE}.TCS_ENQUIRIES
        else null end;;
  }

  measure: tcsincidents_weather_undev {
    label: "TCS Incidents - Weather (Undeveloped)"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('FLOOD','STORM')
        then ${TABLE}.INMONTH_TCS_CLAIMS + ${TABLE}.INMONTH_TCS_CLAIMS_NC + ${TABLE}.INMONTH_TCS_ENQUIRIES
        else null end;;
  }

  measure: tcsincidents_nonweather {
    label: "TCS Incidents - Non-Weather"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('AD','EOW','THEFT','OTHER','FIRE','SUBSIDENCE')
        then ${TABLE}.TCS_CLAIMS + ${TABLE}.TCS_CLAIMS_NC + ${TABLE}.TCS_ENQUIRIES
        else null end;;
  }

  measure: tcsincidents_nonweather_undev {
    label: "TCS Incidents - Non-Weather (Undeveloped)"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('AD','EOW','THEFT','OTHER','FIRE','SUBSIDENCE')
        then ${TABLE}.INMONTH_TCS_CLAIMS + ${TABLE}.INMONTH_TCS_CLAIMS_NC + ${TABLE}.INMONTH_TCS_ENQUIRIES
        else null end;;
  }

  measure: chargeable_weather {
    label: "Chargeable Incidents - Weather"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('FLOOD','STORM')
      then ${TABLE}.TCS_CLAIMS else null end;;
  }

  measure: chargeable_nonweather {
    label: "Chargeable Incidents - Non-Weather"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL in('AD','EOW','THEFT','OTHER','FIRE','SUBSIDENCE')
      then ${TABLE}.TCS_CLAIMS else null end;;
  }

  ### Insurer Insights ###

  measure: reported_incidents {
    label: "Reported Incidents"
    type: sum
    sql: ${TABLE}.FCA_REGISTERED_CLAIMS + ${TABLE}.FCA_REGISTERED_ENQUIRIES ;;
  }

  measure: settled_claims {
    label: "Settled Claims"
    type: sum
    sql: ${TABLE}.FCA_ACCEPTED_PAID + ${TABLE}.FCA_REJECTED + ${TABLE}.FCA_OTHER_SETTLED ;;
  }

  measure: avg_paid_amount {
    label: "Average Paid Amount"
    type: number
    sql: 1.0*${fca_accepted_paid_amount}/nullif(${fca_accepted_paid_claims},0) ;;
    value_format_name: "gbp_0"
  }

  measure: reported_incidents_12m {
    label: "Reported Incidents 12M Rolling"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,12, TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REGISTERED_CLAIMS + ${TABLE}.FCA_REGISTERED_ENQUIRIES else 0 end ;;
    hidden: yes
  }

  measure: reported_incidents_lcm {
    label: "Reported Incidents LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REGISTERED_CLAIMS + ${TABLE}.FCA_REGISTERED_ENQUIRIES else 0 end ;;
    hidden: yes
  }

  measure: registered_claims_12m {
    label: "Registered Claims 12M Rolling"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.registeredmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.registeredmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,12, TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REGISTERED_CLAIMS else 0 end ;;
    hidden: yes
  }

  measure: registered_claims_lcm {
    label: "Registered Claims LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.registeredmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.registeredmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REGISTERED_CLAIMS else 0 end ;;
    hidden: yes
  }

  measure: rejected_claims_12m {
    label: "Rejected Claims 12M Rolling"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,12, TIMESTAMPADD(month,-12, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REJECTED else 0 end ;;
    hidden: yes
  }

  measure: rejected_claims_lcm {
    label: "Rejected Claims LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_REJECTED else 0 end ;;
    hidden: yes
  }

  measure: claims_handing_fee {
    label: "Claims Handling Fee"
    type: sum
    sql: case when (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2020-02-01'))
      THEN ${TABLE}.tcs_claims*175 else ${TABLE}.tcs_claims*210 end ;;
    value_format_name: gbp_0
    group_label: "Incurred"
  }

  measure: claims_handing_fee_lcm {
    label: "Claims Handling Fee LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
          THEN
         case when (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2020-02-01'))
          THEN ${TABLE}.tcs_claims*175 else ${TABLE}.tcs_claims*210 end
         else 0 end;;
    value_format_name: gbp_0
    group_label: "Incurred"
    hidden: yes
  }

  measure: chargeable_incidents_lcm {
    label: "Chargeable Incidents LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.notificationmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.tcs_claims else 0 end ;;
    hidden: yes
  }

  measure: settled_claims_lcm {
    label: "Settled Claims LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_ACCEPTED_PAID + ${TABLE}.FCA_REJECTED + ${TABLE}.FCA_OTHER_SETTLED else 0 end ;;
    hidden: yes
  }

  measure: accepted_paid_claims_lcm {
    label: "Accepted Paid Claims LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.FCA_ACCEPTED_PAID else 0 end ;;
    hidden: yes
  }

  measure: accepted_paid_amount_lcm {
    label: "Accepted Paid Amount LCM"
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) )))))
      THEN ${TABLE}.fca_accepted_paid_amount else 0 end ;;
    value_format_name: gbp_0
    hidden: yes
  }

  measure: bds_days_claim_open_LCM {
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) ))))
         AND (${TABLE}.FCA_ACCEPTED_PAID = 1) AND (${TABLE}.incurred_bds > 0))
      THEN to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: fca_accepted_paid_bds_LCM {
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) ))))
         AND (${TABLE}.FCA_ACCEPTED_PAID = 1) AND (${TABLE}.incurred_bds > 0))
      THEN ${TABLE}.FCA_ACCEPTED_PAID else null end ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: cts_days_claim_open_LCM {
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) ))))
         AND (${TABLE}.FCA_ACCEPTED_PAID = 1) AND (${TABLE}.incurred_cts > 0))
      THEN to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: fca_accepted_paid_cts_LCM {
    type: sum
    sql: case when (((CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) >= ((TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ))) AND (CAST(lk_h_tcs_claims.settledmonth AS TIMESTAMP WITHOUT TIME ZONE) ) < ((TIMESTAMPADD(month,1, TIMESTAMPADD(month,-1, DATE_TRUNC('month', DATE_TRUNC('day', CURRENT_TIMESTAMP)) ) ))))
         AND (${TABLE}.FCA_ACCEPTED_PAID = 1) AND (${TABLE}.incurred_cts > 0))
      THEN ${TABLE}.FCA_ACCEPTED_PAID else null end ;;
    value_format_name: decimal_0
    hidden: yes
  }





  measure: settled_gt_10000 {
    label: "Settled Claims > £10,000"
    type: sum
    sql: case when lk_h_tcs_claims.fca_accepted_paid_amount > 10000 then (${TABLE}.FCA_ACCEPTED_PAID + ${TABLE}.FCA_REJECTED + ${TABLE}.FCA_OTHER_SETTLED) else 0 end ;;
  }

  ### Claim Lifecycles ###

  measure: days_claim_open {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 or ${TABLE}.FCA_REJECTED = 1 or ${TABLE}.FCA_OTHER_SETTLED = 1 then
      to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end;;
    hidden: yes
  }

  measure: claim_lifecycle {
    label: "Claim Lifeycle"
    type: number
    sql: 1.0*${days_claim_open}/nullif(${settled_claims},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
  }

  measure: days_claim_open_nonnil {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 then
      to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end;;
    hidden: yes
  }

  measure: claim_lifecycle_nn {
    label: "Claim Lifecycle (Non-nil)"
    type: number
    sql: 1.0*${days_claim_open_nonnil}/nullif(${fca_accepted_paid_claims},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
  }

  measure: bds_days_claim_open {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 and ${TABLE}.incurred_bds > 0 then
      to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end;;
    hidden: yes
  }

  measure: fca_accepted_paid_bds {
    type: sum
    sql: case when ${TABLE}.incurred_bds > 0 then
      ${TABLE}.FCA_ACCEPTED_PAID else 0 end;;
    hidden: yes
  }

  measure: bds_claim_lifecycle_nn {
    label: "Claim Lifecycle - BDS (Non-nil)"
    type: number
    sql: 1.0*${bds_days_claim_open}/nullif(${fca_accepted_paid_bds},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
  }

  measure: cts_days_claim_open {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 and ${TABLE}.incurred_cts > 0 then
      to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate) else null end;;
    hidden: yes
  }

  measure: fca_accepted_paid_cts {
    type: sum
    sql: case when ${TABLE}.incurred_cts > 0 then
      ${TABLE}.FCA_ACCEPTED_PAID else 0 end;;
    hidden: yes
  }

  measure: cts_claim_lifecycle_nn {
    label: "Claim Lifecycle - CTS (Non-nil)"
    type: number
    sql: 1.0*${cts_days_claim_open}/nullif(${fca_accepted_paid_cts},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
  }

  measure: days_claim_reopen {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 or ${TABLE}.FCA_REJECTED = 1 or ${TABLE}.FCA_OTHER_SETTLED = 1 then
      to_date(${TABLE}.recloseddate) - to_date(${TABLE}.reopeneddate) else null end;;
    hidden: yes
  }

  measure: reopen_claim_lifecycle {
    label: "Re-open Lifeycle"
    type: number
    sql: 1.0*${days_claim_reopen}/nullif(${settled_claims},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
    hidden: yes
    ### Not useful - add exclusion for reopened claims
  }

  measure: true_days_claim_open {
    type: sum
    sql: case when ${TABLE}.FCA_ACCEPTED_PAID = 1 or ${TABLE}.FCA_REJECTED = 1 or ${TABLE}.FCA_OTHER_SETTLED = 1 then
      ((to_date(${TABLE}.closeddate) - to_date(${TABLE}.notificationdate))) + (COALESCE((to_date(${TABLE}.recloseddate) - to_date(${TABLE}.reopeneddate)),0)) else null end;;
    hidden: yes
  }

  measure: true_claim_lifecycle {
    label: "True Claim Lifeycle"
    type: number
    sql: 1.0*${true_days_claim_open}/nullif(${settled_claims},0) ;;
    value_format_name: decimal_0
    group_label: "Claim Lifecycles"
  }

  measure: peril_excess {
    label: "Peril Excess"
    type: sum
    sql: case when ${TABLE}.CLAIM_PERIL = 'SUBSIDENCE' then 1000
              when ${TABLE}.CLAIM_PERIL = 'EOW' then 250
              else 100 end ;;
    value_format_name: gbp_0
    hidden: yes
  }

  measure: excess_required_bds {
    label: "Required Excess - BDS"
    type: sum
    sql: case when ${TABLE}.paymentamount_bds > 0 and ${TABLE}.substatus = 'Settled - Paid' then ${TABLE}.volxs_bds + (case when ${TABLE}.CLAIM_PERIL = 'SUBSIDENCE' then 1000
              when ${TABLE}.CLAIM_PERIL = 'EOW' then 250 else 100 end) else 0 end ;;
    value_format_name: gbp_0
    hidden: no
  }

  measure: excess_required_cts {
    label: "Required Excess - CTS"
    type: sum
    sql: case when (${TABLE}.paymentamount_cts > 0 or ${TABLE}.paymentamount_pps > 0) and ${TABLE}.substatus = 'Settled - Paid' then ${TABLE}.volxs_cts + (case when ${TABLE}.CLAIM_PERIL = 'SUBSIDENCE' then 1000
              when ${TABLE}.CLAIM_PERIL = 'EOW' then 250 else 100 end) else 0 end ;;
    value_format_name: gbp_0
    hidden: no
  }






}
