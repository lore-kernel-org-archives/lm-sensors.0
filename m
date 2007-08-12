From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sun, 12 Aug 2007 10:34:47 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46BEE247.4040904@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>	<20070805162141.GI6221@jupiter.solarsys.private>	<46B6053E.2050708@s5r6.in-berlin.de>	<20070810230831.59cbc50f@hyperion.delvare>	<46BCE6D0.7060300@s5r6.in-berlin.de>	<20070811135705.0d0688d7@hyperion.delvare>	<46BDD8B3.8070708@s5r6.in-berlin.de> <20070812111713.1afb24c6@hyperion.delvare>
In-Reply-To: <20070812111713.1afb24c6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Jean Delvare wrote:
> On Sat, 11 Aug 2007 17:41:39 +0200, Stefan Richter wrote:
>> While I test-booted 2.6.22(-rc) yesterday I had a look into the BIOS
>> setup.  There is a fan speed control based on a temperature threshold,
>> separately for CPU fan and case fan.  The thresholds are currently 55=B0C
>> and 50=B0C respectively.
>=20
> Hopefully it is programming the W83627EHG at boot time and no longer
> touching it after that. You can check
> in /sys/class/hwmon/hwmon*/device, some of the pwm*_enable files should
> have value >=3D 2.

$ cat /sys/class/hwmon/hwmon*/device/{name,pwm*_enable}
w83627ehf
coretemp
coretemp
2
2
1

[...]
>> ksensors has different update interval settings, and although I had the
>> w83627ehf readings configured to be updated every 30 seconds, some
>> seemingly unrelated setting was at 5 seconds.  I changed that to 30
>> seconds too and the period of above loop increased to ca. 30 seconds
>> (127 times div =3D 8, 8 times div =3D 128).
>=20
> Hmm. Is this "seemingly unrelated setting" the "Mainboard sensors"
> panel?

Yes.

> Maybe I get what's going on then. This panel gets the CPU
> temperature from the ACPI "thermal" driver (/proc/acpi/thermal). Your rep=
ort
> suggests that the temperature value is taken from the W83627EHF's
> temp2, which is in bank 1. If I am correct, then simply reading
> from /proc/acpi/thermal/*/temperature would break the fan divider (when
> my fixup patch isn't applied, that is.)
>=20
> I recommend that you don't load the ACPI "thermal" driver together with
> the w83627ehf driver, it won't give you any additional information and
> the race condition that exists between both drivers can still result in
> wrong values being reported from times to times (even with my patch.)

I reverted your patch, reloaded the modules, unloaded thermal, checked
readings with "sensors" (OK), started ksensors:  1.) Its "Mainboard
sensors" config panel is gone.  2.) The problem of the fan divider
oscillating between 8 and 128 is gone.  Fan speeds are now correct all
the time.

>> So the BIOS seems innocent.
>=20
> Good news.
>=20
> One remaining mystery is why you did not observe the problem with the
> older kernel. Maybe the ACPI thermal driver was not loaded (or not
> working) back then?

I found two differences:  Gentoo's udev init script autoloads thermal on
boot under 2.6.23-rc2 but it doesn't under 2.6.22(-rc5), for a reason
unknown to me.  If I manually load thermal under 2.6.22(-rc5), the
oscillation happens too --- also in the rythm of ksensors' update
interval but with a slightly different partition into div =3D 8 periods
and div =3D 128 periods.  Ksensors then happens to display the correct div
=3D 8 reading, while sensors shows either the wrong or the correct reading
depending on the moment it is issued.  By playing with the update
intervals in ksensors, ksensors can be tricked into getting the correct
value under 2.6.23-rc2 too.

So, it isn't really a regression from 2.6.22 to 2.6.23-rc1.  It merely
became more apparent after 2.6.23-rc1.

And yes, "cat /proc/acpi/thermal_zone/THRM/temperature" causes the CPU
fan divider to flip to 128 immediately.
--=20
Stefan Richter
-=3D=3D=3D-=3D-=3D=3D =3D--- -=3D--
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
