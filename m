From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Oct 2010 19:53:33 +0000
Subject: Re: [lm-sensors] fancontrol on adt7468
Message-Id: <20101013215333.3b17ab31@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinrFCMaVLhgFfy=rdh07c-5fs8g1xDY+xvwyayP@mail.gmail.com>
In-Reply-To: <AANLkTinrFCMaVLhgFfy=rdh07c-5fs8g1xDY+xvwyayP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Peio,

On Sun, 10 Oct 2010 16:08:21 +0300, Peio Popov wrote:
> I am trying to keep my cpu fan noise down with fancontrol but the
> lowest possible fan speed I can reach is around 1060 RPM and I am
> looking for ways to slow the fan down or stop it.

I presume this is a 4-wire fan? The non-zero minimum speed of these fans
is often a feature, I'm afraid there's no way around it. At least this
is what I observed with Intel fans on Pentium 4 systems. The minimum
speed I could achieve was around 1000 RPM (which I was happy with.) On
4-wire fans, the PWM signal is separate from the power, so even a 0%
duty cycle can leave the fan spinning.

So you should check the specifications of your fan before blaming the
ADT7468 device or is Linux driver.

I also suggest checking on the motherboard if it has jumpers related to
the fans. On my board, there are jumpers to select between 3-wire and
4-wire fan operation. An improper setting of these or similar jumpers
would certainly alter your ability to control the fan.

Lastly, also keep in mind that the PWM signal goes through your
motherboard before it reaches the fan. Board manufacturers are free to
process the signal on the road in any way they like. Maybe IBM simply
doesn't want the CPU fans to be stoppable for hardware safety reasons.

> Hoping that you will be able to help me solve the problem I include
> all the information that might be relevant and helpful:
>=20
> I am using lm_sensors-3.1.2-2.svn5857 on fedora 13 with kernel
> 2.6.34.7-56.fc13.x86_64 installed on IBM Intellistation M. Detailed
> hardware profile of my pc is available at
> http://www.smolts.org/client/show/pub_1a7d5446-bb08-4077-9820-8057f30e4b63
> ..
>=20
> sensors-detect detected adt7468 device and here is a part of the
> sensors command output:
> adt7468-i2c-2-2e
> Adapter: SMBus I801 adapter at 3080
> in0:         +2.49 V  (min =3D  +2.38 V, max =3D  +2.62 V)
> Vcore:       +1.14 V  (min =3D  +0.82 V, max =3D  +1.40 V)
> +3.3V:       +3.36 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> +5V:         +5.12 V  (min =3D  +4.50 V, max =3D  +5.50 V)
> +12V:       +12.23 V  (min =3D  +0.00 V, max =3D +15.94 V)
> fan1:       1064 RPM  (min =3D    0 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:         -1 RPM  (min =3D    0 RPM)
> temp1:       +32.0=B0C  (low  =3D +49.0=B0C, high =3D +21.0=B0C)  ALARM
> M/B Temp:    +28.5=B0C  (low  =3D -63.0=B0C, high =3D -65.0=B0C)
> temp3:       +24.5=B0C  (low  =3D +34.0=B0C, high =3D -65.0=B0C)  ALARM
> cpu0_vid:   +1.419 V
>=20
> The complete sensors command output is attached.
>=20
> I ran pwmconfig and here is the the relevant part:
>=20
> Testing pwm control hwmon5/device/pwm1 ...
>   hwmon5/device/fan1_input ... speed was 5192 now 1011
>     It appears that fan hwmon5/device/fan1_input
>     is controlled by pwm hwmon5/device/pwm1
> ...
>     PWM 255 FAN 5004
>     PWM 240 FAN 5192
>     PWM 225 FAN 5187
> .....
>     PWM 6 FAN 4011
>     PWM 4 FAN 3958
>     PWM 2 FAN 3890
>     PWM 0 FAN 2359
>=20
> I am attaching the resulting /etc/fancontol file.
>=20
> In the hwmon5.values file i am also attaching the files and their
> values as contained in /sys/class/hwmon/hwmon5/device
> (the result of: for file in `ls -1 .`;do echo -n $file " -> "; cat $file;=
 done)

FYI, this is more easily achieved with: grep . *

> When in BIOS the CPU fan runs at constant speed of ~1400 RPM and I see
> no obvious  BIOS options or settings to control it.
>=20
> I am also attaching the sensors3.conf file.
>=20
> I would be very grateful if somebody could help me make the system quiete=
r.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
