From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Dec 2010 09:22:46 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101216102246.013944ce@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 12 Dec 2010 22:02:13 -0600 (CST), Jeff Rickman wrote:
> > Close enough? I wouldn't say that. Which value does the BIOS report
> > exactly?
>=20
> During 1 test run I kept the system "in the BIOS" on the "Hardware
> Monitor" screen for almost an hour. The voltages never changed. I suspect
> the vendor isn't reporting any measured voltages here; could be "static"
> voltage values. As for the "V+1.5" value in the BIOS, it never changed
> from "1.50". Never. Only the System Fan Speed (LM_Sensors 'Fan1'), CPU
> Temp, and SYS Temp values ever change on this screen.
>=20
> > BTW, you never clearly reported all exact voltage values reported by the
> > BIOS. This would help a lot.
>=20
> As displayed "in order" from the "Hardware Monitor" screen:
>=20
> V+1.5 =3D 1.50 V
> 5VTR  =3D 4.90 V
> VBAT  =3D 3.20 V
> V+5   =3D 5 V
> Vccp  =3D 1.20 V
> VCC   =3D 3.30 V
> VTR   =3D 3.30 V

Thanks.

> > If you stay in the BIOS long enough to spot more than one value for
> > each voltage, this can help deduce scaling factors.
>=20
> As I write this email now, none of the voltages ever change, not even by
> 1/100 (0.01) of a Volt while sitting in the BIOS for almost an hour. I
> hardly believe any power supply or system power rails are that stable,
> based on experiences with other PC-style computers.

I would tend to agree. It could be that the BIOS reads the voltages
once when you enter the screen and doesn't update them after that. But
most probably they are rounding the value to 0.1 V: don't you find it
highly suspicious that the second decimal place is 0 for all readings?
With a 0.1 V resolution, it isn't all that surprising that the values
never change (and if they did, we couldn't get any useful information
out of that anyway.)

> > (...)
> > 1.5 V is quite different from 1.44 V, so either it's not in7, or the
> > scaling factor of 2 isn't correct.
>=20
> 1.44V is within +- 10 percent of 1.5V, but I agree that improvement is
> needed; changing scaling values in LM_Sensors is a "math problem".

Well, now that you have pointed out how suspicious the BIOS values
look, I agree that there is no point in trying to match them exactly in
"sensors".

> > Anyway, it beats me why the manufacturer would scale down a voltage
> > which it could monitor directly. Very odd.
>=20
> This entire Acer system is "very odd".
>=20
> Why would a vendor set the system fan to ~760 rpm when HDD temperatures at
> that level almost reach 50C and before any serious system load is applied?
> 50C is a dangerous threshold for most HDD.

My HDD is currently running at 31=B0C and has never exceeded this
temperature :) But this is a low-power model and mounted in a Zalman
heatpipe enclosure.

> Thus I use "fancontrol" to
> override that automatic setting and push fan speed to "full" to bring HDD
> temps down to <@C. If there is a better method than "fancontrol" that I
> can call from "rc.local" (like "echo 'value' > 'someplace in system'"), I
> would appreciate it since there is no BIOS control for fan speed at all:
> it's based on a "Phoenix TrustedCore" BIOS / Intel Shelton Reference BIOS.

The SCH5127 has an automatic fan speed control mode which you should be
able to setup by writing the proper values to sysfs. Should be
equivalent to "fancontrol" but more reactive and less CPU-intensive.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
