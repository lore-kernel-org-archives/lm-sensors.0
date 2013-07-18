From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Jul 2013 08:11:02 +0000
Subject: Re: [lm-sensors] Module asus_atk0110 - Fan speed often shows zero instead of correct value
Message-Id: <20130718081102.GB9880@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
In-Reply-To: <CA+1DPT0KNOJht7djog8oK61Fs=ConqJpe_O9zJ9csg1jUNA2Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Jul 16, 2013 at 07:04:39PM +0200, Simon Sandstr=F6m wrote:
> Hello
>=20
> I'm having trouble with the asus_atk0110 kernel module. The speed for fan3
> (CHASSI2 FAN) often just shows zero, but once in awhile it shows the actu=
al
> speed of the fan. I've checked the fan, and it does spin at all time and =
it
> also shows the correct speed at all time in BIOS.
>=20
> There is also a slight delay when reading the input with "cat
> /sys/class/hwmon/hwmon0/fan3_input". When the speed is zero, it takes
> approx. 0.3s and when it shows the correct speed (700RPM) it takes 0.1s.
> All other fan inputs respond with no delay (0.001s).
>=20
> $ uname -a
> Linux 3.2.0-4-amd64 #1 SMP Debian 3.2.46-1 x86_64 GNU/Linux
>=20
> $ lsmod | grep asus_atk0110
> asus_atk0110           17297  0
>=20
> $ sensors --version
> sensors version 3.3.2 with libsensors version 3.3.2
>=20
> Does anyone else have this problem, or any similar problem? I could just
> connect the fan to fan4 and ignore fan3, but for some reason the minimum
> speed for fan4 is 800RPM (the others are 600RPM), and I like my fans
> running at 700RPM..
>=20
This is all determined by ACPI, not by the driver. So I don't think there is
anything we can do about it.

Can you set the minimum fan speed in the BIOS ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
