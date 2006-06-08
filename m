From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Jun 2006 06:28:01 +0000
Subject: [lm-sensors] IT8712F-A and ECS-RX480A mainboard has erradic CPU
Message-Id: <20060608082801.c9175799.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1149735649.31297.3.camel@rapsure.rapsure.net>
In-Reply-To: <1149735649.31297.3.camel@rapsure.rapsure.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

> I can't get the cpu temp to read correctly on my ECS-RX480A mainboard.
> The CPU temperature works correctly in the BIOS screen, but I have been
> unable to get it to work with lm_sensors regardless of whether I set the
> sensor type to a 2, or 3. Currently I have one temperature sensor
> reading correctly, and that is the case temperature. For now I've
> disabled the other two temperature sensors.
> 
> The output of sensors:
> 
> it8712-isa-0228
> Adapter: ISA adapter
> VCore 1:   +1.34 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
> VCore 2:   +1.15 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
> +3.3V:     +5.15 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
> +5V:       +5.51 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> +12V:     +11.90 V  (min = +11.39 V, max = +12.61 V)
> -12V:      -4.90 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       -8.86 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
> Stdby:     +4.97 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.22 V
> fan1:     3183 RPM  (min =    0 RPM, div = 8)
> fan2:     1205 RPM  (min = 3013 RPM, div = 8)          ALARM
> fan3:     1962 RPM  (min = 3013 RPM, div = 8)          ALARM
> M/B Temp:    +39?C  (low  =   +15?C, high =   +40?C)   sensor = thermistor   ALARM
> CPU Temp:     +1?C  (low  =   +15?C, high =   +70?C)   sensor = disabled
> CPU Temp:     -8?C  (low  =   +15?C, high =   +70?C)   sensor = disabled
> vid:       +1.55 V

What temperatures were you seeing before disabling temp2 and temp3?

What temperatures does the BIOS report?

Could be that you have an additional temperature sensor chip for the
CPU temperature. Please provide the full output of sensors-detect on
this machine.

BTW, most of the values reported by the IT8712F chip above are out of
range. You should tweak your configuration file to fit your system. For
example, for fans, you could add the following lines:

   set fan1_div     4
   set fan1_min  2400
   set fan2_min   800
   set fan3_min  1400

After running "sensors -s" then "sensors" again, you should no more
have alarms for fans.

For the voltages it's a bit more tricky, you could compare with what
your BIOS says and try to obtain the same in sensors by changing the
labels and compute lines.

-- 
Jean Delvare

