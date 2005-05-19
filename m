From: oldbomber@hotmail.com (Thomas Swan)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: w83627hf triggers high fan speed, Re: Ticket 1722
Message-Id: <BAY16-F41605B467AC3A4F1B5C036BD940@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I just wanted to let you know I had the exact same problem on a ASUS k8v se=
=20
deluxe mobo with Q-Fan Control enabled in Bios, as Ticket 1722.

Fedora Core 2 i386    kernel  2.6.9-1.11_FC2

and

Fedora Core 3 X86_64  kernel  2.6.9-1.724_FC3


As soon as all the modprobes were completed

modprobe i2c-viapro
modprobe i2c-isa
modprobe lm75
modprobe eeprom
modprobe w83627hf
/usr/bin/sensors -s # recommended

the CPU fan went to maximum RPM.

w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.57 V  (min =3D  +1.71 V, max =3D  +1.89 V)
+3.3V:     +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:       +5.21 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:     +11.55 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:      +1.04 V  (min =3D -13.18 V, max =3D -10.80 V)
-5V:       +5.10 V  (min =3D  -5.25 V, max =3D  -4.75 V)
V5SB:      +5.62 V  (min =3D  +4.76 V, max =3D  +5.24 V)
VBat:      +0.40 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:     0 RPM  (min =3D   -1 RPM, div =3D 4)
fan2:      5000 RPM  (min =3D 3341 RPM, div =3D 2)
temp1:       +43=B0C  (high =3D    +4=B0C, hyst =3D   +56=B0C)   sensor =3D=
 thermistor  =20
ALARM
temp2:     +50.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
 thermistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled

I used:

w83626hf init=3D0

as suggested by Khali and it all worked fine and the CPU fan acted as it=20
should do.  It also then picked up fan1 speed.

Thank you very much for the tip.

Cheers Tony.

_________________________________________________________________
Click here for the latest chart ringtones: =20
http://ringtones.com.au/ninemsn/control?page=3D/ninemsn/main.jsp
