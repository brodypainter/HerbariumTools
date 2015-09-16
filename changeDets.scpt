on run args
	repeat with catNum in args
		tell application "Google Chrome"
			set newSciName to "Psorothamnus spinosus"
			set myurl to "http://db.herbarium.arizona.edu/collections/editor/occurrenceeditor.php?q_recordedby=&q_recordnumber=&q_eventdate=&q_catalognumber=" & catNum & "&q_othercatalognumbers=&q_observeruid=&q_recordenteredby=&q_dateentered=&q_datelastmodified=&q_processingstatus=&q_customfield1=&q_customtype1=EQUALS&q_customvalue1=&q_customfield2=&q_customtype2=EQUALS&q_customvalue2=&q_customfield3=&q_customtype3=EQUALS&q_customvalue3=&collid=2&csmode=0&occid=&occindex=0&orderby=catalognumber&orderbydir=ASC"

			open location myurl
		    delay 1
		    tell active tab of window 1
				execute javascript "$('#ui-id-2').click();"
				delay 1
				execute javascript "$('a[title=\"Add New Determination\"]').click();"
				delay 1

				execute javascript "$('#dafsciname').focus();"
				tell application "System Events" to tell process "Google Chrome"
					keystroke newSciName
				end tell

				delay 1

				execute javascript "$('[name=\"identifiedby\"').focus();"
				tell application "System Events" to tell process "Google Chrome"
					keystroke "ARIZ, nomenclatural change"
				end tell

				delay 1

				execute javascript "$('[name=\"dateidentified\"').focus();"
				tell application "System Events" to tell process "Google Chrome"
					keystroke "2015-09-15"
				end tell

				delay 1

				--execute javascript "$('[name=\"makecurrent\"').click();"

				delay 1

				--execute javascript "$('[value=\"Add New Determination\"]').click();"

				delay 1

			end tell
			delete tab (active tab index of window 1) of window 1
		end tell
	end repeat
end run