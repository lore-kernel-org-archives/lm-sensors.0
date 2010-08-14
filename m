From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Aug 2010 19:36:38 +0000
Subject: Re: [lm-sensors] W83667HG-B testing
Message-Id: <20100814213638.31719844@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C42ED6C.9030903@preclik.de>
In-Reply-To: <4C42ED6C.9030903@preclik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Tobias,

On Tue, 20 Jul 2010 23:26:04 +0200, Tobias Preclik wrote:
> On Sun, Jul 18, 2010 at 08:02:52AM -0400, Tobias Preclik wrote:
> > # sensors
> > w83667hg-isa-0a10
> > Adapter: ISA adapter
> > in0:         +0.98 V  (min =  +0.00 V, max =  +1.74 V)  
> > in1:         +1.11 V  (min =  +0.10 V, max =  +0.20 V)   ALARM
> > in2:         +3.36 V  (min =  +3.95 V, max =  +3.28 V)   ALARM
> > in3:         +3.36 V  (min =  +1.57 V, max =  +2.10 V)   ALARM
> > in4:         +1.10 V  (min =  +1.74 V, max =  +1.87 V)   ALARM
> > in5:         +1.18 V  (min =  +1.02 V, max =  +1.30 V)  
> > in7:         +3.28 V  (min =  +3.23 V, max =  +2.62 V)   ALARM
> > in8:         +3.34 V  (min =  +3.18 V, max =  +0.05 V)   ALARM
> > fan1:          0 RPM  (min = 3515 RPM, div = 128)  ALARM
> > fan2:       1022 RPM  (min = 1638 RPM, div = 8)  ALARM
> > fan3:          0 RPM  (min =  958 RPM, div = 128)  ALARM
> > fan4:          0 RPM  (min = 10546 RPM, div = 128)  ALARM
> > fan5:          0 RPM  (min = 3515 RPM, div = 128)  ALARM
> > temp1:       +30.0°C  (high = -56.0°C, hyst = -17.0°C)  ALARM  sensor > > thermistor
> > temp2:       +41.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> > temp3:        -3.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
> > cpu0_vid:   +0.000 V
> 
> These are all PC Health informations I could find in the BIOS:
> 
> CPU Temp = 49°C
> CPUFAN = 1692 RPM
> Vcore = 1.232V
> 3VCC = 3.360V
> VTT 1.1V = 1.120V
> PCH Voltage = 1.096V
> IGD Voltage = toggles between 1.176V and 1.184V
> VSB = 3.280V
> VBAT = 3.344V
> 
> The voltages are rather hard to match aren't they?

Not at all. in1 is VTT 1.1V (+1.11 V vs 1.120V). in2 and in3 are 3VCC
(+3.36 V vs 3.360V, hardwired so can't be wrong.) in4 is PCH Voltage
(+1.10 V vs 1.096V). in5 is IGD Voltage (+1.18 V vs 1.176V/1.184V). in7
and in8 are VSB and VBAT respectively (values match perfectly and they
are internally wired too.)

The remaining pair is in0 for Vcore. The different value can be
explained by your BIOS running the CPU at its max frequency while Linux
runs it as a lower frequency (and voltage is scaled down at lower
frequencies.) This also explains the different CPU temperature (most
probably temp2) and fan speed (fan2), assuming there is some form of
automatic fan speed control in place.

The BIOS doesn't show any value which Linux doesn't, so I'd say we are
fine. And you can use the following as your configuration file:

chip "w83667hg-isa-0a10"

   # Voltages

   label  in0 "Vcore"
   label  in1 "Vtt"
   label  in2 "AVCC"
   label  in3 "+3.3V"
   label  in4 "PCH"
   label  in5 "IGD"
   label  in7 "3VSB"
   label  in8 "Vbat"

   set in1_min  1.1 * 0.95
   set in1_max  1.1 * 1.05
   set in2_min  3.3 * 0.90
   set in2_max  3.3 * 1.10
   set in3_min  3.3 * 0.90
   set in3_max  3.3 * 1.10
   set in4_min  1.1 * 0.95
   set in4_max  1.1 * 1.05
   set in7_min  3.3 * 0.90
   set in7_max  3.3 * 1.10
   set in8_min  3.0 * 0.90
   set in8_max  3.0 * 1.10

   # Fans

   ignore fan1
   label  fan2 "CPU Fan"
   ignore fan3
   ignore fan4
   ignore fan5

   set fan2_min  800

   # Temperatures

   label  temp1 "M/B Temp"
   label  temp2 "CPU Temp"
   ignore temp3

   set temp1_max       55
   set temp1_max_hyst  52

I'll add it to the wiki now for reference.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
