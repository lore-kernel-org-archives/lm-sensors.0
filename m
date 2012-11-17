From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 04:45:05 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211170445.qAH4j6PA002454@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > > > SB:                 +1.30 V  (min =3D  +0.99 V, max =3D  +1.21 V)

> > > > MB Temperature:     +45.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=
=B0C)


> k10temp is the AMD CPU temperature as reported by the CPU itself. It isn't
> really accurate. acpitz-virtual is, as the name says, a virtual device.
> acpitx is short for "ACPI thermal zone". It may also reflect the CPU
> temperature, but I don't know for sure.
>=20
> Guenter

	OK, thanks once again.  I guess I will ignore them.  I hope you
don't mind me asking all these questions, but I do have a couple more.  Note
the two reports above.  Where is the sensors routine getting its limit
values?  Both the SouthBridge voltage and the chip array temperature are
reported out of bounds, yet I am not overclocking, at all.  The manual says
the motherboard offers legitimate OC values of 1.10, 1.12, 1.14, 1.16, 2.98,
and 3.00 VDC.  Given that, I shouldn't think 1.3V would be out of bounds.

	That, and 45C is just not really that hot.  The chipset often rises
to well over 60C, and I don't really believe it to be a problem.

	Finally, and this one I admit is really getting close to being
totally off-topic, but the script I am writing reports the out of bounds
values to me via mail.  The degree character gets mangled, though, making
the text look funny.  It's really not a big deal, but it is a bit annoying.
The text above comes out as:

+40.0=C2=B0C (high =3D +60.0=C2=B0C, crit =3D +95.0=C2=B0C)

All I do is store the text of the `sensors` command to a variable and then
pass the variables to mail.  (This is a bash script.)

	SID=3D$( echo $line | cut -d ":" -f1 )		# $SID =3D Sensor ID
	AID=3D$(echo $line | cut -d ":" -f4 )		# $AID =3D Sensor Name
	TID=3D$(echo $line | cut -d ":" -f5 )		# $TID =3D Text Name
for e-mail
	FIELDS=3D$( sensors | grep "$AID:" )		# $FIELDS =3D Text
from `sensors`
	F2=3D$( echo $FIELDS | cut -d ":" -f2 )		# $F2 =3D Description
from `sensors`
	CVAL=3D${F2% (*}					# $CVAL =3D Current
Sensor Value

...

echo "$TID $ATEXT  Value: $F2" | mail -a From:sensor_monitor -s "RAID-Server
Sensor Event Notification" xxxxxxxxxx@yyyyyyyyy.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
