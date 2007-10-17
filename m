From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Wed, 17 Oct 2007 18:56:49 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <1702990916@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean, Juerg,


> -----Urspr=FCngliche Nachricht-----
> Von: "Juerg Haefliger" <juergh@gmail.com>
> Gesendet: 09.10.07 18:08:33
> An: "Jean Delvare" <khali@linux-fr.org>
> CC: lm-sensors@lm-sensors.org
> Betreff: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!


> > >
> > > not much information:
> > > /var/log/messages.0:Oct  4 00:17:43 lisa kernel: dme1737 0-002e: Writ=
e to register 0x30 failed (-1)! Please report to the driver maintainer.
> >
> > As I expected...
> >
> > > i2c_nforce2             7232  0
>=20
> Yes, I looked at the driver and it indeed only returns -1 on error.
>=20
> > Juerg, you could patch i2c-nforce2 to return more useful error codes.
> > Such a patch could go upstream. Alternatively, building the i2c-nforce2
> > driver with CONFIG_I2C_DEBUG_BUS=3Dy may provide some hints.
>=20
> I was thinking of doing that. First I have to try to recreate the
> problem on my machine.
>=20
> Juergen: Do you feel like recompiling i2c_nforce2 with debugging enabled?
>=20

Here is what I found in /var/log:

/var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: nForce2 S=
MBus adapter at 0x4c00
/var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: nForce2 S=
MBus adapter at 0x4c40
/var/log/messages:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: Found a D=
ME1737 chip at 0x2e (rev 0x8a)

/var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeou=
t! (0x10)
/var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-0: SMBus Timeou=
t! (0x10)
/var/log/debug:Oct 17 09:16:00 lisa kernel: i2c_adapter i2c-1: SMBus Timeou=
t! (0x10)
/var/log/debug:Oct 17 19:35:30 lisa kernel: i2c_adapter i2c-0: SMBus Timeou=
t! (0x1a)

/var/log/messages:Oct 17 09:16:00 lisa kernel: dme1737 0-002e: Optional fea=
tures: pwm3=3Dyes, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3Dyes, fan5=3Dno, =
fan6=3Dno.
/var/log/messages:Oct 17 19:35:30 lisa kernel: dme1737 0-002e: Write to reg=
ister 0x30 failed (-1)! Please report to the driver maintainer.

Juergen
_______________________________________________________________________
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 3 Monate
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/?mc=022220


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
