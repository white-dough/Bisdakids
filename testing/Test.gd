extends Node

var oldTimestamp = {
"year": 2023,
"month": 9,
"day": 30
}

var newTimestamp = {
"year": 2023,
"month": 9,
"day": 21
}

func isDayAheadOrMore(oldTimestamp, newTimestamp):
	var oldUnixTimestamp = dateToUnixTimestamp(oldTimestamp)
	var newUnixTimestamp = dateToUnixTimestamp(newTimestamp)
	var timeDifference = newUnixTimestamp - oldUnixTimestamp
	return timeDifference >= 86400  # 86400 seconds = 1 day

func dateToUnixTimestamp(timestamp):
	var dateTime : Dictionary = {}
	dateTime.year = timestamp["year"]
	dateTime.month = timestamp["month"]
	dateTime.day = timestamp["day"]
	dateTime.hour = 0
	dateTime.minute = 0
	dateTime.second = 0
	return Time.get_unix_time_from_datetime_dict(dateTime)
	
func _ready():
	pass
#	var result = isDayAheadOrMore(oldTimestamp, newTimestamp)
#	if result:
#		print("The new timestamp is a day ahead or more.")
#	else:
#		print("The new timestamp is less than a day ahead.")
#	var curr = Time.get_datetime_dict_from_system()
#	curr['hour'] = 0
#	curr['minute'] = 0
#	curr['second'] = 0
#	var car = Time.get_datetime_dict_from_system()
#	car['day'] = 2
#	car['hour'] = 0
#	car['minute'] = 0
#	car['second'] = 0
#	print(Time.get_unix_time_from_datetime_dict(car) - Time.get_unix_time_from_datetime_dict(curr))
#	print(car)
#	print(curr)
#	print(Time.get_unix_time_from_datetime_dict(curr) - Time.get_unix_time_from_datetime_dict(car))
##	print(dateToUnixTimestamp(oldTimestamp))

#	var input_string = "level24"
#	print("hey")
#	print(int(input_string))
