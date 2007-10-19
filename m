From: "Mark E. Hansen" <meh@Winfirst.Com>
Date: Fri, 19 Oct 2007 19:40:52 +0000
Subject: [lm-sensors] lm_sensors on ASUS M2NPV-VM motherboard using
Message-Id: <47190844.8070108@Winfirst.Com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46ED7EFC.4030609@Winfirst.Com>
In-Reply-To: <46ED7EFC.4030609@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I posted this question on Sept 16th, but didn't get any responses. The point
I don't understand about creating a 'sensors.conf' from scratch is how to
come up with the various multiplier/division factors that are needed to
get accurate voltages.

Can someone please have a look at this and let me know if I'm just missing
something?

Thanks

----- original messages posted on 16 September 2007:

I'm running CentOS Linux 4.5 on a desktop machine using the
ASUS M2NPV-VM motherboard and an AMD A64 X2 3800 (65watt) CPU.
The chipset is Northbridge NVIDIA GeForce 6150 GPU, Southbridge
NVIDIA nForce 430 MCP.

I'm running lm_sensors 2.8.7 (which is current for CentOS 4.5)

 From reading various archives of problems other people have had,
it seems those with the same board have the IT8716F chip, but
when I run sensors detect, it shows that I'm running the IT8705F/
IT8712F/SiS 950, which should be supported.

When I use the sensors.conf that comes with the package, it seems
to not be showing the correct sensor data, as though it thought
it was a different chip.

Is sensors-detect wrong in saying that I'm running the IT8705F,
and that I'm really running the IT8716F?

Here is the summary output from sensors-detect:

==================================
  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `it87' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
==================================

When I look at the Hardware Monitoring page of my machine's BIOS,
I see the following:

   VCore Voltage   : 1.23V
   3.3 Voltage     : 3.18V
   5v Voltage      : 4.95V
   12v Voltage     : 11.60V

   CPU Temp        : 41C
   M/B Temp        : 40C

   CPU Fan         : 3096RPM
   Chassis 1 Fan   : 0RPM
   Chassis 2 Fan   : 4656RPM
   Power Fan       : 0RPM

Here is the output from 'sensors':

==================================
it87-isa-0290
Adapter: ISA adapter
VCore 1:   +1.09 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
VCore 2:   +3.09 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+3.3V:     +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
+5V:       +4.76 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
+12V:     +11.20 V  (min = +16.32 V, max = +16.32 V)   ALARM
-12V:     -27.36 V  (min =  +3.93 V, max =  +3.93 V)   ALARM
-5V:      -13.64 V  (min =  +4.03 V, max =  +4.03 V)   ALARM
Stdby:     +4.54 V  (min =  +6.85 V, max =  +6.85 V)   ALARM
VBat:      +2.86 V
fan1:     3125 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min =    0 RPM, div = 2)
fan3:        0 RPM  (min =    0 RPM, div = 2)
M/B Temp:    +33°C  (low  =    -1°C, high =    -1°C)   sensor = diode
CPU Temp:    +38°C  (low  =    -1°C, high =    -1°C)   sensor = thermistor
Temp3:       +25°C  (low  =    -1°C, high =    -1°C)   sensor = thermistor
==================================

It doesn't appear to line up at all.

Can someone please tell me what I need to do to get sensors working
on this motherboard?

Thanks,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
