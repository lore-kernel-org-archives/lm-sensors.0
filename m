From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 29 Jan 2007 14:04:44 +0000
Subject: [lm-sensors] sensors-detect hangs while scaning PIIX4
Message-Id: <20070129150444.dc9703c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
In-Reply-To: <60685.85.231.160.112.1169927353.squirrel@webmail1.b-one.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Peter,

On Mon, 29 Jan 2007 11:28:52 +0100 (CET), Peter Welzien wrote:
> Since my last message doesn't seem to have reached the list, I send
> another one.

Yeah, that's what happens when you reply to me only ;)

> > Yes, please lookup the exact model.
>=20
> It's a Gigabyte GA-6ETXDR.
>=20
> > Strange, this really doesn't look like a regular ITE chip ID. Probably
> > a misdetection. Can you visually search for the Super-I/O chip on your
> > motherboard?
>=20
> Gigabyte says on their homepage
> (http://www.gigabyte.com.tw/Products/Networking/Products_Spec.aspx?Produc=
tID=992)
> that the Super I/O chip is a NS97317. On the chip itself is printed
> PC97317 and some other text. Let me know if you also need the rest of the
> text.

This chip doesn't embed hardware monitoring features. This was already
discussed on the list:
  http://lists.lm-sensors.org/pipermail/lm-sensors/2003-March/002059.html
I checked the datasheet once again and indeed there is no mention of
any kind of voltage, temperature or fan speed monitoring.

> > First of all, do you have a reason to think that this motherboard has
> > hardware monitoring features? Do you see them in the BIOS or using a
> > different OS? It seems to be a rather old model, it wouldn't be all
> > that surprising that it simply doesn't support hardware monitoring.
>=20
> I can get the temperature of both CPUs as well as fan speeds in the BIOS.

OK, so the board must have a hardware monitoring chip. Maybe on the
SMBus which you can't get to work at the moment.

> > Try using i2cdetect to scan the SMBus. If even that locks the bus, it's
> > probably the SMBus itself which doesn't work. Did you pass specific
> > parameters to the i2c-piix4 driver? Are there messages in the logs when
> > the i2c-piix4 driver is loaded?
>=20
> I didn't pass any parameters to the module. When it loads the only message
> in the log is a line saying that the module is loaded and an address. I
> don't have access to the computer right now, but I can get the exact
> message tonight if you need it.

It might help, yes. Please make sure there is no complaint about an
"illegal interrupt configuration". Please also provide a dump of the
PCI config registers of the device. You can obtain such a dump using
"lspci -xxx".

Then we need to figure out what exactly is locking your system. As I
asked before, please try i2cdetect on the SMBus (typically "i2cdetect
0") and see if it locks too. You may additionally try "i2cdetect -r 0"
and "i2cdetect -q 0". If these commands lock your system, note how much
is written on your screen each time before the system locks.

--=20
Jean Delvare

