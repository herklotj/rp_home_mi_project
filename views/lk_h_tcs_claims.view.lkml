view: lk_h_tcs_claims {
  sql_table_name: actian.lk_h_tcs_claims ;;

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
    sql: CASE WHEN (lk_h_tcs_claims.load_dttm  IS NOT NULL) THEN 'Last Calendar Month' else ' ' end ;;
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
      year
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
    label: "Notification Week"
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

    ### Excess Amounts ###

  measure: bds_excess{
    label: "BDS Excess"
    type: sum
    sql: ${TABLE}.excess_bds ;;
    value_format_name: "gbp_0"
    group_label: "Excess Amounts"
  }

  measure: cts_excess{
    label: "CTS Excess"
    type: sum
    sql: ${TABLE}.excess_cts ;;
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

  measure: recovery_reserve_bds{
    label: "Recovery Reserve BDS"
    type: sum
    sql: ${TABLE}.recoveryreserve_bds ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_cts{
    label: "Recovery Reserve CTS"
    type: sum
    sql: ${TABLE}.recoveryreserve_cts ;;
    value_format_name: "gbp_0"
    group_label: "Recoveries"
  }

  measure: recovery_reserve_pps{
    label: "Recovery Reserve PPS"
    type: sum
    sql: ${TABLE}.recoveryreserve_pps ;;
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






}
