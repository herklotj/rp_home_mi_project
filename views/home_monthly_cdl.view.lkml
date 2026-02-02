view: home_monthly_cdl {

  derived_table: {
    sql:
    select inforce_date,value
    from aapricing.home_monthly_cdl ;;}



    dimension_group: inforce_date {
      label: "Inforce Date"
      type: time
      timeframes: [
        month,
        quarter,
        year
      ]
      sql: CAST(${TABLE}.inforce_date AS TIMESTAMP WITHOUT TIME ZONE);;
    }


    measure: inforce_policies {
      label: "Inforce Policies"
      type: sum
      sql: ${TABLE}.value ;;
    }


  }
