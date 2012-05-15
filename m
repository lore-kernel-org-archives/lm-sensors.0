From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Tue, 15 May 2012 16:59:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (it87) Create voltage attributes only if voltage is enabled
Message-Id: <CC857E2F-E2EB-4CE3-8E8B-F6D94737EA61@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1336530714-26615-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

Am 15.05.2012 um 08:22 schrieb Jean Delvare:
> On Mon, 14 May 2012 23:21:37 +0200, Bj=F6rn Gerhart wrote:
>> In our design, the IT8783F's Pin 91 is defined as VIN7, and likewise bit=
2 of index 0x2C is 1.
>=20
> What about bit 1 of register 0x2C and bit 2 of register 0x27?
>=20
bit 1 / register 0x2C: 0 (meaning: internal voltage divider is disabled)
bit 2 / register 0x27: 0 (meaning: pin91 is vin7)

To make the configuration complete:
- index register 0x27 has 0x10 as value
- index register 0x2C has 0x95 as value
- UART6 moves to pins 100~106 by JP4 (pin1) set to 0


>> As I'm not yet used to git: which would be the easiest way to get the it=
87 with all patches integrated for kernel 2.6.32 for testing purposes? On y=
our github site, I didn't find the appropriate entry for the patches you se=
nt...
>=20
> Standalone driver is at:
> http://khali.linux-fr.org/devel/misc/it87/
>=20
Ah nice, thanks for the URL. It was no problem to compile against the CentO=
S 6.2 kernel 2.6.32.

Good news, vin7 (connected to 1.1V nominal voltage) is displayed correctly.

However, with this version of it87, the voltage -12V (vin6) disappears on m=
y IT8873F. Loading the older it87 version from 2012/3/8, vin6 appears again=
 - while /etc/sensors3.conf remains the same.

As mentioned, UART6 is enabled, and at the same time shifted UART6 to pins =
100~106. Therefore, pin 92 and 93 get usable. Because this setting is not d=
etectable (as discussed before with Guenter), the dependancy to UART6 maybe=
 has to be removed here also.
A separate tiny patch is on its way. A test with my IT8783F configuration w=
orked fine, and vin6 was displayed again.

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
