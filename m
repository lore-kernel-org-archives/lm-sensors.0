From: Walt H <walt_h@lorettotel.net>
Date: Wed, 20 Jun 2007 23:28:49 +0000
Subject: Re: [lm-sensors] initial fintek f71882fg driver, test please
Message-Id: <4679B831.90801@lorettotel.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4676A4D8.5020706@hhs.nl>
In-Reply-To: <4676A4D8.5020706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Goede, J.W.R. de wrote:
> Thanks for the feedback, on what motherboard did you test?
> I doubt that vcore 1 is high because vcore usually is
> connected without a divider, also since if there is a
> scaling problem, its almost aways a missing divider, not a
> multiply,  I would expect vcore to be to low, not to high.
>
> Regards,
>
> Hans
>
>
> p.s. Did you try this with the libsensors 3 branch? I would
> be much oblidged you could, then run sensors and update
> sensors.conf until things look good and last send the
> working snesors.conf to te list.
>
> Regards,
>
> Hans
>
>
>   
This was tested on an MSI P965 Platinum MB.  I installed the svn 
checkout of libsensors3 and copied the section from the f71805 to modify 
for this chip.  The set statements for the chip fail, so I'm not able to 
set hysteresis or critical values on temperatures yet.  Also, on my MB, 
the BIOS hardware monitor only shows the CPU Vcore, +5 VSB, +5, +12, NB 
and DRAM voltage, so I can't vouch for the other inputs.  The comments 
from the f71805 indicate that in0 (+3.3) should be internally scaled and 
need no adjustment, however, if that input is correct it appears to be 
scaled in half by default, so I multiplied it by 2.  The output from a 
sensors command looks like this:

f71882fg-isa-0a10
Adapter: ISA adapter
+3.3V:           +3.31 V
Vtt1.2V:         +1.14 V
Vram:            +1.98 V
Vchip:           +3.00 V
+5V:             +5.00 V
+12V:           +12.23 V
Vcc1.5V:         +1.26 V
Vcore:           +1.66 V
5VSB:            +5.03 V
CPU Fan:        1400 RPM
Sys Fan:        1466 RPM
CPU Temp:        +39.0 C  (high = +85.0 C, hyst =  +4.0 C)  sensor = 
transistor
temp1_crit:     +100.0 C  (hyst =  +4.0 C)
Sys Temp:        +35.0 C  (high = +85.0 C, hyst =  +4.0 C)  sensor = 
transistor
temp2_crit:     +100.0 C  (hyst =  +4.0 C)

The values I can check against the HW monitor in the bios are pretty 
close.  The bios measured:
1.3~ on CPU Vcore
5.045 on +5VSB
5.003 on +5
12.232 on +12
1.26 on NB
2.00 on DRAM

The relevant section of the sensors.conf for the chip are:


chip "f71882fg-*"
# Voltages
   label in0 "+3.3V"
   label in1 "Vtt1.2V"
   label in2 "Vram"
   label in3 "Vchip"
   label in4 "+5V"
   label in5 "+12V"
   label in6 "Vcc1.5V"
   label in7 "Vcore"
   label in8 "5VSB"

   # in0 is scaled internally
   compute in0  @*2, @*2
   compute in2  @*(1+100/100), @/(1+100/100)
   compute in3  @*(1+100/47),  @/(1+100/47)
   compute in4  @*(1+200/47),  @/(1+200/47)
   compute in5  @*(1+200/20),  @/(1+200/20)
   compute in8  @*(1+100/46),  @/(1+100/46)

   # in0 is the chip's own VCC.
   #set in0_min  3.0
   #set in0_max  3.6

   #set in1_min  1.2 * 0.95
   #set in1_max  1.2 * 1.05
   #set in2_min  2.5 * 0.95
   #set in2_max  2.6 * 1.05
   #set in3_min  3.3 * 0.95
   #set in3_max  3.3 * 1.05
   #set in4_min  5.0 * 0.95
   #set in4_max  5.0 * 1.05
   #set in5_min 12.0 * 0.95
   #set in5_max 12.0 * 1.05
   #set in6_min  1.5 * 0.95
   #set in6_max  1.5 * 1.05
   # in7 nominal value depends on the CPU model
   #set in7_min  1.4 * 0.95
   #set in7_max  1.4 * 1.05
   #set in8_min  5.0 * 0.95
   #set in8_max  5.0 * 1.05

# Fans
   label fan1 "CPU Fan"
   label fan2 "Sys Fan"
   label fan3 "Aux Fan"

   #set fan1_min 2100
   #set fan2_min 1400
   #set fan3_min 1400
   ignore fan3
   ignore fan4

# Temperatures
   label temp1 "CPU Temp"
   label temp2 "Sys Temp"
   label temp3 "Aux Temp"

   set temp1_max   60
   set temp1_max_hyst  58
   set temp2_max   50
   set temp2_max_hyst  48
   ignore temp3
   #set temp3_max   50
   #set temp3_hyst  48


Also, not sure about this driver, although it's probably similar, I 
needed to disable pnpacpi in order to detect the chip with the first rev 
from Hans Edgington.  Seems the pnpacpi driver claims the I/O ports 
first and blocked the driver from accessing it.  I'm running this on a 
Core2 Duo E6600 compiled for x86_64, so I used pnpacpi=off as a boot 
line parm.

Hope this helps,

-Walt



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
