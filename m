From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Mon, 27 May 2013 15:57:05 +0000
Subject: [lm-sensors] Configuring GA-F2A85X-D3H
Message-Id: <20899.33361.650228.932932@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I've bought a new motherboard, a Gigabyte GA-F2A85X-D3H, equipped it
with an A8-5600K APU, and now I'm trying to get lm-sensors configured
correctly.  So I found my way to
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling and started.

The fans were easy.  fan1 is the CPU fan, and fan2 through fan4 are
the ones labeled "Chassis fan 1" through "Chassis fan 3" on the board.
Sensors reports a fan5 too, but there is nothing on the board that
would correspond to this.

For temperatures, temp3 is the one that varies most with load, and
when it reaches 70=B0C the computer starts to beep.  I put the warning
level for the CPU temperature to 70=B0C in the BIOS.  So I conclude that
temp3 must be the CPU temperature, while temp1 must be what is called
"Sys temp" in BIOS.  The temperature of the chipset, I assume.  temp2
reports -8=B0, which I guess means it isn't connected.

So to the tricky part, the voltage sensors.  The BIOS reports five
voltages:

Vcore        1.428V
Dram Voltage 1.488V (1.476V once)
+3.3V        3.304V
+5V          5.040V
+12V        12.168V

The first two matches perfectly in0 and in1 without scaling.  For the
remaining three, there are these inputs to choose from in the raw
"sensors" output:

   in2_input: 2.040
   in3_input: 2.004
   in4_input: 2.016
   in5_input: 2.220
   in6_input: 2.220

That's five values pretty close to each other.  Tricky!  All have
0.000 as min and 3.060 as max by default.  Might the two identical on
2.220 be unconnected?  Being exactly the same makes me a bit
suspicious, but they are not at the extreme of the range for it8728.

In addition, sensors also reports

   3VSB:           +3.31 V  (min =3D  +0.00 V, max =3D  +6.12 V)
   Vbat:           +3.19 V =20

I assume these are correct the way they are.

Following the webpage, I've googled for other snapshots of the BIOS.
But I have had problems finding many on the net.  I found only one
with with exactly the same board
(http://diybbs.zol.com.cn/11/13_107257.html).  It is in Chinese, which
i don't read, but positions and traditional digits made it usable
anyway.

On
http://hexus.net/tech/reviews/mainboard/51021-gigabyte-ga-f2a85xm-d3h/?page=
=3D2
I also found a review of a mATX variation of the board, which looks
very similar.  But I guess "similar" isn't good enough here?

So I get:

+3.3V: 3.304 3.344
+5V:   5.040 5.070
+12V:  12.168 12.240

If the 30mV difference on the +5V reading is one "step", the scaled
value would be 2.016, which matches with in4.  So that could be one of
them.

If the 72mV difference in the +12V reading is also one "step", it
should have a scaled value of 2.028.  That is in the range of the
above values, but roughly equally close to several of them.

And I don't get the 40mV difference in the +3.3V scale to fit any of
them really, neither as 1 nor as 2 "steps".  If it would be two steps,
it ought to be 1.982 scaled, which isn't too far from in3.  But it is
a longer distance fron in3 than the distance between in3 and in4, so
I'm not sure if I can trust this.

So I'm uncertain what conclusions I can draw.  Anyone has any good
advice?  Do I dare trust in4 is +5V scaled 30/12?  What to make of the
rest?

Below is my configuration so far, in case you want to add it to the
wiki in this state.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

chip "it8728-*"
    label in0 "Vcore"
    label in1 "Dram Voltage"
    # label in2 "?"
    # label in3 "?"
    # label in4 "?"
    # label in5 "?"
    # label in6 "?"

    # Min and max for AMD A8 5600K APU (this will depend on your APU)
    set in0_min  0.825
    set in0_max  1.475
    # JEDEC standard for DDR3
    set in1_min  1.425
    set in1_max  1.575
    # 5 % tolerance on the remaining measurements
    # set in2_min  ? * 0.95
    # set in2_max  ? * 1.05
    # set in3_min  ? * 0.95
    # set in3_max  ? * 1.05
    # set in4_min  ? * 0.95
    # set in4_max  ? * 1.05
    # set in5_min  ? * 0.95
    # set in5_max  ? * 1.05
    # set in6_min  ? * 0.95
    # set in6_max  ? * 1.05
    set in7_min  3.3 * 0.95
    set in7_max  3.3 * 1.05

    label fan1 "CPU fan"
    label fan2 "Chassis fan 1"
    label fan3 "Chassis fan 2"
    label fan4 "Chassis fan 3"
    ignore fan5

    label temp1 "System temp"
    ignore temp2                # Reports -8.0 =B0C
    label temp3 "CPU temp"

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
