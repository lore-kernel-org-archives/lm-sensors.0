From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 17 Nov 2012 04:16:27 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <20121117041627.GA25291@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Nov 16, 2012 at 09:48:59PM -0600, Leslie Rhorer wrote:
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Sent: Friday, November 16, 2012 12:37 AM
> > To: Leslie Rhorer
> > Cc: lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] Getting alarms using lm-sensors
> >=20
> > On Fri, Nov 16, 2012 at 12:16:48AM -0600, Leslie Rhorer wrote:
> > > Hello, All.
> > >
> > > 	I have been trying to configure lm_sensors to provide alarms for
> > > failing fans, high temperatures, etc.  I get a reasonable output from
> > the
> > > sensors command, but when I deliverately create an alarm condition, it
> > does
> > > not report as an alarm.  For example, I just pulled the fan on the
> > OPT_FAN3
> > > sensor, and the speed dropped from 1800 RPM to 0, but `sensors` does =
not
> > > report any alarm:
> > >
> > > RAID-Server:/usr/share/sensors# sensors
> > > acpitz-virtual-0
> > > Adapter: Virtual device
> > > temp1:       +40.0=B0C  (crit =3D +75.0=B0C)
> > >
> > > atk0110-acpi-0
> > > Adapter: ACPI interface
> > > Vcore Voltage:      +1.42 V  (min =3D  +0.85 V, max =3D  +1.60 V)
> > > +12V Voltage:      +12.03 V  (min =3D +10.20 V, max =3D +13.80 V)
> > > +5V Voltage:        +4.92 V  (min =3D  +4.50 V, max =3D  +5.50 V)
> > > +3.3V Voltage:      +3.30 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> > > DDR2:               +2.00 V  (min =3D  +1.71 V, max =3D  +2.09 V)
> > > HT:                 +1.28 V  (min =3D  +1.08 V, max =3D  +1.32 V)
> > > SB:                 +1.30 V  (min =3D  +0.99 V, max =3D  +1.21 V)
> > > BR:                 +1.23 V  (min =3D  +1.08 V, max =3D  +1.32 V)
> > > VDDA:               +2.61 V  (min =3D  +2.25 V, max =3D  +2.75 V)
> > > DDR2 TERM.:         +0.98 V  (min =3D  +0.85 V, max =3D  +1.04 V)
> > > VDDNB:              +1.20 V  (min =3D  +1.17 V, max =3D  +1.43 V)
> > > CPU_FAN FAN Speed: 2227 RPM  (min =3D  800 RPM)
> > > CHA_FAN1 FAN Speed:2766 RPM  (min =3D  800 RPM)
> > > CHA_FAN2 FAN Speed:2766 RPM  (min =3D  800 RPM)
> > > OPT_FAN1 FAN Speed:   0 RPM  (min =3D  800 RPM)
> > > OPT_FAN2 FAN Speed:   0 RPM  (min =3D  800 RPM)
> > > OPT_FAN3 FAN Speed:   0 RPM  (min =3D  800 RPM)
> > > PWR_FAN FAN Speed: 1180 RPM  (min =3D  800 RPM)
> > > CHA_FAN3 FAN Speed:   0 RPM  (min =3D  800 RPM)
> > > CPU Temperature:    +41.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0=
C)
> > > MB Temperature:     +45.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0=
C)
> > > OPT1:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0=
C)
> > > OPT2:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0=
C)
> > > OPT3:                +0.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0=
C)
> > >
> > > k10temp-pci-00c3
> > > Adapter: PCI adapter
> > > temp1:       +32.5=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C)
> >=20
> > All those drivers don't support alarms.
> >=20
> > Guenter
>=20
> Oi.  Thanks, anyway.
>=20
> Well, OK, then.  I've started working on a cron script that will send
> e-mails when a parameter falls out of bounds or shut down the shelf if it=
 is
> critical, so on a related note, what sensors, exactly, are acpitz-virtual=
-0
> and k10temp-pci-00c3?  It's very nice they are in bounds, but if they sho=
uld
> drift out of bounds, what should I believe is getting too hot?
>=20
k10temp is the AMD CPU temperature as reported by the CPU itself. It isn't
really accurate. acpitz-virtual is, as the name says, a virtual device.
acpitx is short for "ACPI thermal zone". It may also reflect the CPU
temperature, but I don't know for sure.

Guenter
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
