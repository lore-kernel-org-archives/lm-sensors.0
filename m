From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Tue, 13 Dec 2005 01:02:04 +0000
Subject: [lm-sensors] Gigabyte GA-K8NF-9 sensors.conf?
Message-Id: <20051213010204.GA6612@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051208234144.GG890@paradise.net.nz>
In-Reply-To: <20051208234144.GG890@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> We did not receive any configuration file, but Fred Riedel and Sam
> Elstob (CC'd) have a similar board and may have some information to
> share.

No information received.

> 2.61V is not Vcore2 (AMD64 CPUs are not dual-planed AFAIK) but more
> likely Vdimm (the memory modules voltage).

Correct, the BIOS health display should have told me that.

> I have an AMD64 motherboard from Gigabyte which has its temperature
> stuck at 25 degrees C. I asked Gigabyte about it and they confirmed the
> lack of actual motherboard temperature sensor. 25 degrees C being the
> equilibrium temperature of most thermistor-based temperature
> measurements, I think they soldered two resistors of equal value instead
> of one thermistor and one resistor. No idea why they did do that, as
> the saved expense is certainly neglectible.

Soldering two resistors onto the board instead of connecting the input
to 0V or nothing is positively stupid. However, given soldering skills
and a disinterest in warranty, replacing the resistor with a thermistor
should be possible - assuming one can find the correct place and a
suitable thermistor. For now I've disabled this value.

> > The CPU temp is about 2?C to low when compared with BIOS.
> 
> Mosty likely because your BIOS idle state is less idle that your Linux
> idle state.

Probably, though I'm not yet totally convinced.

Below is my current config for this board, so others can start with
that. I don't quite see it as finished or confirmed, but it's usable:

it8712-isa-0290
Adapter: ISA adapter
Vcore:     +1.42 V  (min =  +1.20 V, max =  +1.81 V)
Vdimm:     +2.61 V  (min =  +2.40 V, max =  +2.90 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.47 V)
+12V:     +11.88 V  (min = +11.37 V, max = +12.58 V)
CPU fan:  2481 RPM  (min =  664 RPM, div = 8)
Sys fan:     0 RPM  (min =    0 RPM, div = 8)
CPU Temp:    +30?C  (low  =   +10?C, high =   +45?C)   sensor = thermistor

There's an interesting problem: the BIOS can control the CPU fan speed
depending on current CPU temp, and that can include fan off, which then
creates an alarm. The alarm condition would have to depend on too-low
fan speed as well as temperature-exceeded.

Thanks for all your help!

Volker




# These settings are for a Gigabyte GA-K8NF-9 motherboard.
# Adjust the sys fan minimum to your fan.
# The BIOS has CPU fan speed control in 5 steps (off, 3 temperatures, full).
# This creates a problem for the alarm mechanism: when the CPU temperature
# is below the off threshold, the fan isn't actually supposed to be going.
# Volker Kuhlmann, 13 Dec 2005

chip "it8712-*"

  label in0 "Vcore"
  label in1 "Vdimm"
  label in2 "+3.3V"
  label in3 "+5V"
  label in4 "+12V"
  label in5 "-12V"
  label in6 "-5V"
  label in7 "Stdby"
  label in8 "Vbat"

  ignore vid
  ignore in3
  ignore in5
  ignore in6
  ignore in7
  ignore in8

  compute in0 0.03+@ , @-0.03
  compute in4 ((30/10) +0.97)*@ , @/((30/10) +0.97)

  set in0_min 1.2
  set in0_max 1.8
  set in1_min 2.4
  set in1_max 2.9
  set in2_min 3.3 * 0.95
  set in2_max 3.3 * 1.05
  set in3_min 5.0 * 0.95
  set in3_max 5.0 * 1.05
  set in4_min 12 * 0.95
  set in4_max 12 * 1.05
  set in5_max -12 * 0.95
  set in5_min -12 * 1.05
  set in6_max -5 * 0.95
  set in6_min -5 * 1.05
  set in7_min 5 * 0.95
  set in7_max 5 * 1.05

  ignore temp1
  label temp2 "CPU Temp"
  set temp2_over 45
  set temp2_low 10
  ignore temp3

  # Fans
  label fan1 "CPU fan"
  set fan1_min 1000
  label fan2 "Sys fan"
  set fan2_min 0
  label fan3 "PSU fan"
  set fan3_min 0
  ignore fan3






-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

