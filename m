From: Adam Rosi-Kessel <adam@rosi-kessel.org>
Date: Fri, 19 Apr 2013 14:47:18 +0000
Subject: Re: [lm-sensors] Dell Inspiron 530 Chassis Fan Control?
Message-Id: <20130419144718.GA7386@whitehail.bostoncoop.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6538373020946081276=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130316175820.GA979@whitehail.bostoncoop.net>
In-Reply-To: <20130316175820.GA979@whitehail.bostoncoop.net>
To: lm-sensors@vger.kernel.org

--===============6538373020946081276==
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2013 at 04:07:13PM +0200, Jean Delvare wrote:
> > Apologies as this a bit OT, but hoping someone can help me understand=
=20
> > what's happening here. It does appear that the Inspiron has a 3-pin=20
> > connector. When I power up the box, it is very quiet for about 4 or 5=
=20
> > minutes. After that, the fan appears to go to 100% and never quiets d=
own=20
> > again. Even when I cpufreq-set to powersave and cap the max CPU freq =
at=20
> > 2.0 GHz for all four cores (80% of max), it still stays loud=20
> > indefinitely.
> Don't you have any other thermal sensor in the system than the ACPI
> thermal zone? Did you try running sensors-detect already? A recent
> version preferably:
>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

Martin Hundeboll's suggestion lead me to at least a work-around. The box
came with a builtin mobo VGA card as well as a high-powered ATI catalyst
one (probably for gaming). I removed the high-powered VGA card and the
fan noise is back to normal. Not sure if the noise was from the fan on
the VGA card, or the VGA card was generating so much heat that other fans
never spun down, but in any case this is a fine solution because the box
is mainly a server.

Incidentally, sensors-detect reported:

Driver `it87':
  * ISA bus, address 0x290
    Chip `ITE IT8718F Super IO Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

And sensors (the first one must be that "always 40.0" number):

acpitz-virtual-0
Adapter: Virtual device
temp1:       +40.0=B0C  (crit =3D +120.0=B0C)                 =20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +36.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 1:      +35.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 2:      +44.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20
Core 3:      +38.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C) =20

it8718-isa-0290
Adapter: ISA adapter
in0:         +1.12 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in1:         +3.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in2:         +3.33 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+5V:         +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in4:         +3.01 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in5:         +0.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in6:         +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
5VSB:        +2.77 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
Vbat:        +3.12 V
fan1:       1569 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:       1171 RPM  (min =3D    0 RPM)
temp1:       +84.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp2:       +33.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp3:       -74.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
cpu0_vid:   +0.000 V


> Do you have any /sys/class/thermal/cooling_device* with attribute type
> other than Processor?

0 is "Fan" and "1-4" are all Processor.

> Do you have any reason to believe that the fan speed can be controlled?
> Does it behave better under a different OS?

My belief was based on the fact that for the first few minutes after
boot-up, the box operated quietly, and then would get very loud. So it
would seem *something* was controlling the fan speed.

> Do you see any option in the BIOS to control the thermal and/or
> acoustic profile? Try playing with these if they exist.

Nothing was in BIOS. It's a pretty old device at this point and latest
BIOS release was a long while back.

Adam


--===============6538373020946081276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6538373020946081276==--
