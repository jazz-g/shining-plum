install: dependencies

# Feel free to comment out whatever you don't want
software = "rofi i3-lock termite kvantum-qt lxappearance"
background = "awesome i3-lock picom-rounded-corners redshift pamixer acpilight acpi qt5ct"
libraries = "python-rssparser python-google-api-python-client python-google-auth-httplib2 python-google-auth-oauthlib python-inflect python-owm"


dependencies:
	yay -Syu $(software background libraries)
