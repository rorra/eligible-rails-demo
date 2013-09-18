$(document).ready ->
  $("#eligible_coverage_payer_id").select2
    allowClear: true
    blurOnChange: true
    placeholder: "Select a Payer"
    minimumInputLength: 3
    ajax:
      url: "/payers.json"
      dataType: "json"
      data: (term) ->
        q: term

      results: (data) ->
        results: data
    multile: false
    initSelection: (element, callback) ->
      callback(payer_id: $(element).val())
    formatResult: (payer) ->
      payer_names = null
      i = 0
      while i < payer.payer_names.length
        if payer_names
          payer_names += " | " + payer.payer_names[i].name
        else
          payer_names = payer.payer_names[i].name
        i++
      '<p style="margin-bottom: 4px;border-bottom: solid 1px;">' + payer.payer_id + ": " + payer_names + "</p>"

    formatSelection: (object) ->
      object.payer_id

    id: (object) ->
      object.payer_id

  $("#eligible_coverage_service_type").select2
    allowClear: true
    blurOnChange: true
    placeholder: "Select a Service Type"
    minimumInputLength: 1
    ajax:
      url: "/service_types.json"
      dataType: "json"
      data: (term) ->
        q: term

      results: (data) ->
        results: data
    multile: false
    initSelection: (element, callback) ->
      callback(service_type_id: $(element).val())
    formatResult: (service_type) ->
      '<p style="margin-bottom: 4px;border-bottom: solid 1px;">' + service_type.service_type_id + ": " + service_type.description + "</p>"

    formatSelection: (object) ->
      object.service_type_id

    id: (object) ->
      object.service_type_id