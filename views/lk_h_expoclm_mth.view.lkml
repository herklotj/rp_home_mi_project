view: lk_h_expoclm_mth {
  sql_table_name: actian.lk_h_expoclm_mth ;;


  #### MANUAL ENTRY DIMENSIONS e.g. Cat Costs/Periods, Flood Re rates, ABE by UWYR etc. ###

  ### ASAT November 1st 2020 ###
  dimension: cat_period {
    type: string
    sql: case when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2016-08-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2017-10-01')))
                    then 'Aug16 - Sep17'
              when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2017-10-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2018-10-01')))
                    then 'Oct17 - Sep18'
              when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2018-10-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2019-10-01')))
                    then 'Oct18 - Sep19'
              when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2019-10-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2020-10-01')))
                    then 'Oct19 - Sep20'
              when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2020-10-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2021-10-01')))
                    then 'Oct20 - Sep21'
              when (((cast(${TABLE}.exposure_mth as timestamp) ) >= (TIMESTAMP '2021-10-01') AND (cast(${TABLE}.exposure_mth as timestamp) ) < (TIMESTAMP '2022-10-01')))
                    then 'Oct21 - Sep22'
              else null end   ;;
    label: "Cat Period"
  }

  ### ASAT November 1st 2020 ###
  dimension: seed_rate {
    type: number
    sql: 0.2 ;;
    hidden: yes
    value_format_name: percent_1
  }

  dimension: claim_fee_rate {
    type: number
    sql: case when (CAST(${TABLE}.exposure_mth AS TIMESTAMP WITHOUT TIME ZONE)  < (TIMESTAMP '2020-02-01')) then 175 else 210 end ;;
    hidden: yes
    value_format_name: decimal_0
  }

  ### ASAT November 1st 2020 ###
  dimension: fixed_commission_rate {
    type: number
    sql: case when ${TABLE}.policy_period_qs in(1,2,3) then 0.16 else 0.08 end ;;
    hidden: yes
    value_format_name: percent_0
  }

  ### ASAT November 1st 2020 ###
  dimension: cat_xol_rate {
    type: number
    sql: case when ${cat_period} = 'Aug16 - Sep17' then 0.0800
              when ${cat_period} = 'Oct17 - Sep18' then 0.0995
              when ${cat_period} = 'Oct18 - Sep19' then 0.0917
              when ${cat_period} = 'Oct19 - Sep20' then 0.0917
              when ${cat_period} = 'Oct20 - Sep21' then 0.0951
              else 0 end;;
    hidden: yes
    value_format_name: percent_2
  }

  ### ASAT November 1st 2020 ###
  dimension: cat_xol_topup_rate {
    type: number
    sql: case when ${cat_period} = 'Aug16 - Sep17' then ${TABLE}.earned_premium*0.0000
              when ${cat_period} = 'Oct17 - Sep18' then ${TABLE}.earned_premium*0.0080
              when ${cat_period} = 'Oct18 - Sep19' then ${TABLE}.earned_premium*0.0098
              when ${cat_period} = 'Oct19 - Sep20' then ${TABLE}.earned_premium*0.0098
              when ${cat_period} = 'Oct20 - Sep21' then ${TABLE}.earned_premium*0.0126
              else 0 end ;;
    hidden: yes
    value_format_name: percent_2
  }


  ### ASAT November 4th 2020 ###
  dimension: flood_re_rate {
    type: number
    sql: case when date_part('year',${TABLE}.annual_cover_start_dttm) = 2016 then 0.0565
              when date_part('year',${TABLE}.annual_cover_start_dttm) = 2017 then 0.0567
              when date_part('year',${TABLE}.annual_cover_start_dttm) = 2018 then 0.0561
              when date_part('year',${TABLE}.annual_cover_start_dttm) = 2019 then 0.0537
              when date_part('year',${TABLE}.annual_cover_start_dttm) = 2020 then 0.0513
              else 0 end ;;
    hidden: yes
    value_format_name: percent_2
  }

  ### ASAT September 30th 2020 ###
  dimension: latest_abe_rate {
    type: number
    sql: case when ${TABLE}.policy_period_qs = '1' then 0.611
              when ${TABLE}.policy_period_qs = '2' then 0.552
              when ${TABLE}.policy_period_qs = '3' then 0.494
              when ${TABLE}.policy_period_qs = '4' then 0.472
              when ${TABLE}.policy_period_qs = '5' then 0.486
              else 0 end ;;
    hidden: yes
    value_format_name: percent_1
  }

  ########




  dimension: aa_membership {
    label: "AA Membership"
    type: string
    sql: ${TABLE}.aa_membership ;;
  }

  dimension: aa_tenure_10 {
    label: "AA Tenure (10)"
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10]
    style: integer
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: aa_tenure_5 {
    label: "AA Tenure (5)"
    type: tier
    tiers: [0,1,2,3,4,5]
    style: integer
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: aa_tenure_3 {
    label: "AA Tenure (3)"
    type: tier
    tiers: [0,1,2,3]
    style: integer
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: aauicl_flag_joint {
    type: number
    sql: ${TABLE}.aauicl_flag_joint ;;
    hidden: yes
  }

  dimension: aauicl_hold_bds {
    type: number
    sql: ${TABLE}.aauicl_hold_bds ;;
    hidden: yes
  }

  dimension: aauicl_hold_cts {
    type: number
    sql: ${TABLE}.aauicl_hold_cts ;;
    hidden: yes
  }

  dimension: aauicl_ifp {
    label: "AAUICL IFP"
    type: number
    sql: ${TABLE}.aauicl_ifp ;;
  }

  dimension: aauicl_ifp_bds {
    label: "AAUICL IFP BDS"
    type: number
    sql: ${TABLE}.aauicl_ifp_bds ;;
  }

  dimension: aauicl_ifp_cts {
    label: "AAUICL IFP CTS"
    type: number
    sql: ${TABLE}.aauicl_ifp_cts ;;
  }

  dimension: aauicl_ifp_current {
    label: "AAUICL IFP Current"
    type: number
    sql: ${TABLE}.aauicl_ifp_current ;;
  }

  dimension: aauicl_ifp_current_bds {
    label: "AAUICL IFP BDS Current"
    type: number
    sql: ${TABLE}.aauicl_ifp_current_bds ;;
  }

  dimension: aauicl_ifp_current_cts {
    label: "AAUICL IFP CTS Current"
    type: number
    sql: ${TABLE}.aauicl_ifp_current_cts ;;
  }

  dimension: aauicl_ind_bds {
    label: "AAUICL BDS Cover"
    type: number
    sql: ${TABLE}.aauicl_ind_bds ;;
  }

  dimension: aauicl_ind_cts {
    label: "AAUICL CTS Cover"
    type: number
    sql: ${TABLE}.aauicl_ind_cts ;;
  }


  dimension: aauicl_ren_bds {
    type: number
    sql: ${TABLE}.aauicl_ren_bds ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_claims {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_claims ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_commission {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_commission ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_commission_ly {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_commission_ly ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_earned_commission {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_earned_commission ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_earned_premium {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_earned_premium ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_exposure {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_exposure ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_incurred {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_incurred ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_premium {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_premium ;;
    hidden: yes
  }

  dimension: aauicl_ren_bds_premium_ly {
    type: number
    sql: ${TABLE}.aauicl_ren_bds_premium_ly ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts {
    type: number
    sql: ${TABLE}.aauicl_ren_cts ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_claims {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_claims ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_commission {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_commission ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_commission_ly {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_commission_ly ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_earned_commission {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_earned_commission ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_earned_premium {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_earned_premium ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_exposure {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_exposure ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_incurred {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_incurred ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_premium {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_premium ;;
    hidden: yes
  }

  dimension: aauicl_ren_cts_premium_ly {
    type: number
    sql: ${TABLE}.aauicl_ren_cts_premium_ly ;;
    hidden: yes
  }

  dimension: aauicl_scheme {
    label: "AAUICL Scheme"
    type: number
    sql: ${TABLE}.aauicl_scheme ;;
  }


  dimension: aauicl_sum_insured_bds {
    type: number
    sql: ${TABLE}.aauicl_sum_insured_bds ;;
    hidden: yes
  }

  dimension: aauicl_sum_insured_cts {
    type: number
    sql: ${TABLE}.aauicl_sum_insured_cts ;;
    hidden: yes
  }

  dimension: aauicl_sum_insured_tot {
    type: number
    sql: ${TABLE}.aauicl_sum_insured_tot ;;
    hidden: yes
  }

  dimension: aauicl_xq_bds {
    label: "AAUICL XQ BDS"
    type: number
    sql: ${TABLE}.aauicl_xq_bds ;;
  }

  dimension: aauicl_xq_bds_commission {
    type: number
    sql: ${TABLE}.aauicl_xq_bds_commission ;;
    hidden: yes
  }

  dimension: aauicl_xq_bds_premium {
    type: number
    sql: ${TABLE}.aauicl_xq_bds_premium ;;
    hidden: yes
  }

  dimension: aauicl_xq_cts {
    label: "AAUICL XQ BDS"
    type: number
    sql: ${TABLE}.aauicl_xq_cts ;;
  }

  dimension: aauicl_xq_cts_commission {
    type: number
    sql: ${TABLE}.aauicl_xq_cts_commission ;;
    hidden: yes
  }

  dimension: aauicl_xq_cts_premium {
    type: number
    sql: ${TABLE}.aauicl_xq_cts_premium ;;
    hidden: yes
  }

  dimension: addon_commission_hec {
    type: number
    sql: ${TABLE}.addon_commission_hec ;;
    hidden: yes
  }

  dimension: addon_commission_her {
    type: number
    sql: ${TABLE}.addon_commission_her ;;
    hidden: yes
  }

  dimension: addon_commission_hle {
    type: number
    sql: ${TABLE}.addon_commission_hle ;;
    hidden: yes
  }

  dimension: addon_ind_hec {
    label: "Add-on HEC Flag"
    type: number
    sql: ${TABLE}.addon_ind_hec ;;

  }

  dimension: addon_ind_her {
    label: "Add-on HER Flag"
    type: number
    sql: ${TABLE}.addon_ind_her ;;

  }

  dimension: addon_ind_hle {
    label: "Add-on HLE Flag"
    type: number
    sql: ${TABLE}.addon_ind_hle ;;

  }


  dimension_group: annual_cover_end_dttm {
    label: "Annual Cover End DTTM"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year
    ]
    sql: ${TABLE}.annual_cover_end_dttm ;;
  }

  dimension_group: annual_cover_start_dttm {
    label: "Annual Cover Start DTTM"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year
    ]
    sql: ${TABLE}.annual_cover_start_dttm ;;
  }


  dimension: area_ad {
    label: "Rated Area - AD"
    type: string
    sql: ${TABLE}.area_ad ;;
  }

  dimension: area_bds_margin {
    type: string
    sql: ${TABLE}.area_bds_margin ;;
    hidden: yes
  }

  dimension: area_cts_margin {
    type: string
    sql: ${TABLE}.area_cts_margin ;;
    hidden: yes
  }

  dimension: area_eow {
    type: string
    sql: ${TABLE}.area_eow ;;
    label: "Rated Area - EoW"
  }

  dimension: area_fire {
    type: string
    sql: ${TABLE}.area_fire ;;
    label: "Rated Area - Fire"
  }

  dimension: area_flood {
    type: string
    sql: ${TABLE}.area_flood ;;
    label: "Rated Area - Flood"
  }

  dimension: area_other {
    type: string
    sql: ${TABLE}.area_other ;;
    label: "Rated Area - Other"
  }

  dimension: area_pps {
    type: string
    sql: ${TABLE}.area_pps ;;
    label: "Rated Area - PPS"
  }

  dimension: area_storm {
    type: string
    sql: ${TABLE}.area_storm ;;
    label: "Rated Area - Storm"
  }

  dimension: area_subs {
    type: string
    sql: ${TABLE}.area_subs ;;
    label: "Rated Area - Subsidence"
  }

  dimension: area_theft {
    type: string
    sql: ${TABLE}.area_theft ;;
    label: "Rated Area - Theft"
  }

  dimension: broked_ind {
    label: "Broked Flag"
    type: string
    sql: ${TABLE}.broked_ind ;;
  }

  dimension: broker_commission {
    type: number
    sql: ${TABLE}.broker_commission ;;
    hidden: yes
  }

  dimension: broker_commission_aauicl {
    type: number
    sql: ${TABLE}.broker_commission_aauicl ;;
    hidden: yes
  }

  dimension: broker_commission_aauicl_bds {
    type: number
    sql: ${TABLE}.broker_commission_aauicl_bds ;;
    hidden: yes
  }

  dimension: broker_commission_aauicl_cts {
    type: number
    sql: ${TABLE}.broker_commission_aauicl_cts ;;
    hidden: yes
  }

  dimension: broker_commission_bds {
    type: number
    sql: ${TABLE}.broker_commission_bds ;;
    hidden: yes
  }

  dimension: broker_commission_cts {
    type: number
    sql: ${TABLE}.broker_commission_cts ;;
    hidden: yes
  }

  dimension: broker_commission_disc {
    type: number
    sql: ${TABLE}.broker_commission_disc ;;
    hidden: yes
  }

  dimension: broker_commission_other {
    type: number
    sql: ${TABLE}.broker_commission_other ;;
    hidden: yes
  }

  dimension: broker_commission_other_bds {
    type: number
    sql: ${TABLE}.broker_commission_other_bds ;;
    hidden: yes
  }

  dimension: broker_commission_other_cts {
    type: number
    sql: ${TABLE}.broker_commission_other_cts ;;
    hidden: yes
  }

  dimension: broker_commission_woff {
    type: number
    sql: ${TABLE}.broker_commission_woff ;;
    hidden: yes
  }

  dimension: broker_commission_xfees {
    type: number
    sql: ${TABLE}.broker_commission_xfees ;;
    hidden: yes
  }

  dimension: broker_flag_joint {
    type: number
    sql: ${TABLE}.broker_flag_joint ;;
    hidden: yes
  }

  dimension: broker_iaf {
    type: number
    sql: ${TABLE}.broker_iaf ;;
    hidden: yes
  }

  dimension: broker_iaf_ipt {
    type: number
    sql: ${TABLE}.broker_iaf_ipt ;;
    hidden: yes
  }

  dimension: broker_ifp {
    type: number
    sql: ${TABLE}.broker_ifp ;;
    hidden: yes
  }

  dimension: broker_ifp_bds {
    type: number
    sql: ${TABLE}.broker_ifp_bds ;;
    hidden: yes
  }

  dimension: broker_ifp_cts {
    type: number
    sql: ${TABLE}.broker_ifp_cts ;;
    hidden: yes
  }

  dimension: broker_ifp_current {
    type: number
    sql: ${TABLE}.broker_ifp_current ;;
    hidden: yes
  }

  dimension: broker_ifp_current_bds {
    type: number
    sql: ${TABLE}.broker_ifp_current_bds ;;
    hidden: yes
  }

  dimension: broker_ifp_current_cts {
    type: number
    sql: ${TABLE}.broker_ifp_current_cts ;;
    hidden: yes
  }

  dimension: broker_ind_bds {
    type: number
    sql: ${TABLE}.broker_ind_bds ;;
    hidden: yes
  }

  dimension: broker_ind_cts {
    type: number
    sql: ${TABLE}.broker_ind_cts ;;
    hidden: yes
  }

  dimension: broker_lapse_disc {
    type: number
    sql: ${TABLE}.broker_lapse_disc ;;
    hidden: yes
  }

  dimension: broker_lapse_disc_bds {
    type: number
    sql: ${TABLE}.broker_lapse_disc_bds ;;
    hidden: yes
  }

  dimension: broker_lapse_disc_cts {
    type: number
    sql: ${TABLE}.broker_lapse_disc_cts ;;
    hidden: yes
  }

  dimension: broker_nb_rb {
    label: "Broker NB/RB"
    type: string
    sql: ${TABLE}.broker_nb_rb ;;
  }

  dimension: broker_sum_insured_bds {
    type: number
    sql: ${TABLE}.broker_sum_insured_bds ;;
    hidden: yes
  }

  dimension: broker_sum_insured_cts {
    type: number
    sql: ${TABLE}.broker_sum_insured_cts ;;
    hidden: yes
  }

  dimension: broker_sum_insured_tot {
    type: number
    sql: ${TABLE}.broker_sum_insured_tot ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rfq {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rfq ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rfq_inf {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rfq_inf ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rfq_wlc {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rfq_wlc ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rfq_wlu {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rfq_wlu ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rpm {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rpm ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rpm_inf {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rpm_inf ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rpm_wlc {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rpm_wlc ;;
    hidden: yes
  }

  dimension: buildings_aauicl_ren_rpm_wlu {
    type: number
    sql: ${TABLE}.buildings_aauicl_ren_rpm_wlu ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rfq {
    type: number
    sql: ${TABLE}.buildings_aauicl_rfq ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rfq_inf {
    type: number
    sql: ${TABLE}.buildings_aauicl_rfq_inf ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rfq_wlc {
    type: number
    sql: ${TABLE}.buildings_aauicl_rfq_wlc ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rfq_wlu {
    type: number
    sql: ${TABLE}.buildings_aauicl_rfq_wlu ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rpm {
    type: number
    sql: ${TABLE}.buildings_aauicl_rpm ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rpm_inf {
    type: number
    sql: ${TABLE}.buildings_aauicl_rpm_inf ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rpm_wlc {
    type: number
    sql: ${TABLE}.buildings_aauicl_rpm_wlc ;;
    hidden: yes
  }

  dimension: buildings_aauicl_rpm_wlu {
    type: number
    sql: ${TABLE}.buildings_aauicl_rpm_wlu ;;
    hidden: yes
  }

  dimension: buildings_ad_claims {
    type: number
    sql: ${TABLE}.buildings_ad_claims ;;
    hidden: yes
  }

  dimension: buildings_ad_incurred {
    type: number
    sql: ${TABLE}.buildings_ad_incurred ;;
    hidden: yes
  }

  dimension: buildings_claims {
    type: number
    sql: ${TABLE}.buildings_claims ;;
    hidden: yes
  }

  dimension: buildings_earned_commission {
    type: number
    sql: ${TABLE}.buildings_earned_commission ;;
    hidden: yes
  }

  dimension: buildings_earned_premium {
    type: number
    sql: ${TABLE}.buildings_earned_premium ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rfq {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rfq ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rfq_inf {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rfq_inf ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rfq_wlc {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rfq_wlc ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rfq_wlu {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rfq_wlu ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rpm {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rpm ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rpm_inf {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rpm_inf ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rpm_wlc {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rpm_wlc ;;
    hidden: yes
  }

  dimension: buildings_earned_ren_rpm_wlu {
    type: number
    sql: ${TABLE}.buildings_earned_ren_rpm_wlu ;;
    hidden: yes
  }

  dimension: buildings_earned_rfq {
    type: number
    sql: ${TABLE}.buildings_earned_rfq ;;
    hidden: yes
  }

  dimension: buildings_earned_rfq_inf {
    type: number
    sql: ${TABLE}.buildings_earned_rfq_inf ;;
    hidden: yes
  }

  dimension: buildings_earned_rfq_wlc {
    type: number
    sql: ${TABLE}.buildings_earned_rfq_wlc ;;
    hidden: yes
  }

  dimension: buildings_earned_rfq_wlu {
    type: number
    sql: ${TABLE}.buildings_earned_rfq_wlu ;;
    hidden: yes
  }

  dimension: buildings_earned_rpm {
    type: number
    sql: ${TABLE}.buildings_earned_rpm ;;
    hidden: yes
  }

  dimension: buildings_earned_rpm_inf {
    type: number
    sql: ${TABLE}.buildings_earned_rpm_inf ;;
    hidden: yes
  }

  dimension: buildings_earned_rpm_wlc {
    type: number
    sql: ${TABLE}.buildings_earned_rpm_wlc ;;
    hidden: yes
  }

  dimension: buildings_earned_rpm_wlu {
    type: number
    sql: ${TABLE}.buildings_earned_rpm_wlu ;;
    hidden: yes
  }


  dimension: buildings_eow_claims {
    type: number
    sql: ${TABLE}.buildings_eow_claims ;;
    hidden: yes
  }

  dimension: buildings_eow_incurred {
    type: number
    sql: ${TABLE}.buildings_eow_incurred ;;
    hidden: yes
  }

  dimension: buildings_exposure {
    type: number
    sql: ${TABLE}.buildings_exposure ;;
    hidden: yes
  }

  dimension: buildings_exposure_aauicl {
    type: number
    sql: ${TABLE}.buildings_exposure_aauicl ;;
    hidden: yes
  }

  dimension: buildings_exposure_ad {
    type: number
    sql: ${TABLE}.buildings_exposure_ad ;;
    hidden: yes
  }

  dimension: buildings_fire_claims {
    type: number
    sql: ${TABLE}.buildings_fire_claims ;;
    hidden: yes
  }

  dimension: buildings_fire_incurred {
    type: number
    sql: ${TABLE}.buildings_fire_incurred ;;
    hidden: yes
  }

  dimension: buildings_flood_claims {
    type: number
    sql: ${TABLE}.buildings_flood_claims ;;
    hidden: yes
  }

  dimension: buildings_flood_incurred {
    type: number
    sql: ${TABLE}.buildings_flood_incurred ;;
    hidden: yes
  }

  dimension: buildings_incurred {
    type: number
    sql: ${TABLE}.buildings_incurred ;;
    hidden: yes
  }

  dimension: buildings_incurred_cap100k {
    type: number
    sql: ${TABLE}.buildings_incurred_cap100k ;;
    hidden: yes
  }

  dimension: buildings_incurred_cap50k {
    type: number
    sql: ${TABLE}.buildings_incurred_cap50k ;;
    hidden: yes
  }

  dimension: buildings_other_claims {
    type: number
    sql: ${TABLE}.buildings_other_claims ;;
    hidden: yes
  }

  dimension: buildings_other_incurred {
    type: number
    sql: ${TABLE}.buildings_other_incurred ;;
    hidden: yes
  }

  dimension: buildings_storm_claims {
    type: number
    sql: ${TABLE}.buildings_storm_claims ;;
    hidden: yes
  }

  dimension: buildings_storm_incurred {
    type: number
    sql: ${TABLE}.buildings_storm_incurred ;;
    hidden: yes
  }

  dimension: buildings_subsidence_claims {
    type: number
    sql: ${TABLE}.buildings_subsidence_claims ;;
    hidden: yes
  }

  dimension: buildings_subsidence_incurred {
    type: number
    sql: ${TABLE}.buildings_subsidence_incurred ;;
    hidden: yes
  }

  dimension: buildings_theft_claims {
    type: number
    sql: ${TABLE}.buildings_theft_claims ;;
    hidden: yes
  }

  dimension: buildings_theft_incurred {
    type: number
    sql: ${TABLE}.buildings_theft_incurred ;;
    hidden: yes
  }

  dimension_group: cfi_dttm {
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year

    ]
    sql: ${TABLE}.cfi_dttm ;;
    hidden: yes

  }

  dimension: cfi_ind {
    type: number
    sql: ${TABLE}.cfi_ind ;;
    hidden: yes
  }

  dimension: cfi_ind_lapse {
    type: number
    sql: ${TABLE}.cfi_ind_lapse ;;
    hidden: yes
  }

  dimension: cfi_ind_lapse_bds {
    type: number
    sql: ${TABLE}.cfi_ind_lapse_bds ;;
    hidden: yes
  }

  dimension: cfi_ind_lapse_cts {
    type: number
    sql: ${TABLE}.cfi_ind_lapse_cts ;;
    hidden: yes
  }

  dimension_group: cfi_ind_lapse_dttm {
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
    sql: ${TABLE}.cfi_ind_lapse_dttm ;;
    hidden: yes
  }

  dimension: cfi_reason {
    type: string
    sql: ${TABLE}.cfi_reason ;;
    hidden: yes
  }

  dimension: cfi_status {
    type: string
    sql: ${TABLE}.cfi_status ;;
    hidden: yes
  }

  dimension: channel {
    label: "Channel"
    type: string
    sql: ${TABLE}.channel ;;
  }

  dimension: combined_exposure {
    type: number
    sql: ${TABLE}.combined_exposure ;;
    hidden: yes
  }

  dimension: combined_exposure_aauicl {
    type: number
    sql: ${TABLE}.combined_exposure_aauicl ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rfq {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rfq ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rfq_inf {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rfq_inf ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rfq_wlc {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rfq_wlc ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rfq_wlu {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rfq_wlu ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rpm {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rpm ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rpm_inf {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rpm_inf ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rpm_wlc {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rpm_wlc ;;
    hidden: yes
  }

  dimension: contents_aauicl_ren_rpm_wlu {
    type: number
    sql: ${TABLE}.contents_aauicl_ren_rpm_wlu ;;
    hidden: yes
  }

  dimension: contents_aauicl_rfq {
    type: number
    sql: ${TABLE}.contents_aauicl_rfq ;;
    hidden: yes
  }

  dimension: contents_aauicl_rfq_inf {
    type: number
    sql: ${TABLE}.contents_aauicl_rfq_inf ;;
    hidden: yes
  }

  dimension: contents_aauicl_rfq_wlc {
    type: number
    sql: ${TABLE}.contents_aauicl_rfq_wlc ;;
    hidden: yes
  }

  dimension: contents_aauicl_rfq_wlu {
    type: number
    sql: ${TABLE}.contents_aauicl_rfq_wlu ;;
    hidden: yes
  }

  dimension: contents_aauicl_rpm {
    type: number
    sql: ${TABLE}.contents_aauicl_rpm ;;
    hidden: yes
  }

  dimension: contents_aauicl_rpm_inf {
    type: number
    sql: ${TABLE}.contents_aauicl_rpm_inf ;;
    hidden: yes
  }

  dimension: contents_aauicl_rpm_wlc {
    type: number
    sql: ${TABLE}.contents_aauicl_rpm_wlc ;;
    hidden: yes
  }

  dimension: contents_aauicl_rpm_wlu {
    type: number
    sql: ${TABLE}.contents_aauicl_rpm_wlu ;;
    hidden: yes
  }

  dimension: contents_ad_claims {
    type: number
    sql: ${TABLE}.contents_ad_claims ;;
    hidden: yes
  }

  dimension: contents_ad_incurred {
    type: number
    sql: ${TABLE}.contents_ad_incurred ;;
    hidden: yes
  }

  dimension: contents_claims {
    type: number
    sql: ${TABLE}.contents_claims ;;
    hidden: yes
  }

  dimension: contents_earned_commission {
    type: number
    sql: ${TABLE}.contents_earned_commission ;;
    hidden: yes
  }

  dimension: contents_earned_premium {
    type: number
    sql: ${TABLE}.contents_earned_premium ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rfq {
    type: number
    sql: ${TABLE}.contents_earned_ren_rfq ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rfq_inf {
    type: number
    sql: ${TABLE}.contents_earned_ren_rfq_inf ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rfq_wlc {
    type: number
    sql: ${TABLE}.contents_earned_ren_rfq_wlc ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rfq_wlu {
    type: number
    sql: ${TABLE}.contents_earned_ren_rfq_wlu ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rpm {
    type: number
    sql: ${TABLE}.contents_earned_ren_rpm ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rpm_inf {
    type: number
    sql: ${TABLE}.contents_earned_ren_rpm_inf ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rpm_wlc {
    type: number
    sql: ${TABLE}.contents_earned_ren_rpm_wlc ;;
    hidden: yes
  }

  dimension: contents_earned_ren_rpm_wlu {
    type: number
    sql: ${TABLE}.contents_earned_ren_rpm_wlu ;;
    hidden: yes
  }

  dimension: contents_earned_rfq {
    type: number
    sql: ${TABLE}.contents_earned_rfq ;;
    hidden: yes
  }

  dimension: contents_earned_rfq_inf {
    type: number
    sql: ${TABLE}.contents_earned_rfq_inf ;;
    hidden: yes
  }

  dimension: contents_earned_rfq_wlc {
    type: number
    sql: ${TABLE}.contents_earned_rfq_wlc ;;
    hidden: yes
  }

  dimension: contents_earned_rfq_wlu {
    type: number
    sql: ${TABLE}.contents_earned_rfq_wlu ;;
    hidden: yes
  }

  dimension: contents_earned_rpm {
    type: number
    sql: ${TABLE}.contents_earned_rpm ;;
    hidden: yes
  }

  dimension: contents_earned_rpm_inf {
    type: number
    sql: ${TABLE}.contents_earned_rpm_inf ;;
    hidden: yes
  }

  dimension: contents_earned_rpm_wlc {
    type: number
    sql: ${TABLE}.contents_earned_rpm_wlc ;;
    hidden: yes
  }

  dimension: contents_earned_rpm_wlu {
    type: number
    sql: ${TABLE}.contents_earned_rpm_wlu ;;
    hidden: yes
  }


  dimension: contents_eow_claims {
    type: number
    sql: ${TABLE}.contents_eow_claims ;;
    hidden: yes
  }

  dimension: contents_eow_incurred {
    type: number
    sql: ${TABLE}.contents_eow_incurred ;;
    hidden: yes
  }

  dimension: contents_exposure {
    type: number
    sql: ${TABLE}.contents_exposure ;;
    hidden: yes
  }

  dimension: contents_exposure_aauicl {
    type: number
    sql: ${TABLE}.contents_exposure_aauicl ;;
    hidden: yes
  }

  dimension: contents_exposure_ad {
    type: number
    sql: ${TABLE}.contents_exposure_ad ;;
    hidden: yes
  }

  dimension: contents_fire_claims {
    type: number
    sql: ${TABLE}.contents_fire_claims ;;
    hidden: yes
  }

  dimension: contents_fire_incurred {
    type: number
    sql: ${TABLE}.contents_fire_incurred ;;
    hidden: yes
  }

  dimension: contents_flood_claims {
    type: number
    sql: ${TABLE}.contents_flood_claims ;;
    hidden: yes
  }

  dimension: contents_flood_incurred {
    type: number
    sql: ${TABLE}.contents_flood_incurred ;;
    hidden: yes
  }

  dimension: contents_incurred {
    type: number
    sql: ${TABLE}.contents_incurred ;;
    hidden: yes
  }

  dimension: contents_incurred_cap15k {
    type: number
    sql: ${TABLE}.contents_incurred_cap15k ;;
    hidden: yes
  }

  dimension: contents_incurred_cap25k {
    type: number
    sql: ${TABLE}.contents_incurred_cap25k ;;
    hidden: yes
  }

  dimension: contents_other_claims {
    type: number
    sql: ${TABLE}.contents_other_claims ;;
    hidden: yes
  }

  dimension: contents_other_incurred {
    type: number
    sql: ${TABLE}.contents_other_incurred ;;
    hidden: yes
  }

  dimension: contents_pps_claims {
    type: number
    sql: ${TABLE}.contents_pps_claims ;;
    hidden: yes
  }

  dimension: contents_pps_incurred {
    type: number
    sql: ${TABLE}.contents_pps_incurred ;;
    hidden: yes
  }

  dimension: contents_storm_claims {
    type: number
    sql: ${TABLE}.contents_storm_claims ;;
    hidden: yes
  }

  dimension: contents_storm_incurred {
    type: number
    sql: ${TABLE}.contents_storm_incurred ;;
    hidden: yes
  }

  dimension: contents_theft_claims {
    type: number
    sql: ${TABLE}.contents_theft_claims ;;
    hidden: yes
  }

  dimension: contents_theft_incurred {
    type: number
    sql: ${TABLE}.contents_theft_incurred ;;
    hidden: yes
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

  dimension: cover_type_requested {
    label: "Cover Type Requested"
    type: string
    sql: ${TABLE}.cover_type_requested ;;
  }

  dimension: cranfield_score_clay {
    label: "Cranfield Score Clay"
    type: string
    sql: ${TABLE}.cranfield_score_clay ;;
  }

  dimension: cranfield_score_nonclay {
    label: "Cranfield Score Non-Clay"
    type: string
    sql: ${TABLE}.cranfield_score_nonclay ;;
  }

  dimension: cranfield_score_wind {
    label: "Cranfield Score Wind"
    type: string
    sql: ${TABLE}.cranfield_score_wind ;;
  }

  dimension: dob {
    type: number
    sql: ${TABLE}.dob ;;
    hidden: yes
  }

  dimension: earned_commission {
    type: number
    sql: ${TABLE}.earned_commission ;;
    hidden: yes
  }

  dimension: earned_premium {
    type: number
    sql: ${TABLE}.earned_premium ;;
    hidden: yes
  }

  dimension: earned_rfq {
    type: number
    sql: ${TABLE}.earned_rfq ;;
    hidden: yes
  }

  dimension: earned_rfq_inf {
    type: number
    sql: ${TABLE}.earned_rfq_inf ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_ad {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_ad ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_eow {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_eow ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_fire {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_fire ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_flood {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_flood ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_other {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_other ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_storm {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_storm ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_subsidence {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_subsidence ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_bds_theft {
    type: number
    sql: ${TABLE}.earned_rfq_inf_bds_theft ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_ad {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_ad ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_eow {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_eow ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_fire {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_fire ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_flood {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_flood ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_other {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_other ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_storm {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_storm ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_cts_theft {
    type: number
    sql: ${TABLE}.earned_rfq_inf_cts_theft ;;
    hidden: yes
  }

  dimension: earned_rfq_inf_pps_combined {
    type: number
    sql: ${TABLE}.earned_rfq_inf_pps_combined ;;
    hidden: yes
  }

  dimension: earned_rfq_wlc {
    type: number
    sql: ${TABLE}.earned_rfq_wlc ;;
    hidden: yes
  }

  dimension: earned_rfq_wlu {
    type: number
    sql: ${TABLE}.earned_rfq_wlu ;;
    hidden: yes
  }

  dimension: earned_rpm {
    type: number
    sql: ${TABLE}.earned_rpm ;;
    hidden: yes
  }

  dimension: earned_rpm_inf {
    type: number
    sql: ${TABLE}.earned_rpm_inf ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_ad {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_ad ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_eow {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_eow ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_fire {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_fire ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_flood {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_flood ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_other {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_other ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_storm {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_storm ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_subsidence {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_subsidence ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_bds_theft {
    type: number
    sql: ${TABLE}.earned_rpm_inf_bds_theft ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_ad {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_ad ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_eow {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_eow ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_fire {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_fire ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_flood {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_flood ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_other {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_other ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_storm {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_storm ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_cts_theft {
    type: number
    sql: ${TABLE}.earned_rpm_inf_cts_theft ;;
    hidden: yes
  }

  dimension: earned_rpm_inf_pps_combined {
    type: number
    sql: ${TABLE}.earned_rpm_inf_pps_combined ;;
    hidden: yes
  }

  dimension: earned_rpm_wlc {
    type: number
    sql: ${TABLE}.earned_rpm_wlc ;;
    hidden: yes
  }

  dimension: earned_rpm_wlu {
    type: number
    sql: ${TABLE}.earned_rpm_wlu ;;
    hidden: yes
  }

  dimension: eer {
    label: "EER (Postal Region)"
    type: string
    sql: ${TABLE}.eer ;;
  }

  dimension: exposure {
    type: number
    sql: ${TABLE}.exposure ;;
    hidden: yes
  }



  dimension_group: exposure_mth {
    type: time
    timeframes: [
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year
    ]
    sql: cast(${TABLE}.exposure_mth as timestamp) ;;
  }

  dimension: exposure_yr {
    type: number
    label: "Exposure Year"
    sql: ${TABLE}.exposure_yr;;
    value_format: "0"
  }

  dimension: flex_discount_amount {
    type: number
    sql: ${TABLE}.flex_discount_amount ;;
    hidden: yes
  }

  dimension: home_cover_level {
    type: string
    sql: ${TABLE}.home_cover_level ;;
    label: "Home Cover Level"
  }

  dimension: home_risk_address1 {
    type: string
    sql: ${TABLE}.home_risk_address1 ;;
    hidden: yes
  }

  dimension: home_risk_address2 {
    type: string
    sql: ${TABLE}.home_risk_address2 ;;
    hidden: yes
  }

  dimension: home_risk_address3 {
    type: string
    sql: ${TABLE}.home_risk_address3 ;;
    hidden: yes
  }

  dimension: iaf_amount {
    type: number
    sql: ${TABLE}.iaf_amount ;;
    hidden: yes
  }

  dimension: iaf_commission_discount {
    type: number
    sql: ${TABLE}.iaf_commission_discount ;;
    hidden: yes
  }

  dimension_group: inception_dt {
    type: time
    timeframes: [
      date,
      week,
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year
    ]
    label: "Inception Date"
    sql: ${TABLE}.inception_dt ;;
  }

  dimension: policy_period_qs_inception {
    type: string
    sql: case when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2016-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2017-07-31')))
                    then '1'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2017-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2018-07-31')))
                    then '2'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2018-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2019-07-31')))
                    then '3'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2019-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2020-07-31')))
                    then '4'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2020-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2021-07-31')))
                    then '5'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2021-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2022-07-31')))
                    then '6'
              when (((cast(${TABLE}.inception_dt as timestamp) ) >= (TIMESTAMP '2022-08-01') AND (cast(${TABLE}.inception_dt as timestamp) ) <= (TIMESTAMP '2023-07-31')))
                    then '7'
              else null end   ;;
    label: "QS Period - Inception"
  }

  dimension: installment_flag {
    type: string
    label: "Installment Flag"
    sql: ${TABLE}.installment_flag ;;
  }

  dimension: insurer_nb_rb {
    label: "Insurer NB/RB"
    type: string
    sql: ${TABLE}.insurer_nb_rb ;;
  }

  dimension: ipt_amount {
    type: number
    sql: ${TABLE}.ipt_amount ;;
    hidden: yes
  }

  dimension: ipt_rate {
    label: "IPT Rate"
    type: number
    sql: ${TABLE}.ipt_rate ;;
  }

  dimension: jba_score {
    label: "JBA Score"
    type: string
    sql: ${TABLE}.jba_score ;;
  }

  dimension: jba_score_ad {
    label: "JBA Score - AD"
    type: string
    sql: ${TABLE}.jba_score_ad ;;
  }

  dimension: jba_unflood {
    label: "JBA Unflood"
    type: string
    sql: ${TABLE}.jba_unflood ;;
  }

  dimension: joint_policy {
    type: string
    sql: ${TABLE}.joint_policy ;;
    hidden: yes
  }

  dimension_group: load_dttm {
    label: "Load DTTM"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_quarter,
      fiscal_year
    ]
    sql: ${TABLE}.load_dttm ;;
  }

  ##### NEEDS WORK

  dimension: ly_commission_bds {
    type: number
    sql: ${TABLE}.ly_commission_bds ;;
    hidden: yes
  }

  dimension: ly_commission_cts {
    type: number
    sql: ${TABLE}.ly_commission_cts ;;
    hidden: yes
  }

  dimension: ly_premium_bds {
    type: number
    sql: ${TABLE}.ly_premium_bds ;;
    hidden: yes
  }

  dimension: ly_premium_cts {
    type: number
    sql: ${TABLE}.ly_premium_cts ;;
    hidden: yes
  }

  dimension: membership_no {
    type: number
    sql: ${TABLE}.membership_no ;;
    hidden: yes
  }

  dimension: merlin_reference {
    type: string
    sql: ${TABLE}.merlin_reference ;;
    hidden: yes
  }

  dimension: mob {
    type: number
    sql: ${TABLE}.mob ;;
    hidden: yes
  }

  dimension: mta {
    label: "MTA"
    type: string
    sql: ${TABLE}.mta ;;

  }

  dimension: mta_add_broker_commission {
    type: number
    sql: ${TABLE}.mta_add_broker_commission ;;
    hidden: yes
  }

  dimension: mta_add_broker_commission_bds {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_bds ;;
    hidden: yes
  }

  dimension: mta_add_broker_commission_cts {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_cts ;;
    hidden: yes
  }

  dimension: mta_add_broker_commission_disc {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_disc ;;
    hidden: yes
  }

  dimension: mta_add_broker_commission_woff {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_woff ;;
    hidden: yes
  }

  dimension: mta_add_broker_commission_xfees {
    type: number
    sql: ${TABLE}.mta_add_broker_commission_xfees ;;
    hidden: yes
  }

  dimension: mta_add_broker_iaf {
    type: number
    sql: ${TABLE}.mta_add_broker_iaf ;;
    hidden: yes
  }

  dimension: mta_add_broker_iaf_ipt {
    type: number
    sql: ${TABLE}.mta_add_broker_iaf_ipt ;;
    hidden: yes
  }

  dimension: mta_add_commission_aauicl {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl ;;
    hidden: yes
  }

  dimension: mta_add_commission_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl_bds ;;
    hidden: yes
  }

  dimension: mta_add_commission_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_add_commission_aauicl_cts ;;
    hidden: yes
  }

  dimension: mta_add_commission_bds {
    type: number
    sql: ${TABLE}.mta_add_commission_bds ;;
    hidden: yes
  }

  dimension: mta_add_commission_cts {
    type: number
    sql: ${TABLE}.mta_add_commission_cts ;;
    hidden: yes
  }

  dimension: mta_add_commission_other {
    type: number
    sql: ${TABLE}.mta_add_commission_other ;;
    hidden: yes
  }

  dimension: mta_add_commission_other_bds {
    type: number
    sql: ${TABLE}.mta_add_commission_other_bds ;;
    hidden: yes
  }

  dimension: mta_add_commission_other_cts {
    type: number
    sql: ${TABLE}.mta_add_commission_other_cts ;;
    hidden: yes
  }

  dimension: mta_add_flex_discount_amount {
    type: number
    sql: ${TABLE}.mta_add_flex_discount_amount ;;
    hidden: yes
  }

  dimension: mta_add_iaf_commission_discount {
    type: number
    sql: ${TABLE}.mta_add_iaf_commission_discount ;;
    hidden: yes
  }

  dimension: mta_add_ipt_amount {
    type: number
    sql: ${TABLE}.mta_add_ipt_amount ;;
    hidden: yes
  }

  dimension: mta_add_net_premium_aauicl {
    type: number
    sql: ${TABLE}.mta_add_net_premium_aauicl ;;
    hidden: yes
  }

  dimension: mta_add_net_premium_bds {
    type: number
    sql: ${TABLE}.mta_add_net_premium_bds ;;
    hidden: yes
  }

  dimension: mta_add_net_premium_cts {
    type: number
    sql: ${TABLE}.mta_add_net_premium_cts ;;
    hidden: yes
  }

  dimension: mta_add_net_premium_other {
    type: number
    sql: ${TABLE}.mta_add_net_premium_other ;;
    hidden: yes
  }

  dimension: mta_add_net_written_premium {
    type: number
    sql: ${TABLE}.mta_add_net_written_premium ;;
    hidden: yes
  }

  dimension: mta_add_premium_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_add_premium_aauicl_bds ;;
    hidden: yes
  }

  dimension: mta_add_premium_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_add_premium_aauicl_cts ;;
    hidden: yes
  }

  dimension: mta_add_premium_other_bds {
    type: number
    sql: ${TABLE}.mta_add_premium_other_bds ;;
    hidden: yes
  }

  dimension: mta_add_premium_other_cts {
    type: number
    sql: ${TABLE}.mta_add_premium_other_cts ;;
    hidden: yes
  }

  dimension: mta_add_undiscounted_commission {
    type: number
    sql: ${TABLE}.mta_add_undiscounted_commission ;;
    hidden: yes
  }

  dimension: mta_add_woff_discount_amount {
    type: number
    sql: ${TABLE}.mta_add_woff_discount_amount ;;
    hidden: yes
  }

  dimension: mta_cov_aauicl_bds {
    type: number
    sql: ${TABLE}.mta_cov_aauicl_bds ;;
    hidden: yes
  }

  dimension: mta_cov_aauicl_cts {
    type: number
    sql: ${TABLE}.mta_cov_aauicl_cts ;;
    hidden: yes
  }

  dimension: mta_cov_bds {
    type: number
    sql: ${TABLE}.mta_cov_bds ;;
    hidden: yes
  }

  dimension: mta_cov_cts {
    type: number
    sql: ${TABLE}.mta_cov_cts ;;
    hidden: yes
  }

  dimension: mta_cov_other_bds {
    type: number
    sql: ${TABLE}.mta_cov_other_bds ;;
    hidden: yes
  }

  dimension: mta_cov_other_cts {
    type: number
    sql: ${TABLE}.mta_cov_other_cts ;;
    hidden: yes
  }

  dimension_group: mta_dttm {
    type: time
    label: "MTA DTTM"
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year

    ]

    sql: ${TABLE}.mta_dttm ;;
    hidden: yes
  }

  dimension: mta_ind {
    type: number
    sql: ${TABLE}.mta_ind ;;
    label: "MTA Indicator"
    hidden: yes
  }

  dimension: nb_sw_flag {
    type: string
    label: "NB/SW Flag"
    sql: ${TABLE}.nb_sw_flag ;;
  }

  dimension: net_premium_aauicl_bds {
    type: number
    sql: ${TABLE}.net_premium_aauicl_bds ;;
  }

  dimension: net_premium_aauicl_cts {
    type: number
    sql: ${TABLE}.net_premium_aauicl_cts ;;
  }

  dimension: net_premium_other_bds {
    type: number
    sql: ${TABLE}.net_premium_other_bds ;;
  }

  dimension: net_premium_other_cts {
    type: number
    sql: ${TABLE}.net_premium_other_cts ;;
  }

  dimension: net_written_premium {
    type: number
    sql: ${TABLE}.net_written_premium ;;
  }

  dimension: net_written_premium_aauicl {
    type: number
    sql: ${TABLE}.net_written_premium_aauicl ;;
  }

  dimension: net_written_premium_bds {
    type: number
    sql: ${TABLE}.net_written_premium_bds ;;
  }

  dimension: net_written_premium_cts {
    type: number
    sql: ${TABLE}.net_written_premium_cts ;;
  }

  dimension: net_written_premium_other {
    type: number
    sql: ${TABLE}.net_written_premium_other ;;
  }

  dimension: oa11 {
    type: string
    label: "oa11 Area"
    sql: ${TABLE}.oa11 ;;
  }

  dimension: occupation_group {
    type: number
    label: "Occupation Group"
    sql: ${TABLE}.occupation_group ;;
  }

  dimension: orig_contents_amount {
    type: number
    sql: ${TABLE}.orig_contents_amount ;;
  }

  dimension: orig_p_ctscov {
    type: string
    sql: ${TABLE}.orig_p_ctscov ;;
  }

  dimension_group: original_inception_dttm {
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
    sql: ${TABLE}.original_inception_dttm ;;
  }

  dimension: oslaua {
    type: string
    map_layer_name: oslaua_map
    sql: ${TABLE}.oslaua ;;

  }

  dimension: p_adbds {
    type: string
    sql: ${TABLE}.p_adbds ;;
  }

  dimension: p_adcts {
    type: string
    sql: ${TABLE}.p_adcts ;;
  }

  dimension: p_alarm {
    type: string
    sql: ${TABLE}.p_alarm ;;
  }

  dimension: p_bedrooms {
    type: string
    sql: ${TABLE}.p_bedrooms ;;
  }

  dimension: p_bldval {
    type: string
    sql: ${TABLE}.p_bldval ;;
  }

  dimension: p_clmad {
    type: string
    sql: ${TABLE}.p_clmad ;;
  }

  dimension: p_clmall {
    type: string
    sql: ${TABLE}.p_clmall ;;
  }

  dimension: p_clmbds {
    type: string
    sql: ${TABLE}.p_clmbds ;;
  }

  dimension: p_clmcts {
    type: string
    sql: ${TABLE}.p_clmcts ;;
  }

  dimension: p_clmeow {
    type: string
    sql: ${TABLE}.p_clmeow ;;
  }

  dimension: p_clmflood {
    type: string
    sql: ${TABLE}.p_clmflood ;;
  }

  dimension: p_clmfreeyrs {
    type: string
    sql: ${TABLE}.p_clmfreeyrs ;;
  }

  dimension: p_clmother {
    type: string
    sql: ${TABLE}.p_clmother ;;
  }

  dimension: p_clmpps {
    type: string
    sql: ${TABLE}.p_clmpps ;;
  }

  dimension: p_clmstorm {
    type: string
    sql: ${TABLE}.p_clmstorm ;;
  }

  dimension: p_clmsubs {
    type: string
    sql: ${TABLE}.p_clmsubs ;;
  }

  dimension: p_clmtheft {
    type: string
    sql: ${TABLE}.p_clmtheft ;;
  }

  dimension: p_cover {
    type: string
    sql: ${TABLE}.p_cover ;;
  }

  dimension: p_csgroup {
    type: string
    sql: ${TABLE}.p_csgroup ;;
  }

  dimension: p_ctscov {
    type: string
    sql: ${TABLE}.p_ctscov ;;
  }

  dimension: p_detector {
    type: string
    sql: ${TABLE}.p_detector ;;
  }

  dimension: p_extracov {
    type: string
    sql: ${TABLE}.p_extracov ;;
  }

  dimension: p_fsthouse {
    type: string
    sql: ${TABLE}.p_fsthouse ;;
  }

  dimension: p_incident {
    type: string
    sql: ${TABLE}.p_incident ;;
  }

  dimension: p_locksdrs {
    type: string
    sql: ${TABLE}.p_locksdrs ;;
  }

  dimension: p_locksfrch {
    type: string
    sql: ${TABLE}.p_locksfrch ;;
  }

  dimension: p_lockspatio {
    type: string
    sql: ${TABLE}.p_lockspatio ;;
  }

  dimension: p_lockswds {
    type: string
    sql: ${TABLE}.p_lockswds ;;
  }

  dimension: p_memcallfreq {
    type: string
    sql: ${TABLE}.p_memcallfreq ;;
  }

  dimension: p_memcallnum {
    type: string
    sql: ${TABLE}.p_memcallnum ;;
  }

  dimension: p_memtenure {
    type: string
    sql: ${TABLE}.p_memtenure ;;
  }

  dimension: p_multjobs {
    type: string
    sql: ${TABLE}.p_multjobs ;;
  }

  dimension: p_nbsw {
    type: string
    sql: ${TABLE}.p_nbsw ;;
  }

  dimension: p_nhoodwatch {
    type: string
    sql: ${TABLE}.p_nhoodwatch ;;
  }

  dimension: p_occup {
    type: string
    sql: ${TABLE}.p_occup ;;
  }

  dimension: p_occupants {
    type: string
    sql: ${TABLE}.p_occupants ;;
  }

  dimension: p_phage {
    type: string
    sql: ${TABLE}.p_phage ;;
  }

  dimension: p_polyear {
    type: string
    sql: ${TABLE}.p_polyear ;;
  }

  dimension: p_proptype {
    type: string
    sql: ${TABLE}.p_proptype ;;
  }

  dimension: p_service {
    type: string
    sql: ${TABLE}.p_service ;;
  }

  dimension: p_specmaxs1 {
    type: string
    sql: ${TABLE}.p_specmaxs1 ;;
  }

  dimension: p_specmaxs3a {
    type: string
    sql: ${TABLE}.p_specmaxs3a ;;
  }

  dimension: p_specnums1 {
    type: string
    sql: ${TABLE}.p_specnums1 ;;
  }

  dimension: p_specnums3a {
    type: string
    sql: ${TABLE}.p_specnums3a ;;
  }

  dimension: p_spectots1 {
    type: string
    sql: ${TABLE}.p_spectots1 ;;
  }

  dimension: p_spectots3a {
    type: string
    sql: ${TABLE}.p_spectots3a ;;
  }

  dimension: p_unoccday {
    type: string
    sql: ${TABLE}.p_unoccday ;;
  }

  dimension: p_volxsbds {
    type: string
    sql: ${TABLE}.p_volxsbds ;;
  }

  dimension: p_volxscts {
    type: string
    sql: ${TABLE}.p_volxscts ;;
  }

  dimension: p_yearblt {
    type: string
    sql: ${TABLE}.p_yearblt ;;
  }

  dimension: p_yer {
    type: string
    sql: ${TABLE}.p_yer ;;
  }

  dimension: perc_broker_commission {
    type: number
    sql: ${TABLE}.perc_broker_commission ;;
  }

  dimension: perc_broker_commission_xfees {
    type: number
    sql: ${TABLE}.perc_broker_commission_xfees ;;
  }

  dimension: personal_exposure {
    type: number
    sql: ${TABLE}.personal_exposure ;;
  }

  dimension_group: policy_mta {
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
    sql: ${TABLE}.policy_mta_date ;;
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

  dimension: policy_period_fuwy {
    type: number
    sql: ${TABLE}.policy_period_fuwy ;;
  }

  dimension: policy_period_qs {
    type: number
    sql: ${TABLE}.policy_period_qs ;;
    label: "QS Period"
  }

  dimension_group: policy_start {
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
    sql: CAST(${TABLE}.policy_start_date AS TIMESTAMP WITHOUT TIME ZONE) ;;
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

  dimension_group: policy_start_wk {
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
    sql: ${TABLE}.policy_start_wk ;;
  }

  dimension: policy_start_yr {
    type: number
    sql: ${TABLE}.policy_start_yr ;;
  }

  dimension_group: policy_written_mth {
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
    sql: ${TABLE}.policy_written_mth ;;
  }

  dimension_group: policy_written_wk {
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
    sql: ${TABLE}.policy_written_wk ;;
  }

  dimension: policy_written_yr {
    type: number
    sql: ${TABLE}.policy_written_yr ;;
  }

  dimension: policy_year {
    type: number
    sql: ${TABLE}.policy_year ;;
  }

  dimension: postcode_full {
    type: string
    sql: ${TABLE}.postcode_full ;;
  }

  dimension: postcode_sector {
    type: string
    sql: ${TABLE}.postcode_sector ;;
  }

  dimension: postcode_area {
    type: string
    sql: CASE WHEN substring(${TABLE}.postcode_full,2,1) NOT IN ('0','1','2','3','4','5','6','7','8','9') THEN LEFT (${TABLE}.postcode_full,2)
ELSE LEFT (${TABLE}.postcode_full,1) END ;;
  }

  dimension_group: proposer1_dob {
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
    sql: ${TABLE}.proposer1_dob ;;
  }

  dimension: proposer1_forename {
    type: string
    sql: ${TABLE}.proposer1_forename ;;
  }

  dimension: proposer1_surname {
    type: string
    sql: ${TABLE}.proposer1_surname ;;
  }

  dimension: proposer1_title_desc {
    type: string
    sql: ${TABLE}.proposer1_title_desc ;;
  }

  dimension: proposer2_forename {
    type: string
    sql: ${TABLE}.proposer2_forename ;;
  }

  dimension: proposer2_surname {
    type: string
    sql: ${TABLE}.proposer2_surname ;;
  }

  dimension: provenance_code {
    type: string
    sql: ${TABLE}.provenance_code ;;
  }

  dimension: r_jba_adj {
    type: string
    sql: ${TABLE}.r_jba_adj ;;
  }

  dimension: r_mem_score {
    type: string
    sql: ${TABLE}.r_mem_score ;;
  }

  dimension: r_paymtd {
    type: string
    sql: ${TABLE}.r_paymtd ;;
  }

  dimension: r_tenure {
    type: string
    sql: ${TABLE}.r_tenure ;;
  }

  dimension: rand {
    type: number
    sql: ${TABLE}.rand ;;
  }

  dimension: rand2 {
    type: number
    sql: ${TABLE}.rand2 ;;
  }

  dimension_group: renewal {
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
    sql: ${TABLE}.renewal_date ;;
  }

  dimension: renfac1 {
    type: number
    sql: ${TABLE}.renfac1 ;;
  }

  dimension: renfac2 {
    type: number
    sql: ${TABLE}.renfac2 ;;
  }

  dimension: renfac3 {
    type: number
    sql: ${TABLE}.renfac3 ;;
  }

  dimension: sample_flag {
    type: string
    sql: ${TABLE}.sample_flag ;;
  }

  dimension: sched_error {
    type: number
    sql: ${TABLE}.sched_error ;;
  }

  dimension_group: schedule_cover_end_dttm {
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
    sql: ${TABLE}.schedule_cover_end_dttm ;;
    label: "Schedule Cover End DTTM"
  }

  dimension_group: schedule_cover_start_dttm {
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
    sql: ${TABLE}.schedule_cover_start_dttm ;;
    label: "Schedule Cover Start DTTM"
  }



  dimension: tia_combined_reference {
    type: string
    sql: ${TABLE}.tia_combined_reference ;;
  }

  dimension: tia_customer_no {
    type: number
    sql: ${TABLE}.tia_customer_no ;;
  }

  dimension: tia_reference {
    type: number
    sql: ${TABLE}.tia_reference ;;
  }

  dimension: tia_transaction_no {
    type: number
    sql: ${TABLE}.tia_transaction_no ;;
  }

  dimension: total_claims {
    type: number
    sql: ${TABLE}.total_claims ;;
  }

  dimension: total_incurred {
    type: number
    sql: ${TABLE}.total_incurred ;;
  }

  dimension_group: transaction {
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
    sql: ${TABLE}.transaction_date ;;
  }

  dimension_group: transaction_dttm {
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
    sql: ${TABLE}.transaction_dttm ;;
  }

  dimension: u_bususe {
    type: string
    sql: ${TABLE}.u_bususe ;;
  }

  dimension: u_convic {
    type: string
    sql: ${TABLE}.u_convic ;;
  }

  dimension: u_occnight {
    type: string
    sql: ${TABLE}.u_occnight ;;
  }

  dimension: u_occstatus {
    type: string
    sql: ${TABLE}.u_occstatus ;;
  }

  dimension: u_refused {
    type: string
    sql: ${TABLE}.u_refused ;;
  }

  dimension: u_repair {
    type: string
    sql: ${TABLE}.u_repair ;;
  }

  dimension: u_roof {
    type: string
    sql: ${TABLE}.u_roof ;;
  }

  dimension: u_selfcon {
    type: string
    sql: ${TABLE}.u_selfcon ;;
  }

  dimension: u_subs {
    type: string
    sql: ${TABLE}.u_subs ;;
  }

  dimension: u_unocc30 {
    type: string
    sql: ${TABLE}.u_unocc30 ;;
  }

  dimension: u_wall {
    type: string
    sql: ${TABLE}.u_wall ;;
  }

  dimension: undiscounted_commission {
    type: number
    sql: ${TABLE}.undiscounted_commission ;;
  }

  dimension: uprn {
    type: number
    sql: ${TABLE}.uprn ;;
  }

  dimension: uprn_join {
    type: number
    sql: ${TABLE}.uprn_join ;;
  }

  dimension: uw_policy_no {
    type: string
    sql: ${TABLE}.uw_policy_no ;;
    label: "UW Policy Number"
  }

  dimension: uw_tenure {
    type: number
    sql: ${TABLE}.uw_tenure ;;
  }

  dimension: aa_tenure {
    type: number
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: woff_discount_amount {
    type: number
    sql: ${TABLE}.woff_discount_amount ;;
  }

  dimension: xol_house_name {
    type: string
    sql: ${TABLE}.xol_house_name ;;
  }

  dimension: xol_street_name {
    type: string
    sql: ${TABLE}.xol_street_name ;;
  }

  dimension: xol_street_no {
    type: string
    sql: ${TABLE}.xol_street_no ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }





  measure: aauicl_covers_inforce {
    label: "AAUICL Covers In Force"
    type: sum
    sql:  ${TABLE}.aauicl_ifp_bds + ${TABLE}.aauicl_ifp_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_inforce_bds {
    label: "AAUICL IFP BDS"
    type: sum
    sql:  ${TABLE}.aauicl_ifp_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_inforce_cts {
    label: "AAUICL IFP CTS"
    type: sum
    sql:  ${TABLE}.aauicl_ifp_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_inforce_policies {
    label: "AAUICL IFP"
    type: sum
    sql:  ${TABLE}.aauicl_ifp ;;
    value_format_name: decimal_0
  }

  measure: exposure_combined {
    label: "Exposure - Combined"
    type: sum
    sql:  ${TABLE}.combined_exposure ;;
    value_format_name: decimal_0
  }

  measure: evy {
    label: "Exposure"
    type: sum
    sql:  ${TABLE}.exposure ;;
    value_format_name: decimal_0
    hidden: no
  }

  measure: bds_exposure {
    label: "Exposure - BDS"
    type: sum
    sql:  ${TABLE}.buildings_exposure ;;
    value_format_name: decimal_0
  }

  measure: cts_exposure {
    label: "Exposure - CTS"
    type: sum
    sql:  ${TABLE}.contents_exposure ;;
    value_format_name: decimal_0
  }

  measure: premium_earned {
    label: "Earned Premium"
    type: sum
    sql:  ${TABLE}.earned_premium ;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  measure: bds_premium_earned {
    label: "Earned Premium - BDS"
    type: sum
    sql:  ${TABLE}.buildings_earned_premium ;;
    value_format_name: decimal_0
  }

  measure: cts_premium_earned {
    label: "Earned Premium - CTS"
    type: sum
    sql:  ${TABLE}.contents_earned_premium ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_earned {
    label: "Earned RFQ INF"
    type: sum
    sql:  ${TABLE}.EARNED_RFQ_INF ;;
    value_format_name: decimal_0
  }

  measure: bds_earned_rfq_inf {
    label: "Earned RFQ INF - BDS"
    type: sum
    sql:  ${TABLE}.BUILDINGS_EARNED_RFQ_INF ;;
    value_format_name: decimal_0
  }

  measure: cts_earned_rfq_inf {
    label: "Earned RFQ INF - CTS"
    type: sum
    sql:  ${TABLE}.CONTENTS_EARNED_RFQ_INF ;;
    value_format_name: decimal_0
  }

  measure: rfq_wlc_earned {
    label: "Earned RFQ WLC"
    type: sum
    sql:  ${TABLE}.EARNED_RFQ_WLC ;;
    value_format_name: decimal_0
  }

  measure: bds_earned_rfq_wlc {
    label: "Earned RFQ WLC - BDS"
    type: sum
    sql:  ${TABLE}.BUILDINGS_EARNED_RFQ_WLC ;;
    value_format_name: decimal_0
  }

  measure: cts_earned_rfq_wlc {
    label: "Earned RFQ WLC - CTS"
    type: sum
    sql:  ${TABLE}.CONTENTS_EARNED_RFQ_WLC ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_earned {
    label: "Earned RPM INF"
    type: sum
    sql:  ${TABLE}.EARNED_RPM_INF ;;
    value_format_name: decimal_0
  }

  measure: bds_earned_rpm_inf {
    label: "Earned RPM INF - BDS"
    type: sum
    sql:  ${TABLE}.BUILDINGS_EARNED_RPM_INF ;;
    value_format_name: decimal_0
  }

  measure: cts_earned_rpm_inf {
    label: "Earned RPM INF - CTS"
    type: sum
    sql:  ${TABLE}.CONTENTS_EARNED_RPM_INF ;;
    value_format_name: decimal_0
  }

  measure: rpm_wlc_earned {
    label: "Earned RPM WLC"
    type: sum
    sql:  ${TABLE}.EARNED_RPM_WLC ;;
    value_format_name: decimal_0
  }

  measure: bds_earned_rpm_wlc {
    label: "Earned RPM WLC - BDS"
    type: sum
    sql:  ${TABLE}.BUILDINGS_EARNED_RPM_WLC ;;
    value_format_name: decimal_0
  }

  measure: cts_earned_rpm_wlc {
    label: "Earned RPM WLC - CTS"
    type: sum
    sql:  ${TABLE}.CONTENTS_EARNED_RPM_WLC ;;
    value_format_name: decimal_0
  }

  measure: claims_total {
    label: "Total Claims"
    type: sum
    sql:  ${TABLE}.total_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_claims {
    label: "Claims - BDS"
    type: sum
    sql:  ${TABLE}.buildings_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_claims {
    label: "Claims - CTS"
    type: sum
    sql:  ${TABLE}.contents_claims ;;
    value_format_name: decimal_0
  }

  measure: incurred_total {
    label: "Total Incurred"
    type: sum
    sql:  ${TABLE}.total_incurred ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: bds_incurred {
    label: "Incurred - BDS"
    type: sum
    sql:  ${TABLE}.buildings_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_incurred {
    label: "Incurred - CTS"
    type: sum
    sql:  ${TABLE}.contents_incurred ;;
    value_format_name: decimal_0
  }

  measure: incurred_total_weather {
    label: "Incurred - Weather"
    type: sum
    sql:  ${TABLE}.total_weather_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_incurred_weather {
    label: "Incurred - BDS Weather"
    type: sum
    sql:  ${TABLE}.buildings_weather_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_incurred_weather {
    label: "Incurred - CTS Weather"
    type: sum
    sql:  ${TABLE}.contents_weather_incurred ;;
    value_format_name: decimal_0
  }

  measure: claims_handing_fee {
    label: "Claims Handling Fee"
    type: sum
    sql: ${claim_fee_rate}*${TABLE}.tcs_claims ;;
    value_format_name: gbp_0
    group_label: "COR Expense Measures"
  }

  measure: claims_handing_fee_weather {
    label: "Claims Handling Fee - Weather"
    type: sum
    sql: ${claim_fee_rate}*${TABLE}.tcs_claims_weather ;;
    value_format_name: gbp_0
  }

  measure: claim_frequency {
    label: "AAUICL Claims Frequency"
    type: number
    sql:  1.0*${claims_total}/nullif(${exposure_combined},0) ;;
    value_format_name: percent_1
  }


  measure: bds_claim_frequency {
    label: "AAUICL Claims Frequency - BDS"
    type: number
    sql:  1.0*${bds_claims}/nullif(${bds_exposure},0) ;;
    value_format_name: percent_1
  }

  measure: cts_claim_frequency {
    label: "AAUICL Claims Frequency - CTS"
    type: number
    sql:  1.0*${cts_claims}/nullif(${cts_exposure},0) ;;
    value_format_name: percent_1

  }

  measure: loss_ratio {
    label: "AAUICL Loss Ratio"
    type: number
    sql:  1.0*${incurred_total}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: bds_loss_ratio {
    label: "AAUICL Loss Ratio - BDS"
    type: number
    sql:  1.0*${bds_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: cts_loss_ratio {
    label: "AAUICL Loss Ratio - CTS"
    type: number
    sql:  1.0*${cts_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_inf {
    label: "Modelled Claims Frequency"
    type: number
    sql:  1.0*${rfq_inf_earned}/nullif(${exposure_combined},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_inf_bds {
    label: "Modelled Claims Frequency - BDS"
    type: number
    sql:  1.0*${bds_earned_rfq_inf}/nullif(${bds_exposure},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_inf_cts {
    label: "Modelled Claims Frequency - CTS"
    type: number
    sql:  1.0*${cts_earned_rfq_inf}/nullif(${cts_exposure},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_wlc {
    label: "Modelled Claims Frequency (WLC)"
    type: number
    sql:  1.0*${rfq_wlc_earned}/nullif(${exposure_combined},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_wlc_bds {
    label: "Modelled Claims Frequency - BDS (WLC)"
    type: number
    sql:  1.0*${bds_earned_rfq_wlc}/nullif(${bds_exposure},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_claim_frequency_wlc_cts {
    label: "Modelled Claims Frequency - CTS (WLC)"
    type: number
    sql:  1.0*${cts_earned_rfq_wlc}/nullif(${cts_exposure},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_inf {
    label: "Modelled Loss Ratio"
    type: number
    sql:  1.0*${rpm_inf_earned}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_inf_bds {
    label: "Modelled Loss Ratio - BDS"
    type: number
    sql:  1.0*${bds_earned_rpm_inf}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_inf_cts {
    label: "Modelled Loss Ratio - CTS"
    type: number
    sql:  1.0*${cts_earned_rpm_inf}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_wlc {
    label: "Modelled Loss Ratio (WLC)"
    type: number
    sql:  1.0*${rpm_wlc_earned}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_wlc_bds {
    label: "Modelled Loss Ratio - BDS (WLC)"
    type: number
    sql:  1.0*${bds_earned_rpm_wlc}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_wlc_cts {
    label: "Modelled Loss Ratio - CTS (WLC)"
    type: number
    sql:  1.0*${cts_earned_rpm_wlc}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: commission_earned {
    label: "Earned Commission"
    type: sum
    sql:  ${TABLE}.EARNED_COMMISSION ;;
    value_format_name: decimal_0
  }

  measure: combined_exposure_ren {
    label: "Combined Exposure (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EXPOSURE + ${TABLE}.AAUICL_REN_CTS_EXPOSURE ;;
    value_format_name: decimal_0
  }

  measure: exposure_ren_bds {
    label: "Exposure - BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EXPOSURE ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: exposure_ren_cts {
    label: "Exposure - CTS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_CTS_EXPOSURE ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: earned_premium_ren {
    label: "Earned Premium (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EARNED_PREMIUM + ${TABLE}.AAUICL_REN_CTS_EARNED_PREMIUM ;;
    value_format_name: decimal_0
  }

  measure: earned_premium_ren_bds {
    label: "Earned Premium - BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EARNED_PREMIUM ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: earned_premium_ren_cts {
    label: "Earned Premium - CTS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_CTS_EARNED_PREMIUM ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: total_claims_ren {
    label: "Total Claims (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_CLAIMS + ${TABLE}.AAUICL_REN_CTS_CLAIMS ;;
    value_format_name: decimal_0
  }

  measure: claims_ren_bds {
    label: "Claims - BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_CLAIMS ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: claims_ren_cts {
    label: "Claims - CTS (Ren)"
    type: sum
    sql:  1.0*${TABLE}.AAUICL_REN_CTS_CLAIMS ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: total_incurred_ren {
    label: "Total Incurred (Ren)"
    type: sum
    sql:  1.0*${TABLE}.AAUICL_REN_BDS_INCURRED + ${TABLE}.AAUICL_REN_CTS_INCURRED ;;
    value_format_name: decimal_0
  }

  measure: incurred_ren_bds {
    label: "Incurred - BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_INCURRED ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: incurred_ren_cts {
    label: "Incurred - CTS (Ren)"
    type: sum
    sql:  1.0*${TABLE}.AAUICL_REN_CTS_INCURRED ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: earned_commission_ren {
    label: "Earned Commission (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EARNED_COMMISSION + ${TABLE}.AAUICL_REN_CTS_EARNED_COMMISSION ;;
    value_format_name: decimal_0
  }

  measure: earned_commission_ren_bds {
    label: "Earned Commission - BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS_EARNED_COMMISSION ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: earned_commission_ren_cts {
    label: "Earned Commission - CTS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_CTS_EARNED_COMMISSION ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: claim_frequency_ren {
    label: "Claims Frequency (REN)"
    type: number
    sql:  1.0*${total_claims_ren}/nullif(${combined_exposure_ren},0) ;;
    value_format_name: percent_1
  }

  measure: claim_frequency_ren_bds {
    label: "Claims Frequency - BDS (REN)"
    type: number
    sql:  1.0*${claims_ren_bds}/nullif(${exposure_ren_bds},0) ;;
    value_format_name: percent_1
  }

  measure: claim_frequency_ren_cts {
    label: "Claims Frequency - CTS (REN)"
    type: number
    sql:  1.0*${claims_ren_cts}/nullif(${exposure_ren_cts},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_ren {
    label: "AAUICL Loss Ratio (Ren)"
    type: number
    sql:  1.0*${total_incurred_ren}/nullif(${earned_premium_ren},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_ren_bds {
    label: "AAUICL Loss Ratio - BDS (Ren)"
    type: number
    sql:  1.0*${incurred_ren_bds}/nullif(${earned_premium_ren_bds},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_ren_cts {
    label: "AAUICL Loss Ratio - CTS (Ren)"
    type: number
    sql:  1.0*${incurred_ren_cts}/nullif(${earned_premium_ren_cts},0) ;;
    value_format_name: percent_1
  }

  measure: incidents_tcs {
    label: "TCS Incidents"
    type: sum
    sql:  ${TABLE}.TCS_INCIDENTS ;;
    value_format_name: decimal_0
  }

  measure: tcs_incidents_undev {
    label: "TCS Incidents (Undeveloped)"
    type: sum
    sql:  ${TABLE}.tcs_incidents_undeveloped ;;
    value_format_name: decimal_0
  }

  measure: claims_tcs {
    label: "TCS Claims"
    type: sum
    sql:  ${TABLE}.TCS_CLAIMS ;;
    value_format_name: decimal_0
  }


  measure: claims_tcs_weather {
    label: "TCS Claims - Weather"
    type: sum
    sql:  ${TABLE}.TCS_CLAIMS_WEATHER ;;
    value_format_name: decimal_0
  }

  measure: tcs_claim_freq {
    label: "TCS Chargeable Claims Frequency"
    type: number
    sql:  1.0*${claims_tcs}/nullif(${evy},0) ;;
    value_format_name: percent_1
  }

  measure: tcs_incident_freq_undev {
    label: "TCS Incident Frequency (undeveloped)"
    type: number
    sql:  1.0*${tcs_incidents_undev}/nullif(${evy},0) ;;
    value_format_name: percent_1
  }

  measure: tcs_incident_freq {
    label: "TCS Incident Frequency"
    type: number
    sql:  1.0*${incidents_tcs}/nullif(${evy},0) ;;
    value_format_name: percent_1
  }

  measure: claims_fee_ratio {
    label: "Claims Fee Ratio"
    type: number
    sql:  ${claims_handing_fee}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: claims_fee_ratio_aauicl {
    label: "Claims Fee Ratio (AAUICL)"
    type: number
    sql:  ${claims_handing_fee}/nullif((0.2*${premium_earned})+(0.8*0.16*${premium_earned}),0) ;;
    value_format_name: percent_1
  }

  measure: loss_claims_fee_ratio {
    label: "Loss & Claims Fee Ratio"
    type: number
    sql:  (${claims_handing_fee}+${incurred_total})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_claims_fee_ratio_aauicl {
    label: "Loss & Claims Fee Ratio (AAUICL)"
    type: number
    sql: (${claims_handing_fee}+(0.2*${incurred_total}))/nullif((0.2*${premium_earned})+(0.8*0.16*${premium_earned}),0) ;;
    value_format_name: percent_1
  }

  measure: bds_incurred_cap50k {
    label: "Incurred - BDS (50K Cap)"
    type: sum
    sql:  ${TABLE}.BUILDINGS_INCURRED_CAP50K ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: bds_incurred_cap100k {
    label: "Incurred - BDS (100K Cap)"
    type: sum
    sql:  ${TABLE}.BUILDINGS_INCURRED_CAP100K ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: cts_incurred_cap15k {
    label: "Incurred - CTS (15K Cap)"
    type: sum
    sql:  ${TABLE}.CONTENTS_INCURRED_CAP15K ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: cts_incurred_cap25k {
    label: "Incurred - CTS (25K Cap)"
    type: sum
    sql:  ${TABLE}.CONTENTS_INCURRED_CAP25K ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: loss_ratio_lowcap {
    label: "AAUICL Loss Ratio - low cap"
    type: number
    sql:  1.0*(${bds_incurred_cap50k}+${cts_incurred_cap15k})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_highcap {
    label: "AAUICL Loss Ratio - high cap"
    type: number
    sql:  1.0*(${bds_incurred_cap100k}+${cts_incurred_cap25k})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: bds_loss_ratio_cap50 {
    label: "AAUICL Loss Ratio - BDS CAP50"
    type: number
    sql:  1.0*${bds_incurred_cap50k}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: bds_loss_ratio_cap100 {
    label: "AAUICL Loss Ratio - BDS CAP100"
    type: number
    sql:  1.0*${bds_incurred_cap100k}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: cts_loss_ratio_cap15 {
    label: "AAUICL Loss Ratio - CTS CAP15"
    type: number
    sql:  1.0*${cts_incurred_cap15k}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: cts_loss_ratio_cap25 {
    label: "AAUICL Loss Ratio - CTS CAP25"
    type: number
    sql:  1.0*${cts_incurred_cap25k}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  # ----- Claims by Peril ------

  measure: bds_ad_claims {
    label: "Claims - BDS AD"
    type: sum
    sql:  ${TABLE}.buildings_ad_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_eow_claims {
    label: "Claims - BDS EoW"
    type: sum
    sql:  ${TABLE}.buildings_eow_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_fire_claims {
    label: "Claims - BDS Fire"
    type: sum
    sql:  ${TABLE}.buildings_fire_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_flood_claims {
    label: "Claims - BDS Flood"
    type: sum
    sql:  ${TABLE}.buildings_flood_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_other_claims {
    label: "Claims - BDS Other"
    type: sum
    sql:  ${TABLE}.buildings_other_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_storm_claims {
    label: "Claims - BDS Storm"
    type: sum
    sql:  ${TABLE}.buildings_storm_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_subsidence_claims {
    label: "Claims - BDS Subsidence"
    type: sum
    sql:  ${TABLE}.buildings_subsidence_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_theft_claims {
    label: "Claims - BDS Theft"
    type: sum
    sql:  ${TABLE}.buildings_theft_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_ad_claims {
    label: "Claims - CTS AD"
    type: sum
    sql:  ${TABLE}.contents_ad_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_eow_claims {
    label: "Claims - CTS EoW"
    type: sum
    sql:  ${TABLE}.contents_eow_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_fire_claims {
    label: "Claims - CTS Fire"
    type: sum
    sql:  ${TABLE}.contents_fire_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_flood_claims {
    label: "Claims - CTS Flood"
    type: sum
    sql:  ${TABLE}.contents_flood_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_other_claims {
    label: "Claims - CTS Other"
    type: sum
    sql:  ${TABLE}.contents_other_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_storm_claims {
    label: "Claims - CTS Storm"
    type: sum
    sql:  ${TABLE}.contents_storm_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_theft_claims {
    label: "Claims - CTS Theft"
    type: sum
    sql:  ${TABLE}.contents_theft_claims ;;
    value_format_name: decimal_0
  }

  measure: cts_pps_claims {
    label: "Claims - CTS PPS"
    type: sum
    sql:  ${TABLE}.contents_pps_claims ;;
    value_format_name: decimal_0
  }

  measure: bds_ad_incurred {
    label: "Incurred - BDS AD"
    type: sum
    sql:  ${TABLE}.buildings_ad_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_eow_incurred {
    label: "Incurred - BDS EoW"
    type: sum
    sql:  ${TABLE}.buildings_eow_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_fire_incurred {
    label: "Incurred - BDS Fire"
    type: sum
    sql:  ${TABLE}.buildings_fire_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_flood_incurred {
    label: "Incurred - BDS Flood"
    type: sum
    sql:  ${TABLE}.buildings_flood_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_other_incurred {
    label: "Incurred - BDS Other"
    type: sum
    sql:  ${TABLE}.buildings_other_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_storm_incurred {
    label: "Incurred - BDS Storm"
    type: sum
    sql:  ${TABLE}.buildings_storm_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_subsidence_incurred {
    label: "Incurred - BDS Subsidence"
    type: sum
    sql:  ${TABLE}.buildings_subsidence_incurred ;;
    value_format_name: decimal_0
  }

  measure: bds_theft_incurred {
    label: "Incurred - BDS Theft"
    type: sum
    sql:  ${TABLE}.buildings_theft_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_ad_incurred {
    label: "Incurred - CTS AD"
    type: sum
    sql:  ${TABLE}.contents_ad_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_eow_incurred {
    label: "Incurred - CTS EoW"
    type: sum
    sql:  ${TABLE}.contents_eow_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_fire_incurred {
    label: "Incurred - CTS Fire"
    type: sum
    sql:  ${TABLE}.contents_fire_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_flood_incurred {
    label: "Incurred - CTS Flood"
    type: sum
    sql:  ${TABLE}.contents_flood_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_other_incurred {
    label: "Incurred - CTS Other"
    type: sum
    sql:  ${TABLE}.contents_other_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_storm_incurred {
    label: "Incurred - CTS Storm"
    type: sum
    sql:  ${TABLE}.contents_storm_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_theft_incurred {
    label: "Incurred - CTS Theft"
    type: sum
    sql:  ${TABLE}.contents_theft_incurred ;;
    value_format_name: decimal_0
  }

  measure: cts_pps_incurred {
    label: "Incurred - CTS PPS"
    type: sum
    sql:  ${TABLE}.contents_pps_incurred ;;
    value_format_name: decimal_0
  }


  measure: loss_ratio_ad {
    label: "Actual Loss Ratio - Peril AD"
    type: number
    sql:  1.0*(${bds_ad_incurred}+${cts_ad_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_eow {
    label: "Actual Loss Ratio - Peril EoW"
    type: number
    sql:  1.0*(${bds_eow_incurred}+${cts_eow_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_fire {
    label: "Actual Loss Ratio - Peril Fire"
    type: number
    sql:  1.0*(${bds_fire_incurred}+${cts_fire_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_flood {
    label: "Actual Loss Ratio - Peril Flood"
    type: number
    sql:  1.0*(${bds_flood_incurred}+${cts_flood_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_other {
    label: "Actual Loss Ratio - Peril Other"
    type: number
    sql:  1.0*(${bds_other_incurred}+${cts_other_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_storm {
    label: "Actual Loss Ratio - Peril Storm"
    type: number
    sql:  1.0*(${bds_storm_incurred}+${cts_storm_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_subsidence {
    label: "Actual Loss Ratio - Peril Subsidence"
    type: number
    sql:  1.0*${bds_subsidence_incurred}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_theft {
    label: "Actual Loss Ratio - Peril Theft"
    type: number
    sql:  1.0*(${bds_theft_incurred}+${cts_theft_incurred})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_pps {
    label: "Actual Loss Ratio - Peril PPS"
    type: number
    sql:  1.0*${cts_pps_incurred}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }



  measure: rfq_inf_bds_ad_earned {
    label: "Earned RFQ INF BDS AD"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_ad ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_eow_earned {
    label: "Earned RFQ INF BDS EoW"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_eow ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_fire_earned {
    label: "Earned RFQ INF BDS Fire"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_fire ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_flood_earned {
    label: "Earned RFQ INF BDS Flood"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_flood ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_other_earned {
    label: "Earned RFQ INF BDS Other"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_other ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_storm_earned {
    label: "Earned RFQ INF BDS Storm"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_storm ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_subsidence_earned {
    label: "Earned RFQ INF BDS Subsidence"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_subsidence ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_bds_theft_earned {
    label: "Earned RFQ INF BDS Theft"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_bds_theft ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_ad_earned {
    label: "Earned RFQ INF CTS AD"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_ad ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_eow_earned {
    label: "Earned RFQ INF CTS EoW"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_eow ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_fire_earned {
    label: "Earned RFQ INF CTS Fire"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_fire ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_flood_earned {
    label: "Earned RFQ INF CTS Flood"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_flood ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_other_earned {
    label: "Earned RFQ INF CTS Other"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_other ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_storm_earned {
    label: "Earned RFQ INF CTS Storm"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_storm ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_cts_theft_earned {
    label: "Earned RFQ INF CTS Theft"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_cts_theft ;;
    value_format_name: decimal_0
  }

  measure: rfq_inf_pps_combined_earned {
    label: "Earned RFQ INF PPS Combined"
    type: sum
    sql:  ${TABLE}.earned_rfq_inf_pps_combined ;;
    value_format_name: decimal_0
  }




  measure: rpm_inf_bds_ad_earned {
    label: "Earned RPM INF BDS AD"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_ad ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_eow_earned {
    label: "Earned RPM INF BDS EoW"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_eow ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_fire_earned {
    label: "Earned RPM INF BDS Fire"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_fire ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_flood_earned {
    label: "Earned RPM INF BDS Flood"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_flood ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_other_earned {
    label: "Earned RPM INF BDS Other"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_other ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_storm_earned {
    label: "Earned RPM INF BDS Storm"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_storm ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_subsidence_earned {
    label: "Earned RPM INF BDS Subsidence"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_subsidence ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_bds_theft_earned {
    label: "Earned RPM INF BDS Theft"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_bds_theft ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_ad_earned {
    label: "Earned RPM INF CTS AD"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_ad ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_eow_earned {
    label: "Earned RPM INF CTS EoW"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_eow ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_fire_earned {
    label: "Earned RPM INF CTS Fire"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_fire ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_flood_earned {
    label: "Earned RPM INF CTS Flood"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_flood ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_other_earned {
    label: "Earned RPM INF CTS Other"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_other ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_storm_earned {
    label: "Earned RPM INF CTS Storm"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_storm ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_cts_theft_earned {
    label: "Earned RPM INF CTS Theft"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_cts_theft ;;
    value_format_name: decimal_0
  }

  measure: rpm_inf_pps_combined_earned {
    label: "Earned RPM INF PPS Combined"
    type: sum
    sql:  ${TABLE}.earned_rpm_inf_pps_combined ;;
    value_format_name: decimal_0
  }



  measure: modelled_loss_ratio_ad {
    label: "Modelled Loss Ratio - Peril AD"
    type: number
    sql:  1.0*(${rpm_inf_bds_ad_earned}+${rpm_inf_cts_ad_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_eow {
    label: "Modelled Loss Ratio - Peril EoW"
    type: number
    sql:  1.0*(${rpm_inf_bds_eow_earned}+${rpm_inf_cts_eow_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_fire {
    label: "Modelled Loss Ratio - Peril Fire"
    type: number
    sql:  1.0*(${rpm_inf_bds_fire_earned}+${rpm_inf_cts_fire_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_flood {
    label: "Modelled Loss Ratio - Peril Flood"
    type: number
    sql:  1.0*(${rpm_inf_bds_flood_earned}+${rpm_inf_cts_flood_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_other {
    label: "Modelled Loss Ratio - Peril Other"
    type: number
    sql:  1.0*(${rpm_inf_bds_other_earned}+${rpm_inf_cts_other_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_storm {
    label: "Modelled Loss Ratio - Peril Storm"
    type: number
    sql:  1.0*(${rpm_inf_bds_storm_earned}+${rpm_inf_cts_storm_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_subsidence {
    label: "Modelled Loss Ratio - Peril Subsidence"
    type: number
    sql:  1.0*${rpm_inf_bds_subsidence_earned}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_theft {
    label: "Modelled Loss Ratio - Peril Theft"
    type: number
    sql:  1.0*(${rpm_inf_bds_theft_earned}+${rpm_inf_cts_theft_earned})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_pps {
    label: "Modelled Loss Ratio - Peril PPS"
    type: number
    sql:  1.0*${rpm_inf_pps_combined_earned}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_ad {
    label: "Loss Ratio - BDS AD"
    type: number
    sql:  1.0*${bds_ad_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_eow {
    label: "Loss Ratio - BDS EoW"
    type: number
    sql:  1.0*${bds_eow_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_fire {
    label: "Loss Ratio - BDS Fire"
    type: number
    sql:  1.0*${bds_fire_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_flood {
    label: "Loss Ratio - BDS Flood"
    type: number
    sql:  1.0*${bds_flood_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_other {
    label: "Loss Ratio - BDS Other"
    type: number
    sql:  1.0*${bds_other_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_storm {
    label: "Loss Ratio - BDS Storm"
    type: number
    sql:  1.0*${bds_storm_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_subsidence {
    label: "Loss Ratio - BDS Subsidence"
    type: number
    sql:  1.0*${bds_subsidence_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_bds_theft {
    label: "Loss Ratio - BDS Theft"
    type: number
    sql:  1.0*${bds_theft_incurred}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }


  measure: loss_ratio_cts_ad {
    label: "Loss Ratio - CTS AD"
    type: number
    sql:  1.0*${cts_ad_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_eow {
    label: "Loss Ratio - CTS EoW"
    type: number
    sql:  1.0*${cts_eow_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_fire {
    label: "Loss Ratio - CTS Fire"
    type: number
    sql:  1.0*${cts_fire_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_flood {
    label: "Loss Ratio - CTS Flood"
    type: number
    sql:  1.0*${cts_flood_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_other {
    label: "Loss Ratio - CTS Other"
    type: number
    sql:  1.0*${cts_other_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_storm {
    label: "Loss Ratio - CTS Storm"
    type: number
    sql:  1.0*${cts_storm_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_theft {
    label: "Loss Ratio - CTS Theft"
    type: number
    sql:  1.0*${cts_theft_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: loss_ratio_cts_pps {
    label: "Loss Ratio - CTS PPS"
    type: number
    sql:  1.0*${cts_pps_incurred}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }



  measure: modelled_loss_ratio_bds_ad {
    label: "Modelled Loss Ratio - BDS AD"
    type: number
    sql:  1.0*${rpm_inf_bds_ad_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_eow {
    label: "Modelled Loss Ratio - BDS EoW"
    type: number
    sql:  1.0*${rpm_inf_bds_eow_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_fire {
    label: "Modelled Loss Ratio - BDS Fire"
    type: number
    sql:  1.0*${rpm_inf_bds_fire_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_flood {
    label: "Modelled Loss Ratio - BDS Flood"
    type: number
    sql:  1.0*${rpm_inf_bds_flood_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_other {
    label: "Modelled Loss Ratio - BDS Other"
    type: number
    sql:  1.0*${rpm_inf_bds_other_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_storm {
    label: "Modelled Loss Ratio - BDS Storm"
    type: number
    sql:  1.0*${rpm_inf_bds_storm_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_subsidence {
    label: "Modelled Loss Ratio - BDS Subsidence"
    type: number
    sql:  1.0*${rpm_inf_bds_subsidence_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_bds_theft {
    label: "Modelled Loss Ratio - BDS Theft"
    type: number
    sql:  1.0*${rpm_inf_bds_theft_earned}/nullif(${bds_premium_earned},0) ;;
    value_format_name: percent_1
  }


  measure: modelled_loss_ratio_cts_ad {
    label: "Modelled Loss Ratio - CTS AD"
    type: number
    sql:  1.0*${rpm_inf_cts_ad_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_eow {
    label: "Modelled Loss Ratio - CTS EoW"
    type: number
    sql:  1.0*${rpm_inf_cts_eow_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_fire {
    label: "Modelled Loss Ratio - CTS Fire"
    type: number
    sql:  1.0*${rpm_inf_cts_fire_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_flood {
    label: "Modelled Loss Ratio - CTS Flood"
    type: number
    sql:  1.0*${rpm_inf_cts_flood_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_other {
    label: "Modelled Loss Ratio - CTS Other"
    type: number
    sql:  1.0*${rpm_inf_cts_other_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_storm {
    label: "Modelled Loss Ratio - CTS Storm"
    type: number
    sql:  1.0*${rpm_inf_cts_storm_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_theft {
    label: "Modelled Loss Ratio - CTS Theft"
    type: number
    sql:  1.0*${rpm_inf_cts_theft_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  measure: modelled_loss_ratio_cts_pps {
    label: "Modelled Loss Ratio - CTS PPS"
    type: number
    sql:  1.0*${rpm_inf_pps_combined_earned}/nullif(${cts_premium_earned},0) ;;
    value_format_name: percent_1
  }

  ### Earned Sum Insured

  measure: sum_insured_earned {
    label: "Earned Sum Insured"
    type: sum
    sql:  ${TABLE}.earned_sum_insured ;;
    value_format_name: decimal_0
  }

  measure: sum_insured_earned_bds{
    label: "Earned Sum Insured - BDS"
    type: sum
    sql:  ${TABLE}.buildings_earned_sum_insured ;;
    value_format_name: decimal_0
  }

  measure: sum_insured_earned_cts {
    label: "Earned Sum Insured - CTS"
    type: sum
    sql:  ${TABLE}.contents_earned_sum_insured ;;
    value_format_name: decimal_0
  }

  measure: sum_insured_earned_annualised {
    label: "Earned Sum Insured Annualised"
    type: sum
    sql:  ${TABLE}.earned_sum_insured*365.25/extract('day',last_day(${TABLE}.exposure_mth)) ;;
    value_format_name: decimal_0
  }


### Weather Losses as % of TIV

  measure: weather_losses_perc_earned_tiv_modelled {
    label: "All Weather Losses as % of Earned TIV (modelled)"
    type: number
    sql:  1.0*(${rpm_inf_bds_storm_earned}+${rpm_inf_cts_storm_earned}+${rpm_inf_bds_flood_earned}+${rpm_inf_cts_flood_earned})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  # Need to add modelled weather losses + modelled claims handing fee

  measure: storm_losses_perc_earned_tiv_modelled {
    label: "Storm Losses as % of Earned TIV (modelled)"
    type: number
    sql:  1.0*(${rpm_inf_bds_storm_earned}+${rpm_inf_cts_storm_earned})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: flood_losses_perc_earned_tiv_modelled {
    label: "Flood Losses as % of Earned TIV (modelled)"
    type: number
    sql:  1.0*(${rpm_inf_bds_flood_earned}+${rpm_inf_cts_flood_earned})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: weather_losses_perc_earned_tiv_actual {
    label: "All Weather Losses as % of Earned TIV (actual)"
    type: number
    sql:  1.0*(${incurred_total_weather})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: weather_losses_chf_perc_earned_tiv_actual {
    label: "All Weather Losses + Claims Handling Fee as % of Earned TIV (actual)"
    type: number
    sql:  1.0*(${incurred_total_weather}+${claims_handing_fee_weather})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: storm_losses_perc_earned_tiv_actual {
    label: "Storm Losses as % of Earned TIV (actual)"
    type: number
    sql:  1.0*(${bds_storm_incurred}+${cts_storm_incurred})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: flood_losses_perc_earned_tiv_actual {
    label: "Flood Losses as % of Earned TIV (actual)"
    type: number
    sql:  1.0*(${bds_flood_incurred}+${cts_flood_incurred})/nullif(${sum_insured_earned},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  # Weather Losses as % of ANNUALISED Actual TIV

  measure: weather_losses_chf_perc_earned_tiv_actual_annualised {
    label: "All Weather Losses + Claims Handling Fee as % of Annualised TIV (actual)"
    type: number
    sql:  1.0*(${incurred_total_weather}+${claims_handing_fee_weather})/nullif(${sum_insured_earned_annualised},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  measure: weather_losses_perc_earned_tiv_actual_annualised {
    label: "All Weather Losses as % of Annualised TIV (actual)"
    type: number
    sql:  1.0*(${incurred_total_weather})/nullif(${sum_insured_earned_annualised},0) ;;
    value_format_name: percent_4
    group_label: "Weather Losses as % of Earned TIV"
  }

  ### Fields for COR

### Income ###

  measure: earned_premium_netcatre {
    label: "Earned Premium Net CatRe"
    type: sum
    sql:  ${TABLE}.earned_premium*(1-${cat_xol_rate}) ;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  measure: earned_premium_pure {
    label: "Earned Premium (AAUICL)"
    type: sum
    sql:  ${seed_rate}*${TABLE}.earned_premium;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }


  measure: earned_premium_pure_netcatre {
    label: "Earned Premium Net CatRe (AAUICL)"
    type: sum
    sql:  ${seed_rate}*${TABLE}.earned_premium*(1-${cat_xol_rate}) - (${TABLE}.earned_premium*${cat_xol_topup_rate}) ;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  measure: earned_gross_premium {
    label: "Earned Gross Premium"
    type: sum
    sql:  ${TABLE}.earned_premium + ${TABLE}.earned_commission ;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  measure: earned_gross_premium_netcatre {
    label: "Earned Gross Premium Net CatRe"
    type: sum
    sql:  ${TABLE}.earned_premium*(1-${cat_xol_rate}) + ${TABLE}.earned_commission ;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  measure: earned_gross_premium_pure {
    label: "Earned Gross Premium (AAUICL)"
    type: sum
    sql:  ${seed_rate}*${TABLE}.earned_premium + ${TABLE}.earned_commission;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }


  measure: earned_gross_premium_pure_netcatre {
    label: "Earned Gross Premium Net CatRe (AAUICL)"
    type: sum
    sql:  ${seed_rate}*${TABLE}.earned_premium*(1-${cat_xol_rate}) - (${TABLE}.earned_premium*${cat_xol_topup_rate}) + ${TABLE}.earned_commission;;
    value_format_name: decimal_0
    group_label: "COR Income Measures"
  }

  ### Expenses ###

  ## NEEDS UPDATING FOR 2021 ###

  measure: cat_cost {
    label: "Cat XoL Cost"
    type: sum
    sql: ${TABLE}.earned_premium*${cat_xol_rate} ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: cat_cost_topup {
    label: "Cat XoL Cost (Top Up Layer)"
    type: sum
    sql: ${TABLE}.earned_premium*${cat_xol_topup_rate} ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: flood_re_levy {
    label: "Flood Re Levy"
    type: sum
    sql: ${TABLE}.earned_premium*${flood_re_rate} ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: fixed_commission_costs {
    label: "Fixed Commission (£)"
    type: sum
    sql: ${fixed_commission_rate}*${TABLE}.earned_premium ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: claims_handing_fee_qs {
    label: "Claims Handling Fee (Quota Share)"
    type: sum
    sql: case when ${TABLE}.policy_period_qs in(1,2,3) then 0 else ${claim_fee_rate}*${TABLE}.tcs_claims end ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: claims_handing_fee_aauicl {
    label: "Claims Handling Fee (Incurred)"
    type: sum
    sql: case when ${TABLE}.policy_period_qs in(1,2,3) then ${claim_fee_rate}*${TABLE}.tcs_claims else ${seed_rate}*${claim_fee_rate}*${TABLE}.tcs_claims end ;;
    value_format_name: decimal_0
    group_label: "COR Expense Measures"
  }

  measure: abe_projected_incurred{
    label: "ABE Projected Incurred"
    type: sum
    sql: ${TABLE}.earned_premium*${latest_abe_rate} ;;
    value_format_name: decimal_0
    group_label: "COR Incurred Measures"
  }

#### COR Calculations ###

 measure: cor_actual {
    label: "COR Actual"
    type: number
    sql: 1.0*(${cat_cost_topup}+${cat_cost}+${flood_re_levy}+${claims_handing_fee}+${incurred_total})/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: cor_actual_netcatre {
    label: "COR Actual Net CatRe"
    type: number
    sql: 1.0*(${flood_re_levy}+${claims_handing_fee}+${incurred_total})/nullif(${earned_premium_netcatre},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: cor_actual_pure {
    label: "COR Actual Pure (AAUICL)"
    type: number
    sql: 1.0*(${cat_cost_topup}+ ${seed_rate}*(${cat_cost}+${flood_re_levy}+${incurred_total})+${claims_handing_fee_aauicl}-${fixed_commission_costs})/nullif(${earned_premium_pure},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: cor_actual_pure_netcatre {
    label: "COR Actual Pure Net Catre (AAUICL)"
    type: number
    sql: 1.0*(${seed_rate}*(${flood_re_levy}+${incurred_total})+${claims_handing_fee_aauicl}-${fixed_commission_costs})/nullif(${earned_premium_pure_netcatre},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: group_cor_actual {
    label: "Group COR Actual"
    type: number
    sql: 1.0*(${cat_cost_topup}+${cat_cost}+${flood_re_levy}+${claims_handing_fee}+${incurred_total})/nullif(${earned_gross_premium},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: group_cor_actual_netcatre {
    label: "Group COR Actual Net CatRe"
    type: number
    sql: 1.0*(${flood_re_levy}+${claims_handing_fee}+${incurred_total})/nullif(${earned_gross_premium_netcatre},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: group_cor_actual_pure {
    label: "Group COR Actual Pure (AAUICL)"
    type: number
    sql: 1.0*(${cat_cost_topup}+${seed_rate}*(${cat_cost}+${flood_re_levy}+${incurred_total})+${claims_handing_fee_aauicl}-${fixed_commission_costs})/nullif(${earned_gross_premium_pure},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }

  measure: group_cor_actual_pure_netcatre {
    label: "Group COR Actual Pure Net Catre (AAUICL)"
    type: number
    sql: 1.0*(${seed_rate}*(${flood_re_levy}+${incurred_total})+${claims_handing_fee_aauicl}-${fixed_commission_costs})/nullif(${earned_gross_premium_pure_netcatre},0) ;;
    value_format_name: percent_1
    group_label: "COR Measures"
  }



##### QS Measure Ratios

  measure: abe_by_uw_year{
    label: "ABE by UW Year"
    type: number
    sql: 1.0*${abe_projected_incurred}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
    group_label: "QS Ratios"
  }

  measure: fixed_commission {
    label: "Fixed Commission"
    type: number
    sql: ${fixed_commission_costs}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
    group_label: "QS Ratios"
  }

  measure: flood_re_ratio {
    label: "Flood Re Ratio"
    type: number
    sql: 1.0*${flood_re_levy}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
    group_label: "QS Ratios"
  }

  measure: cat_cost_ratio {
    label: "Cat Cost Ratio"
    type: number
    sql: 1.0*${cat_cost}/nullif(${premium_earned},0) ;;
    value_format_name: percent_1
    group_label: "QS Ratios"
  }





  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      tia_reference,
      tia_customer_no,
      tia_transaction_no,
      uw_policy_no,
      proposer1_surname,
      proposer1_forename,
      proposer2_surname,
      proposer2_forename,
    ]
  }
}
