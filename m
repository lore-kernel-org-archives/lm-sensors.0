From: krunal patel <krunal_smiles@yahoo.com>
Date: Wed, 22 Jun 2011 08:23:54 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <97803.45814.qm@web95803.mail.in.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean,

Thank you very much for your support and explanation. Please find my commen=
ts in line.

Best Regards,
Krunal Patel


--- On Tue, 21/6/11, Jean Delvare <khali@linux-fr.org> wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] sensor details for W83627HG-AW
> To: "krunal patel" <krunal_smiles@yahoo.com>
> Cc: lm-sensors@lm-sensors.org, "Guenter Roeck" <guenter.roeck@ericsson.co=
m>
> Date: Tuesday, 21 June, 2011, 5:20 PM
> On Tue, 21 Jun 2011 12:40:49 +0530
> (IST), krunal patel wrote:
> > Hi Jean,
> > Its working now. Thank you very much for your patch.
> > dmesg output--------------------
> > w83627hf: Found W83627HF chip at 0x290
> > Using 6-bit VID table for VIA C7-D CPU
> >=20
> > # sensors=A0--------------
> > w83627hf-isa-0290
> > Adapter: ISA adapter
> > in0: =A0 =A0 =A0 =A0 =A0+0.69 V =A0(min =3D =A0+0.00 V, max > =A0+4.08 =
V)
> > in1: =A0 =A0 =A0 =A0 =A0+1.06 V =A0(min =3D =A0+0.00 V, max > =A0+4.08 =
V)
> > in2: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+2.82 V, max > =A0+3.79 =
V)
> > in3: =A0 =A0 =A0 =A0 =A0+2.99 V =A0(min =3D =A0+3.57 V, max > =A0+1.98 =
V) =A0ALARM
> > in4: =A0 =A0 =A0 =A0 =A0+3.28 V =A0(min =3D =A0+1.98 V, max > =A0+4.05 =
V)
> > in5: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+3.57 V, max > =A0+3.30 =
V) =A0ALARM
> > in6: =A0 =A0 =A0 =A0 =A0+3.33 V =A0(min =3D =A0+1.78 V, max > =A0+0.53 =
V) =A0ALARM
> > in7: =A0 =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+0.77 V, max > =A0+2.29 =
V) =A0ALARM
> > in8: =A0 =A0 =A0 =A0 =A0+3.52 V =A0(min =3D =A0+3.06 V, max > =A0+0.64 =
V) =A0ALARM
> > fan1: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 13775 RPM, div > 2) =A0ALARM
> > fan2: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D =A0 -1 RPM, div > 2) =A0ALA=
RM
> > fan3: =A0 =A0 =A0 =A0 =A0 0 RPM =A0(min =3D 3515 RPM, div =3D 2)
> =A0ALARM
> > temp1: =A0 =A0 =A0 =A0+52.0 C =A0(high =3D =A0+9.0 C, hyst > +32.0 C) =
=A0ALARM =A0sensor =3D thermistor
> > temp2: =A0 =A0 =A0 =A0+38.5 C =A0(high =3D +120.0 C, hyst > +115.0 C) =
=A0sensor =3D diode
> > temp3: =A0 =A0 =A0 =A0-48.0 C =A0(high =3D +120.0 C, hyst > +115.0 C) =
=A0sensor =3D thermistor
> > cpu0_vid: =A0 =A0+1.212 V
> > beep_enable: enabled
>=20
> According to the documentation I have, your CPU should be
> running at
> 0.684 V (assuming it is a ULV variant), so in0 is Vcore. It
> does not
> match cpu0_vid, but the other possible VID decoding table
> wouldn't
> either. So I think that the VID pins are simply not
> properly routed to
> your monitoring chip.
>=20
> Ah, stupid me. Of course they aren't. The W83627HF only has
> 5 VID pins,
> so you can't route a 6-bit VID value to it...
>=20
> So basically this means that you can ignore the cpu0_vid
> value reported
> by the w83627hf driver, it's bogus. Ideally the drivers
> would notice
> the mismatch and wouldn't expose a VID value which can't be
> correct. I
> don't have the time to fix it now so I've created a support
> ticket for
> later:
> =A0 http://www.lm-sensors.org/ticket/2383
>=20
> Could you please install the msr-tools package, load the
> msr driver,
> and run as root:
> # rdmsr -x 0x198
> and report the result.
>=20
Following is output you asked for
# rdmsr -x 0x198       =20
400050004000500

> BTW you should also be able to use the via-cputemp driver.
> Didn't
> sensors-detect suggest that?
>=20
I didn't used sensors-detect because it was wasting my time in resolving pe=
rl issues in my system. So I opened case, located chip and loaded related m=
odule.
> > I looked into driver code and hwmon related code. All
> sensor data is exported to user space using sysfs.
> > One thing I understood is there is no interrupt
> mechanism in sensor chip so we need to read data from chip's
> memory. So for=A0periodic data we need to do polling at
> userspace (like sensord).
>=20
> Yes, this is correct, except that _some_ devices actually
> support
> interrupts. But libsensors currently doesn't support that,
> and most
> drivers don't implement it anyway.
>=20
> > Can I implement timer in driver and do polling in
> Kernel?
>=20
> Technically you certainly can, but I very much doubt that
> such code
> would be accepted in the kernel. If polling is necessary,
> then it is
> better done in user-space than in the kernel, because
> user-space can
> choose the polling set and period depending on the exact
> needs.
>=20
> If you think that in-kernel polling has an advantage,
> please argue.
>=20
I thought kernel timer is lighter then application in userspace.=20
> > What I want to do is get userspace event only when
> Alarm is raised. If I implement timer and netlink
> communication in driver will it be correct way to do it? As
> I do not find any other way.
>=20
> I am no expert in this area, but I see no reason to go with
> netlink, it
> seems to me that poll/select on the relevant alarm files
> themselves
> should work. Guenter, I think you discussed this some times
> ago?
>=20
> Krunal, please also search for "poll notification" in
> Documentation/hwmon/sysfs-interface. This suggests that a
> subset of the
> attributes implement poll support already. I didn't look
> into this and
> won't have time to do so, sorry.
>=20
I am not find related info in linux-2.6.27.45, I will look in latest versio=
n.
> But again this only applies to devices which raise
> interrupts on alarm,
> so that no in-kernel polling is needed.
>=20
> --=20
> Jean Delvare
>=20



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
