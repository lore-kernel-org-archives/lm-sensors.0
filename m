From: bilse@networksignature.com (Per Gregers Bilse)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: as99127f feedback
Message-Id: <200304130010.BAA27667@spirit.qbfox.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Since the ASUS 99127 chip is poorly documented, I thought I'd provide
you with my experiences.  Through experimentation (and dilligent use of
the ASUS iPanel) I've found that there are a number of mistakes and/or
inconsistencies in the current (lm_sensors-2.7.0) documentation for this
chip, as well as some unexpected behaviour.

Board: A7M266-D (BIOS rev 1010, delivered with rev 1009)
CPUs: Two AMD Athlon MP 2000+
RAM: 512M PC2100 DDR registered
PSU: Channel Well Technology 450W with active PFC

Note: In case you missed it: This is a twin CPU setup, and it seems ASUS
has reassigned a couple of measurements to support two CPUs.

Off topic, but possibly interesting:

The PSU is an important bit, it seems.  When I got the machine it had
a mostly identical 400W PSU also from CWT, but it didn't work well.
During initial testing I got core voltage readings ranging from 1.64 to
1.88 volts during variable load (this is well outside AMD's published
acceptable spec of 1.70-1.80), and on three identical occasions (starting
'make xconfig' for the kernel source) the machine switched itself into
suspend mode (power off, PSU LED blinking).

The jury is still out wrt if the PSU was underrated or outright faulty.
Having replaced it with a 450W unit, however, I have experienced no
problems.  YMMV.

Back to "on topic":

Firstly, yes, I need to use the "force" option to avoid the chip being
misdetected.  Hardly suprising, but the next bit is:

While the chip does not supply in7 and in8 values (just like the w83781d),
I've found that the in5 (-12v) and in6 (-5V) calculations have to be
done as for a w83782d, BUT with the scaling factors swapped.  That is:

  - the as99127f returns the same set of values as the w83781d, but:
  - mapping for in5 and in6 should be as for the w83782d, but:
  - the scaling factors need to be swapped

In practical terms:

w83781d calculation (completely martian):

    compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

w83782d calculation:

    compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14

as99127f calculation (at least for my board):

    compute in5 (3.14 * @) - 14.91  ,  (@ + 14.91) / 3.14
    compute in6 (5.14 * @) -  7.71  ,  (@ +  7.71) / 5.14

Notice the simple "5.14" and "3.14" swap.  I actually wonder if your
docs for the w83782d are correct, it's a bit too much of a coincidence.

As for actual readings, here's an augmented output from 'sensors':

[bilse@bento bilse]$ sensors
as99127f-i2c-0-2d
Adapter: SMBus AMD768 adapter at e4e0
Algorithm: Non-I2C SMBus adapter
in0:   VCore 0:   +1.79 V  (min =3D  +1.69 V, max =3D  +1.85 V)
in1:   VCore 1:   +1.79 V  (min =3D  +1.69 V, max =3D  +1.85 V)
in2:   +3.3V:     +3.31 V  (min =3D  +3.13 V, max =3D  +3.45 V)
in3:   +5V:       +4.99 V  (min =3D  +4.72 V, max =3D  +5.24 V)
in4:   +12V:     +12.01 V  (min =3D +10.79 V, max =3D +13.19 V)
in5:   -12V:     -12.37 V  (min =3D -13.21 V, max =3D -10.86 V)
in6:   -5V:       -5.24 V  (min =3D  -5.35 V, max =3D  -4.78 V)
fan1:  CPU0 fan: 4066 RPM  (min =3D 3000 RPM, div =3D 2)
fan2:  CPU1 fan: 4166 RPM  (min =3D 3000 RPM, div =3D 2)
fan3:  PSU fan:  1757 RPM  (min =3D 1500 RPM, div =3D 4)
temp1: M/B temp:    +30=B0C  (limit =3D  +60=B0C)
temp2: CPU0 temp: +35.4=B0C  (limit =3D +120=B0C, hysteresis =3D +100=B0C)
temp3: CPU1 temp: +35.0=B0C  (limit =3D +120=B0C, hysteresis =3D +100=B0C)

These values have been correlated with the values displayed by the ASUS
iPanel, except to note that for voltages the iPanel only shows Vcore0,
Vcore1, and V3.3.  Also, the fan tacho outputs are in a slightly different
sequence:  The iPanel shows fan-cpu0, fan-other, fan-cpu1, whereas the
as99127f output is as shown above:

fan1: fan-cpu0
fan2: fan-cpu1
fan3: fan-other

On my board, fan3 comes from the fan connector next to the ATX12V power
connectors, and it so happens that the CWT PSU has a tacho lead for the
main fan in the PSU; otherwise this value would have been '0'.

As for VRM, this board/CPU is version 9.0, Vid =3D 1.750.

As for unexpected behaviour, I'm stumped by this: During load, the Vcore
values (for both CPUs) as shown by 'sensors' drop by a solid 0.03V,
whereas the values displayed by the iPanel don't change.  This is a fact,
I've spent plenty of time observing this.  This leads me to conclude
there's some unexpected regulation affecting the as99127f chip, causing
it to mismeasure the (very low, difficult to get right) Vcore voltages,
whereas the iPanel somehow gets them right.  I would have thought the
iPanel gets its values in the exact same way as 'sensors' does, but,
if so, I can't explain the difference in readings.  Note that these are
not haphazard readings: I have repeatedly (a dozen times or so) fired
up a dummy program (a Dhrystone benchmark) on the machine and watched
the 'sensors' reading of Vcore drop by 0.03V, while the iPanel reading
doesn't change (the iPanel is set to update every 8 seconds in the BIOS,
so any changes would be easily noticeable).

Any questions, please ask.  If I can help in some other way, please do
let me know.

Thanks, and many thanks for your efforts,

  -- Per
