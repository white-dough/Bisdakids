extends Node

var oldTimestamp = {
"year": 2023,
"month": 9,
"day": 21
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
	var result = isDayAheadOrMore(oldTimestamp, newTimestamp)
	if result:
		print("The new timestamp is a day ahead or more.")
	else:
		print("The new timestamp is less than a day ahead.")
