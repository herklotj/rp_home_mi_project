view: lk_h_policy_history {
  derived_table: {
    sql:

    SELECT *
    FROM actian.lk_h_policy_history_scored
    WHERE SCHEDULE_COVER_START_DTTM = ANNUAL_COVER_START_DTTM
    AND   CFI_IND = 0
    ;;
  }

  dimension: aa_logo_new {
    type: string
    sql: 1 ;;
    html: <img src="https://i.ibb.co/9yYnQjL/AA-logo-new.png" height="100" /> ;;
  }

  dimension: aa_logo_old {
    type: string
    sql: 1 ;;
    html: <img src="https://i.ibb.co/svTXf6M/AA-logo-old.png" height="100" /> ;;
  }

  dimension: uw_policy_no {
    type: string
    sql: ${TABLE}.uw_policy_no ;;
    label: "UW Policy Number"
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
      year,
      fiscal_year
    ]
    sql: ${TABLE}.transaction_dttm ;;
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
      year,
      fiscal_year
    ]
    sql: CAST(${TABLE}.policy_start_date AS TIMESTAMP WITHOUT TIME ZONE) ;;
  }

  dimension_group: inception_date {
    label: "Inception"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      fiscal_year
    ]
    sql: ${TABLE}.inception_dt ;;
  }

  dimension_group: _original_inception_date {
    label: "Original Inception"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.original_inception_dttm ;;
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

  dimension: aa_tenure {
    label: "AA Tenure (3+)"
    type: tier
    tiers: [0,1,2,3]
    style: integer
    sql: ${TABLE}.aa_tenure ;;
  }

  dimension: uw_tenure {
    label: "UW Tenure (3+)"
    type: tier
    tiers: [0,1,2,3]
    style: integer
    sql: ${TABLE}.uw_tenure ;;
  }


  dimension: aauicl_modelled_loss_ratio_inf {
    description: "Modelled Net Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts),0));;
  }

  dimension: aauicl_modelled_loss_ratio_wlc {
    description: "Modelled Net Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_inf {
    description: "Modelled Gross Loss Ratio INF"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: aauicl_modelled_gross_loss_ratio_wlc {
    description: "Modelled Gross Loss Ratio WLC"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0]
    value_format_name: percent_0
    sql: (${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc)/
                (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: commission_as_percent_of_gross_premium {
    description: "Commission as % of Gross Premium"
    type: tier
    style:  interval
    tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7]
    value_format_name: percent_0
    sql: (${TABLE}.broker_commission_aauicl)/
      (nullif((${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl),0));;
  }

  dimension: aauicl_net_premium_banded_5 {
    label: "AAUICL Net Premium (£5 Banded)"
    type: tier
    style:  integer
    tiers: [20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250]
    value_format_name: gbp_0
    sql: ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts;;
    group_label: "Premium Distributions"
  }

  dimension: aauicl_net_premium_banded_10 {
    label: "AAUICL Net Premium (£10 Banded)"
    type: tier
    style:  integer
    tiers: [20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500]
    value_format_name: gbp_0
    sql: ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts;;
    group_label: "Premium Distributions"
  }

  dimension: aauicl_gross_premium_banded_5 {
    label: "AAUICL Gross Premium (£5 Banded)"
    type: tier
    style:  integer
    tiers: [20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155,160,165,170,175,180,185,190,195,200,205,210,215,220,225,230,235,240,245,250]
    value_format_name: gbp_0
    sql: ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl;;
    group_label: "Premium Distributions"
  }

  dimension: aauicl_gross_premium_banded_10 {
    label: "AAUICL Gross Premium (£10 Banded)"
    type: tier
    style:  integer
    tiers: [20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,300,310,320,330,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500]
    value_format_name: gbp_0
    sql: ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts + ${TABLE}.broker_commission_aauicl;;
    group_label: "Premium Distributions"
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

  dimension: sub_channel {
    type: string
    sql: case when ${TABLE}.provenance_code IN(089,098,293,433,434,467,833,834) then 'Money Supermarket' else
         case when ${TABLE}.provenance_code IN(091,092,105,106,827,828,829,830) then 'Compare the Market' else
         case when ${TABLE}.provenance_code IN(137,096,825,826) then 'Confused' else
         case when ${TABLE}.provenance_code IN(292,102,823,824) then 'Go Compare' else
        'Other' end end end end ;;
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

  measure: aauicl_policy_count {
    label: "AAUICL Policy Count"
    type: sum
    sql: greatest(${TABLE}.aauicl_ind_bds,${TABLE}.aauicl_ind_cts) ;;
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

  measure: aauicl_net_premium_bds {
    label: "AAUICL Net Written Premium BDS"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_premium_cts {
    label: "AAUICL Net Written Premium CTS"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_net_premium_tot {
    label: "AAUICL Net Written Premium TOT"
    type: sum
    sql:  ${TABLE}.net_premium_aauicl_bds + ${TABLE}.net_premium_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_bds {
    label: "Commission BDS"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl_bds ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_cts {
    label: "Commission CTS"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl_cts ;;
    value_format_name: decimal_0
  }

  measure: aauicl_commission_tot {
    label: "Commission TOT"
    type: sum
    sql:  ${TABLE}.broker_commission_aauicl ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_buildings {
    label: "AAUICL RPM Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_buildings {
    label: "AAUICL RPM INF Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_buildings {
    label: "AAUICL RPM WLC Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_buildings {
    label: "AAUICL RPM WLU Buildings"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_contents {
    label: "AAUICL RPM Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_contents {
    label: "AAUICL RPM INF Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_contents {
    label: "AAUICL RPM WLC Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_contents {
    label: "AAUICL RPM WLU Contents"
    type: sum
    sql:  ${TABLE}.contents_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_total {
    label: "AAUICL RPM Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm + ${TABLE}.contents_aauicl_rpm ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_inf_total {
    label: "AAUICL RPM INF Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_inf + ${TABLE}.contents_aauicl_rpm_inf ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlc_total {
    label: "AAUICL RPM WLC Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlc + ${TABLE}.contents_aauicl_rpm_wlc ;;
    value_format_name: decimal_0
  }

  measure: aauicl_rpm_wlu_total {
    label: "AAUICL RPM WLU Total"
    type: sum
    sql:  ${TABLE}.buildings_aauicl_rpm_wlu + ${TABLE}.contents_aauicl_rpm_wlu ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_buildings {
    label: "AAUICL Average RPM BDS"
    type: number
    sql:  ${aauicl_rpm_buildings}/nullif(${aauicl_covers_bds},0) ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_contents {
    label: "AAUICL Average RPM CTS"
    type: number
    sql:  ${aauicl_rpm_contents}/nullif(${aauicl_covers_cts},0) ;;
    value_format_name: decimal_0
  }

  measure: average_rpm_total {
    label: "AAUICL Average RPM TOT"
    type: number
    sql:  ${aauicl_rpm_total}/nullif(${aauicl_covers_tot},0) ;;
    value_format_name: decimal_0
  }



  measure: net_loss_ratio {
    label: "AAUICL Net Modelled Loss Ratio"
    type: number
    sql:  1.0*${aauicl_rpm_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio {
    label: "AAUICL Gross Modelled Loss Ratio"
    type: number
    sql:  1.0*${aauicl_rpm_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_inf {
    label: "AAUICL Net Modelled Loss Ratio INF"
    type: number
    sql:  1.0*${aauicl_rpm_inf_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_inf {
    label: "AAUICL Gross Modelled Loss Ratio INF"
    type: number
    sql:  1.0*${aauicl_rpm_inf_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_wlc {
    label: "AAUICL Net Modelled Loss Ratio WLC"
    type: number
    sql:  1.0*${aauicl_rpm_wlc_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_wlc {
    label: "AAUICL Gross Modelled Loss Ratio WLC"
    type: number
    sql:  1.0*${aauicl_rpm_wlc_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  measure: net_loss_ratio_wlu {
    label: "AAUICL Net Modelled Loss Ratio WLU"
    type: number
    sql:  1.0*${aauicl_rpm_wlu_total}/nullif(${aauicl_net_premium_tot},0) ;;
    value_format_name: percent_1

  }

  measure: gross_loss_ratio_wlu {
    label: "AAUICL Gross Modelled Loss Ratio WLU"
    type: number
    sql:  1.0*${aauicl_rpm_wlu_total}/nullif((${aauicl_net_premium_tot}+${aauicl_commission_tot}),0) ;;
    value_format_name: percent_1
  }

  #### Plan Loss Ratio

  measure: record_ind {
    label: "record ind"
    type: sum
    sql: 1 ;;
    value_format_name: decimal_0
    hidden: yes
  }

  measure: plan_risk_score {
    label: "Plan Loss Ratio"
    type: sum
    sql: case when lk_h_policy_history.transaction_dttm  < (TIMESTAMP '2017-10-01') THEN 0.635 else
        case when lk_h_policy_history.transaction_dttm  < (TIMESTAMP '2018-10-01') THEN 0.615 else 0.623 end end ;;
    value_format_name: percent_1
    hidden: yes
  }

  measure: plan_loss_ratio {
    label: "Plan Loss Ratio"
    type: number
    sql:  ${plan_risk_score}/nullif(${record_ind},0);;
    value_format_name: percent_1
  }

  #### Ren vs. Non-Ren Covers

  measure: aauicl_bds_ren {
    label: "AAUICL Covers BDS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_bds_non_ren {
    label: "AAUICL Covers BDS (non-Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_IND_BDS - ${TABLE}.AAUICL_REN_BDS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_cts_ren {
    label: "AAUICL Covers CTS (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_CTS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_cts_non_ren {
    label: "AAUICL Covers CTS (non-Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_IND_CTS - ${TABLE}.AAUICL_REN_CTS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_tot_ren {
    label: "AAUICL Covers TOT (Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_REN_BDS + ${TABLE}.AAUICL_REN_CTS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_tot_non_ren {
    label: "AAUICL Covers TOT (non-Ren)"
    type: sum
    sql:  ${TABLE}.AAUICL_IND_BDS - ${TABLE}.AAUICL_REN_BDS + ${TABLE}.AAUICL_IND_CTS - ${TABLE}.AAUICL_REN_CTS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_holding_bds {
    label: "AAUICL Hold BDS"
    type: sum
    sql:  ${TABLE}.AAUICL_HOLD_BDS ;;
    value_format_name: decimal_0
  }

  measure: aauicl_holding_cts {
    label: "AAUICL Hold CTS"
    type: sum
    sql:  ${TABLE}.AAUICL_HOLD_CTS ;;
    value_format_name: decimal_0
  }



  measure: xq_win_rate_bds {
    label: "XQ Win Rate - BDS"
    type: number
    sql:  ${aauicl_bds_non_ren}/nullif(1.0*((${broker_covers_bds}-${aauicl_holding_bds})),0) ;;
    value_format_name: percent_1
  }

  measure: xq_win_rate_cts {
    label: "XQ Win Rate - CTS"
    type: number
    sql:  ${aauicl_cts_non_ren}/nullif(1.0*((${broker_covers_cts}-${aauicl_holding_cts})),0) ;;
    value_format_name: percent_1
  }

  measure: xq_win_rate_tot {
    label: "XQ Win Rate - TOT"
    type: number
    sql:  ${aauicl_tot_non_ren}/nullif(1.0*((${broker_covers_tot}-${aauicl_holding_bds}-${aauicl_holding_cts})),0) ;;
    value_format_name: percent_1
  }



  measure: renewal_win_rate_bds {
    label: "Renewal Win Rate - BDS"
    type: number
    sql:  ${aauicl_bds_ren}/nullif(1.0*${aauicl_holding_bds},0) ;;
    value_format_name: percent_1
  }

  measure: renewal_win_rate_cts {
    label: "Renewal Win Rate - CTS"
    type: number
    sql:  ${aauicl_cts_ren}/nullif(1.0*${aauicl_holding_cts},0) ;;
    value_format_name: percent_1
  }

  measure: renewal_win_rate_tot {
    label: "Renewal Win Rate - TOT"
    type: number
    sql:  ${aauicl_tot_ren}/nullif(1.0*(${aauicl_holding_bds}+${aauicl_holding_cts}),0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_bds_ren {
    label: "Cover Share BDS (Ren)"
    type: number
    sql:  1.0*${aauicl_bds_ren}/nullif(${broker_covers_bds},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_cts_ren {
    label: "Cover Share CTS (Ren) "
    type: number
    sql:  1.0*${aauicl_cts_ren}/nullif(${broker_covers_cts},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_tot_ren {
    label: "Cover Share TOT (Ren)"
    type: number
    sql:  1.0*${aauicl_tot_ren}/nullif(${broker_covers_tot},0) ;;
    value_format_name: percent_1
  }


  measure: cover_share_bds_non_ren {
    label: "Cover Share BDS (non-Ren)"
    type: number
    sql:  1.0*${aauicl_bds_non_ren}/nullif(${broker_covers_bds},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_cts_non_ren {
    label: "Cover Share CTS (non-Ren) "
    type: number
    sql:  1.0*${aauicl_cts_non_ren}/nullif(${broker_covers_cts},0) ;;
    value_format_name: percent_1
  }

  measure: cover_share_tot_non_ren {
    label: "Cover Share TOT (non-Ren)"
    type: number
    sql:  1.0*${aauicl_tot_non_ren}/nullif(${broker_covers_tot},0) ;;
    value_format_name: percent_1
  }


}
