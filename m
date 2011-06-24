From: krunal patel <krunal_smiles@yahoo.com>
Date: Fri, 24 Jun 2011 11:31:13 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <1308914353.36685.YahooMailClassic@web95806.mail.in.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

after insmod hwmon-vid.ko and via-cputemp.ko output of sensors binary is

w83627hf-isa-0290
Adapter: ISA adapter
in0:          +0.70 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:          +1.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:          +3.30 V  (min =3D  +2.82 V, max =3D  +3.79 V)
in3:          +2.99 V  (min =3D  +3.57 V, max =3D  +2.02 V)  ALARM
in4:          +3.28 V  (min =3D  +1.98 V, max =3D  +4.05 V)
in5:          +3.31 V  (min =3D  +3.57 V, max =3D  +2.11 V)  ALARM
in6:          +3.33 V  (min =3D  +1.78 V, max =3D  +2.58 V)  ALARM
in7:          +3.31 V  (min =3D  +0.26 V, max =3D  +2.26 V)  ALARM
in8:          +3.52 V  (min =3D  +3.06 V, max =3D  +0.64 V)  ALARM
fan1:           0 RPM  (min =3D 3813 RPM, div =3D 2)  ALARM
fan2:           0 RPM  (min =3D   -1 RPM, div =3D 2)  ALARM
fan3:           0 RPM  (min =3D   -1 RPM, div =3D 2)  ALARM
temp1:        +52.0 C  (high =3D  +9.0 C, hyst =3D +32.0 C)  ALARM  sensor =
=3D thermistor
temp2:        +38.5 C  (high =3D +120.0 C, hyst =3D +115.0 C)  sensor =3D d=
iode
temp3:        -48.0 C  (high =3D +120.0 C, hyst =3D +115.0 C)  sensor =3D t=
hermistor
cpu0_vid:    +1.212 V
beep_enable: enabled

via_cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +3892138.1 C =20
cpu0_vid:    +0.684 V

--- On Wed, 22/6/11, Jean Delvare <khali@linux-fr.org> wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] sensor details for W83627HG-AW
> To: "krunal patel" <krunal_smiles@yahoo.com>
> Cc: lm-sensors@lm-sensors.org, "Guenter Roeck" <guenter.roeck@ericsson.co=
m>
> Date: Wednesday, 22 June, 2011, 9:30 PM
> On Wed, 22 Jun 2011 13:41:54 +0530
> (IST), krunal patel wrote:
> > --- On Tue, 21/6/11, Jean Delvare <khali@linux-fr.org>
> wrote:
> >=20
> > > From: Jean Delvare <khali@linux-fr.org>
> > > Subject: Re: [lm-sensors] sensor details for
> W83627HG-AW
> > > To: "krunal patel" <krunal_smiles@yahoo.com>
> > > Cc: lm-sensors@lm-sensors.org,
> "Guenter Roeck" <guenter.roeck@ericsson.com>
> > > Date: Tuesday, 21 June, 2011, 5:20 PM
> > > Could you please install the msr-tools package,
> load the msr driver,
> > > and run as root:
> > > # rdmsr -x 0x198
> > > and report the result.
> > >=20
> > Following is output you asked for
> > # rdmsr -x 0x198=A0 =A0 =A0 =A0=20
> > 400050004000500
>=20
> OK, this is as I thought. The last two bytes are as
> documented in the
> datasheet: 0x05 for 5 * 100 =3D 500 MHz and 0x00 for the
> lowest voltage
> level. We might use the later to get cpu0_vid from the CPU
> itself, as
> the monitoring ship won't be able to provide it.
>=20
> > > BTW you should also be able to use the
> via-cputemp driver.
> > > Didn't sensors-detect suggest that?
> > >=20
> > I didn't used sensors-detect because it was wasting my
> time in resolving perl issues in my system. So I opened
> case, located chip and loaded related module.
>=20
> I see. The via-cputemp driver probably doesn't exist in
> your kernel as
> it was added with version 2.6.33. Can you please fetch the
> standalone
> one at:
> =A0 http://khali.linux-fr.org/devel/misc/via-cputemp/
> It should work. Please also update hwmon-vid from:
> =A0 http://khali.linux-fr.org/devel/misc/hwmon-vid/
> I've updated it for your system. If these two drivers work
> well
> together for you then I'll push the changes upstream.
>=20
> --=20
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>=20


Regards,
Krunal

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
