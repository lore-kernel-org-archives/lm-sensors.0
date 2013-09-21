From: Kent Larsson <kent.larsson@gmail.com>
Date: Sat, 21 Sep 2013 12:31:56 +0000
Subject: [lm-sensors] Config of P9X79 WS motherboard and its nct6776-isa-0290 sensor
Message-Id: <CALmZR2OS2drgwx9wvfocsmWwgqWQcg0WKFd0_DAYokUT4i9+Xg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

I have a P9X79 WS motherboard and am having some problems with the
nct6776-isa-0290 sensor. I'll start with most serious problem (where Google
didn't turn up anything promising), 2 out of 4 fans are reported as 0 RPM,
even though they are running.

I am running Debian stable which has sensors version 3.3.2 with libsensors
version 3.3.2. I am using the latest kernel in Debian stable at the time of
writing, uname -a prints:
Linux cow 3.2.0-4-amd64 #1 SMP Debian 3.2.46-1+deb7u1 x86_64 GNU/Linux

I have executed sensors-detect and loaded the suggested kernel modules. The
sensors command prints:

----/ sensors output start /-----

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 0:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 1:         +39.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 2:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 3:         +37.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 4:         +36.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)
Core 5:         +35.0=B0C  (high =3D +81.0=B0C, crit =3D +91.0=B0C)

nouveau-pci-0100
Adapter: PCI adapter
temp1:        +48.0=B0C  (high =3D +100.0=B0C, crit =3D +110.0=B0C)

nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.81 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.34 V  (min =3D  +2.70 V, max =3D  +3.63 V)
fan1:          978 RPM  (min =3D    0 RPM)  ALARM
fan2:         1508 RPM  (min =3D    0 RPM)  ALARM
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:            0 RPM  (min =3D    0 RPM)  ALARM
fan5:            0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +37.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D
thermistor
CPUTIN:        +41.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D CPU diode
AUXTIN:        +31.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D
thermistor
PECI Agent 0:  +32.0=B0C
cpu0_vid:     +1.708 V
intrusion0:   OK
intrusion1:   ALARM

----/ sensors output end /-----

As you can see there are no "div" in any of the output, which I understand
means that changing the divisor won't help?

I have screenshots of my BIOS (upgraded to latest version) and an annotated
picture of the actual machine inside here:
http://forums.debian.net/viewtopic.php?f=3D10&t=3D107523&p=3D512640#p512640

That link also contains sensors-detect output and my complete
/etc/sensors3.conf as I thought they were a bit too large to post in this
message. Let me know if that conclusion was wrong, in which case I'm sorry
and I'll paste them here.

I am willing to help out any way I can to improve lm-sensors support for my
motherboard. It's supposed to be a nice motherboard, so improved
compatibility would hopefully be of value for lots of users.

Thank you for reading this post! I would greatly appreciate some help as I
am pretty dumbfounded when it comes to this problem.

Best regards, Kent
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
