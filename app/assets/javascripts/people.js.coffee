months = ["Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"]

serializeForm = ($form) ->
	paramObj = {}
	$.each $form.serializeArray(), (_, kv) ->
		if paramObj.hasOwnProperty(kv.name)
			paramObj[kv.name] = $.makeArray(paramObj[kv.name])
			paramObj[kv.name].push(kv.value)
		else
			paramObj[kv.name] = kv.value;
	paramObj

int2date = (val) ->
	year = 2003 + Math.floor(val / 12)
	month = (val % 12)
	return new Date(year, month)

changeFunc = () ->
	search = serializeForm($('form#contact_search'))

	$('.gallery .person').removeClass('iso').each () ->
		$el = $(this)
		contact = $el.data('contact')
		detail = $el.data('detail')
		visible = true
		if search['branches[]']
			visible = false unless contact.Branch_of_Service__c == search['branches[]'] || $.inArray(contact.Branch_of_Service__c, search['branches[]']) != -1
		if search['name']
			visible = false unless (new RegExp('.*'+search['name']+'.*', 'i')).test(contact.Name)
		if search['served_oif']
			oif_dates = $('[name="oif-dates"]').slider('getValue')
			starter = int2date(oif_dates[0])
			ender = int2date(oif_dates[1])
			visible = false unless detail.OEF_OIF__c == 'OIF' && (new Date(detail.Start_Date__c)) > starter && (new Date(detail.End_Date__c)) < ender
		else if search['served_oef']
			oef_dates = $('[name="oef-dates"]').slider('getValue')
			starter = int2date(oef_dates[0])
			ender = int2date(oef_dates[1])
			visible = false unless detail.OEF_OIF__c == 'OEF' && (new Date(detail.Start_Date__c)) > starter && (new Date(detail.End_Date__c)) < ender
		$el.addClass('iso') if visible
	$('.gallery').isotope({filter: '.iso'})
	count = $('.gallery .iso').length
	str = 'members'
	if count == 0
		str = 'no members'
	else if count == 1
		str = '1 member'
	else
		str = count + ' members'
	$('#found-count').html(str)

$ ->
	$('.date-slider').on('slide', changeFunc).slider
		min: 0
		max: 12*11 # each month for 10 year range
		value: [24, 12 * 9]
		formater: (val) ->
			year = 2003 + Math.floor(val / 12)
			month = (val % 12)
			"#{months[month]} #{year}"

	$('.gallery').isotope({
		itemSelector: '.person',
		filter: '.iso'
	})
	changeFunc()
	$('#contact_search input').change(changeFunc)
