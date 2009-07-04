From: mskala@ansuz.sooke.bc.ca
Date: Sat, 04 Jul 2009 02:06:29 +0000
Subject: [lm-sensors] ECS 945GCT-D (Fintek F71862FG SuperIO)
Message-Id: <Pine.LNX.4.53.0907032150370.2556@opal.ansuz.sooke.bc.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an Elitegroup (ECS) model 945GCT-D motherboard.  This is an Intel
Atom 230 fanless mini-DTX board with a Fintek F71862FG SuperIO chip; it
seems to be similar to the Jetway NC92-330-LF, which uses the same SuperIO
chip, and using the configuration for that board from the Wiki, I get this
output:

f71862fg-isa-0a00
Adapter: ISA adapter
Vcc3V:       +3.22 V
Vcore:       +1.21 V
   NB:       +1.91 V
+ 5V:        +0.00 V
+12V:       +10.74 V
5VSB:        +3.91 V
VDIMM:       +1.04 V
VSB3V:       +3.42 V
Vbat:        +3.33 V
CPUFAN:        0 RPM  ALARM
SYSFAN1:       0 RPM  ALARM
SYSFAN2:       0 RPM  ALARM
?CPU Temp:   +52.0C  (high = +85.0C, hyst = +81.0C)
                      (crit = +255.0C, hyst = +251.0C)  sensor = transistor
?Sys Temp:     FAULT  (high = +85.0C, hyst = +81.0C)
                      (crit = +100.0C, hyst = +96.0C)  sensor = transistor
???? Temp:  +127.0C  (high = +70.0C, hyst = +68.0C)  ALARM
                      (crit = +85.0C, hyst = +83.0C)  ALARM  sensor = transistor

The BIOS only reports three numbers:  VCore 1.210 V, VDIMM 1.912 V, and
CPU Temp 53.0C.  From this I conclude that the VCore and CPU temperature
numbers are being reported correctly by sensors, and the voltage labelled
"NB" is actually VDIMM.  The other two temperatures seem to be garbage,
and they don't change with system load, so I think the board probably does
not have those channels of the SuperIO chip hooked up to anything useful.

The board has three-pin headers for two fans (called "CPU" and "PWR") but
I have nothing hooked up to those.

So:  it's not difficult to create a configuration file stanza based on the
one from the NC92-330-LF with the non-useful parts set to ignore.  I
wonder about those other voltages, though.  Most of them seem to be
measuring something, but 10.74 sounds low for the +12V supply, so I wonder
if the formula for that is inapplicable to this board.  But then again, I
am running this from an 84W power supply which maybe doesn't have enough
oomph to keep that bus at the full 12V?  The fact that the BIOS doesn't
report any other voltages than VCore and VDIMM is a little odd, and the
BIOS's VDIMM seems to be on a different channel from the one that was
called VDIMM on the Jetway board.  I don't know if any of those voltage
channels can be trusted.
-- 
Matthew Skala
mskala@ansuz.sooke.bc.ca                    Embrace and defend.
http://ansuz.sooke.bc.ca/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
