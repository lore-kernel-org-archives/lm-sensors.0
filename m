From: mailinglist@welzien.se (Peter Welzien)
Date: Mon, 29 Jan 2007 10:28:52 +0000
Subject: [lm-sensors] sensors-detect hangs while scaning PIIX4
Message-Id: <5940.212.73.30.50.1170066532.squirrel@webmail1.b-one.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
In-Reply-To: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Since my last message doesn't seem to have reached the list, I send
another one.

> Yes, please lookup the exact model.

It's a Gigabyte GA-6ETXDR.

> Strange, this really doesn't look like a regular ITE chip ID. Probably
> a misdetection. Can you visually search for the Super-I/O chip on your
> motherboard?

Gigabyte says on their homepage
(http://www.gigabyte.com.tw/Products/Networking/Products_Spec.aspx?ProductI=
D=992)
that the Super I/O chip is a NS97317. On the chip itself is printed
PC97317 and some other text. Let me know if you also need the rest of the
text.

> First of all, do you have a reason to think that this motherboard has
> hardware monitoring features? Do you see them in the BIOS or using a
> different OS? It seems to be a rather old model, it wouldn't be all
> that surprising that it simply doesn't support hardware monitoring.

I can get the temperature of both CPUs as well as fan speeds in the BIOS.

> Try using i2cdetect to scan the SMBus. If even that locks the bus, it's
> probably the SMBus itself which doesn't work. Did you pass specific
> parameters to the i2c-piix4 driver? Are there messages in the logs when
> the i2c-piix4 driver is loaded?

I didn't pass any parameters to the module. When it loads the only message
in the log is a line saying that the module is loaded and an address. I
don't have access to the computer right now, but I can get the exact
message tonight if you need it.

--=20
/Peter Welzien

