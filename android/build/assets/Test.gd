extends Node



func _on_button_button_down():
#	$Connect.request("https://nsnoztviefjxvptztmnj.supabase.cohttps://nsnoztviefjxvptztmnj.supabase.co?apikey=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5zbm96dHZpZWZqeHZwdHp0bW5qIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTQyNDI5MzEsImV4cCI6MjAwOTgxODkzMX0.BrKqhb0uKWY_bKqulXEmNT7O_jsSWu72ghayRI-A-7U")
	$Connect.request("https://official-joke-api.appspot.com/random_joke")

func _on_connect_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())
