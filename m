From: Bryan Kadzban <bryan@kadzban.is-a-geek.net>
Date: Sun, 11 Aug 2013 04:36:10 +0000
Subject: [lm-sensors] sensors.conf for MSI 990FXA-GD80
Message-Id: <520714BA.4050006@kadzban.is-a-geek.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

...using a Fintek SuperIO chip.  in{0..4} definitely correspond to
voltages shown in the BIOS; others I have guesses about, but the BIOS
won't confirm them.

Unfortunately I only have a CPU fan connected; the other two fan inputs
correspond to two of the four other fan ports on the motherboard (which
are labeled SYSFAN1 through SYSFAN4), but because nothing is connected
to them, I don't know which two are which SYSFAN ports.

Since temp2_input is pegged at 127000, I assume nothing is plugged into
it on the SuperIO chip.

-----------------------------------------------------------
chip "f71882fg-*"

 label in0 "+3.3V"
 label in1 "Vcore"
 label in2 "Vdram"
 label in3 "+  5V"
 label in4 "+ 12V"

 label fan1 "CPU fan"
# Not sure which port these two are:
 label fan2 "SYSFANx fan"
 label fan3 "SYSFANy fan"

 label temp1 "CPU Temp"
 label temp3 "System Temp"

# ADC has an 8mV LSB, 2.048V max.
 compute in0 @*(2),    @/(2)
# The BIOS says +5V varies by 43mV.
 compute in3 @*(43/8), @/(43/8)
# The BIOS says +12V varies by 90mV.
 compute in4 @*(90/8), @/(90/8)
# Not sure what the rest of the inputs are, since the BIOS doesn't show
# them.  Raw values below:
# in5 registers 16 or 24 mV
# in6 registers 1176mV
# in7 registers 1656mV (maybe a 3.3V line, 2x multiplier)
# in8 registers 1576mV (maybe battery voltage at 2x, or more DRAM)

 ignore in5
 ignore in6
 ignore in7
 ignore in8
 ignore temp2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
