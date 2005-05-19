From: docmad@md.prestige.net (Bruce Miller)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: W83697HF or VT8233 (or not?)
Message-Id: <3BDECF1E.1060900@md.prestige.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Mark D. Studebaker wrote:

> Your 83697 must be on the isa bus so you don't need
> the CVS version of i2c-viapro to access it.
> To force on the isa bus use the special bus number 9191:
> 'modprobe w83781d force_w83697hf=9191,0xXXX' where
> XXX is probably 290 but check the output of sensors-detect
> to see where it found it.


Ah, thanks!

After a couple of days (and since I ended up having to load some
cvs modules to get my Audigy card somewhat working; Ah, life on
the bleedin' edge :>),  I went ahead and loaded the i2c & lm_sensors
CVS modules.

It did give me some more info to work with, and now I can look at
my eeproms (I dont know why, but...).  But perhaps I was misled
or misinterpreted the `more info' !  It seemed to indicate I should
use
   modprobe w83781d force_w83627hf=3D0,0x69
which _did_ give me apparent sensors output, but all the numbers
were nonsense, eg, the fan was running at an impressive 37500 rpm!
Wow! and all min & max were the same as the values.....

I just tried your suggestion (and indeed 290 is where sensors-detect
had found the chip) [I could have sworn that I tried this before...]
At any rate, now I'm getting mostly sensible (see below)

A few inputs I'm pretty sure aren't hooked up (fan2,fan3,temp3, Vcore2?)
A couple of others look worrisome (VCore1, +3.3V, -12V, -5V), but
perhaps the conversion parameters need tweeking for the w83697hf ?

If anybody knows the needed tweaks, I'd appreciate it; otherwise, I'll
eventually grope around and try to figure it out.

At any rate, I'm much closer;  Thanks!!!


w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.77 V  (min =3D  +1.23 V, max =3D  +1.36 V)
VCore 2:   +0.00 V  (min =3D  +1.23 V, max =3D  +1.36 V)
+3.3V:     +1.52 V  (min =3D  +3.13 V, max =3D  +3.45 V)
+5V:       +4.89 V  (min =3D  +4.72 V, max =3D  +5.24 V)
+12V:     +12.39 V  (min =3D +10.79 V, max =3D +13.19 V)
-12V:      +1.95 V  (min =3D -10.90 V, max =3D -13.21 V)
-5V:       +0.61 V  (min =3D  -4.76 V, max =3D  -5.26 V)
V5SB:      +5.58 V  (min =3D  +4.72 V, max =3D  +5.24 V)
VBat:      +3.08 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:     4891 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)
fan3:        0 RPM  (min =3D 3000 RPM, div =3D 2)
temp1:       +77?F  (limit =3D +140?F, hysteresis =3D +122?F) sensor =3D=20
thermistor
temp2:    +114.8?F  (limit =3D +140?F, hysteresis =3D +122?F) sensor =3D=20
thermistor
temp3:    +491.9?F  (limit =3D +492?F, hysteresis =3D +492?F) sensor =3D=20
thermistor
vid:      +1.30 V
alarms:   Chassis intrusion detection
beep_enable:
           Sound alarm disabled
