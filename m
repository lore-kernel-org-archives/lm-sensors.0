From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Aug 2010 12:38:29 +0000
Subject: Re: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <20100822143829.1591c97a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C6BFB8A.7060300@mandel.name>
In-Reply-To: <4C6BFB8A.7060300@mandel.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Olaf,

On Wed, 18 Aug 2010 17:26:02 +0200, Olaf Mandel wrote:
> this is a partial configuration file for the MSI X58 Pro-E (MS-7522)
> motherboard, in case someone else has the board. It works for me, but is
> unfortunately incomplete:
>=20
> * The System1 fan could be on either fan2 or fan3

This should be easy enough to verify. You can temporarily unplug any
system fan (or slow it down by pressing your finger on the middle part -
don't get hurt), and see which reported speed drops.

> * There are several 3.3V inputs, but which one corresponds to the one
> shown in the BIOS?

Most certainly in0. in7 is 3VSB (Stand-By 3.3V) and in8 is Vbat
(battery). It's quite rare that BIOS reports these.

> * The calibration values for in1, in4 and in5 are only approximations
> * No min, max or critical values are given here.

Easy enough to add once you are certain your configuration is OK.

> =3D=BEGIN sensors3.conf=3D> # configuration for the Fintek f71882fg as us=
ed on the MSI X58 Pro-E (MS-7522)
> chip "f71882fg-*"
>=20
> # Temperature
>     label   temp1 "CPU"
>     label   temp2 "IOH"
>     label   temp3 "System"
>=20
> # Fans
>     label   fan1  "CPU"
>     label   fan2  "System 1" # This is not confirmed
>     label   fan3  "System 2"
>     ignore  fan4

No 4th fan header, or just unused on your system? You should only
ignore a fan when the header isn't there.

>=20
> # Voltage
>     label   in0   "3.3V"  # Which of these three to use?
>     label   in1   "Vcore"
>     ignore  in2
>     ignore  in3
>     label   in4   "5V"
>     label   in5   "12V"
>     ignore  in6
>     label   in7   "3.3V"  # Which of these three to use?
>     label   in8   "3.3V"  # Which of these three to use?

The following labels, taken from sensors.conf.default, are clearer:

    label in7 "3VSB"
    label in8 "Vbat"

>     compute in0   (@ * 2), (@ / 2) # Hardwired in chip, don't change
>     compute in1   (@ * 1.35), (@ / 1.35)

This would be quite surprising. On recent CPUs, Vcore is always lower
than the ADC's resolution, so it shouldn't need any scaling. How did
you come with this value?

>     compute in4   (@ * 5.25), (@ / 5.25)
>     compute in5   (@ * 10.9), (@ / 10.9)
>     compute in7   (@ * 2), (@ / 2) # Hardwired in chip, don't change
>     compute in8   (@ * 2), (@ / 2) # Hardwired in chip, don't change
> =3D=3DEnd sensors3.conf=3D
When sending such configuration files, it is a good practice to also
include the output of "sensors -c /dev/null", so that we can review
your choices and possibly help you improve your configuration file.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
