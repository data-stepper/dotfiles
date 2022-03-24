########## HOW TO SET UP eduroam WITH IWD ON ARCH LINUX ##########

So this took me quite some time, so I am writing this simple README
so nobody ever has to go through this stuff again ;)

1. Download the rootcert.crt certificate from the university website
2. Convert the rootcert.crt to rootcert.pem format (I don't know if this
	is really necessary, but for me it works) using this command:
	openssl x509 -inform der -in rootcert.crt -out rootcert.pem
3. Then copy the converted rootercert.pem to /var/lib/iwd
4. In the other configuration file in this folder (eduroam.8021x)
	fill in your university identification code and password
5. Copy the file (WITHOUTH CHANGING THE NAME) to /var/lib/iwd
6. Start iwctl and connect happily ;)

Good fun and carpe diem
