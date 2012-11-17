From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 17 Nov 2012 08:13:03 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <20121117091303.3055db25@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 16 Nov 2012 22:45:05 -0600, Leslie Rhorer wrote:
> > > > > SB:                 +1.30 V  (min =3D  +0.99 V, max =3D  +1.21 V)
>=20
> > > > > MB Temperature:     +45.0=B0C  (high =3D +45.0=B0C, crit =3D +95.=
0=B0C)
>=20
>=20
> > k10temp is the AMD CPU temperature as reported by the CPU itself. It is=
n't
> > really accurate. acpitz-virtual is, as the name says, a virtual device.
> > acpitx is short for "ACPI thermal zone". It may also reflect the CPU
> > temperature, but I don't know for sure.
> >=20
> > Guenter
>=20
> 	OK, thanks once again.  I guess I will ignore them.  I hope you
> don't mind me asking all these questions, but I do have a couple more.  N=
ote
> the two reports above.  Where is the sensors routine getting its limit
> values?  Both the SouthBridge voltage and the chip array temperature are
> reported out of bounds, yet I am not overclocking, at all.  The manual sa=
ys
> the motherboard offers legitimate OC values of 1.10, 1.12, 1.14, 1.16, 2.=
98,
> and 3.00 VDC.  Given that, I shouldn't think 1.3V would be out of bounds.

The limits are set by the BIOS itself. Note that ATK0110 is a virtual
(ACPI) device so there is no guarantee that the limits reported by the
driver have actually been programmed into the underlying monitoring
chip. They may be purely informative.

Given that (0.99 + 1.21) / 2 =3D 1.10, it seems clear to me that the
nominal value for SB is supposed to be 1.10 V. This is also in line
with the documented OC values of 1.10, 1.12, 1.14 and 1.16 V. The
documented values of 2.98 and 3.00 V OTOH are odd... You never
overclock a nominal voltage to more than +25%. I can't actually believe
that your BIOS offers to overclock +1.10V to +3.00V.

So it is well possible that you have a real problem here. It would be
interesting to see if another user with the same board sees similar
values. If not, maybe your PSU has an issue or you have wrong settings
in your BIOS. You may also look for a BIOS update, as the ATK0110 ACPI
code comes with the BIOS.

> 	That, and 45C is just not really that hot.  The chipset often rises
> to well over 60C, and I don't really believe it to be a problem.

I agree that 45=B0C isn't that hot, and also it is curious to consider
45=B0C as hot when the critical limit is set as high as 95=B0C. This would
either be a BIOS bug or a misconfiguration - it is possible that you
can change this limit manually in the BIOS. Alternatively, it could be
that the "high" point is set to enable some form of cooling and there's
nothing wrong with the temperature being above that point.

> 	Finally, and this one I admit is really getting close to being
> totally off-topic, but the script I am writing reports the out of bounds
> values to me via mail.  The degree character gets mangled, though, making
> the text look funny.  It's really not a big deal, but it is a bit annoyin=
g.
> The text above comes out as:
>=20
> +40.0=C2=B0C (high =3D +60.0=C2=B0C, crit =3D +95.0=C2=B0C)
>=20
> All I do is store the text of the `sensors` command to a variable and then
> pass the variables to mail.  (This is a bash script.)
>=20
> 	SID=3D$( echo $line | cut -d ":" -f1 )		# $SID =3D Sensor ID
> 	AID=3D$(echo $line | cut -d ":" -f4 )		# $AID =3D Sensor Name
> 	TID=3D$(echo $line | cut -d ":" -f5 )		# $TID =3D Text Name for e-mail
> 	FIELDS=3D$( sensors | grep "$AID:" )		# $FIELDS =3D Text from `sensors`
> 	F2=3D$( echo $FIELDS | cut -d ":" -f2 )		# $F2 =3D Description from `sen=
sors`
> 	CVAL=3D${F2% (*}					# $CVAL =3D Current Sensor Value
>=20
> ...
>=20
> echo "$TID $ATEXT  Value: $F2" | mail -a From:sensor_monitor -s "RAID-Ser=
ver
> Sensor Event Notification" xxxxxxxxxx@yyyyyyyyy.com

This is an UTF8 vs. non-UTF8 issue. You are running "sensors" with an
UTF8 locale, but the e-mail you send apparently lacks proper encoding
information. This can be solved in two ways: either set the locale to
non-UTF8 when you run "sensors" (LANG=3Den_US sensors), or add some
encoding parameter to the mail command (my version claims utf-8 to be
the default but apparently that's not your case.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
