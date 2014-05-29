From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 29 May 2014 11:18:00 +0000
Subject: Re: [lm-sensors] info about  driver for chip EMC1402
Message-Id: <20140529131800.141e5756@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
In-Reply-To: <1401139433.59243.YahooMailNeo@web172006.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 27 May 2014 22:13:17 +0100 (BST), Kenny Lake wrote:
> Jean
> I know that I have a EMC1402 chip because this is what the "sensors-detec=
t" command report:
> Driver `to-be-written':
> =A0 * Bus `SMBus PIIX4 adapter at 0b00'
> =A0=A0=A0 Busdriver `i2c_piix4', I2C address 0x4c
> =A0=A0=A0 Chip `SMSC EMC1402' (confidence: 6)

OK, fair enough, the latest version of the emc1403 driver may indeed
work then. That being said:
 * It might not tell you more than the thermal ACPI driver is already
   telling you.
 * If the ACPI temperature comes from the same chip, you may get
   conflicting accesses to the chip by using two drivers for the same
   device.
 * As Guenter said already, if thermal management is broken on your
   laptop, this won't help you anyway. You need to report such problems
   to linux-pm and/or linux-acpi.

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
