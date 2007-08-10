From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Fri, 10 Aug 2007 22:39:37 +0000
Subject: Re: [lm-sensors] 2.6.23-rc1 regression: hwmon/w83627ehf: wrong fan
Message-Id: <46BCE929.5070902@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B5B290.4040907@s5r6.in-berlin.de>	<20070805162141.GI6221@jupiter.solarsys.private>	<46B6053E.2050708@s5r6.in-berlin.de> <20070810230831.59cbc50f@hyperion.delvare> <46BCE6D0.7060300@s5r6.in-berlin.de>
In-Reply-To: <46BCE6D0.7060300@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

I wrote:
> # sensors
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +0.95 V  (min =  +0.00 V, max =  +1.74 V)
> in1:      +12.30 V  (min =  +1.64 V, max =  +3.22 V) ALARM
> AVCC:      +3.28 V  (min =  +1.89 V, max =  +1.94 V) ALARM
> 3VCC:      +3.26 V  (min =  +0.18 V, max =  +0.72 V) ALARM
> in4:       +1.58 V  (min =  +0.57 V, max =  +0.90 V) ALARM
> in5:       +1.70 V  (min =  +0.41 V, max =  +1.19 V) ALARM
> in6:       +3.43 V  (min =  +0.31 V, max =  +3.05 V) ALARM
> VSB:       +3.25 V  (min =  +0.37 V, max =  +3.01 V) ALARM
> VBAT:      +3.18 V  (min =  +3.94 V, max =  +0.74 V) ALARM
> in9:       +1.88 V  (min =  +0.79 V, max =  +1.40 V) ALARM
> Case Fan:    0 RPM  (min =  753 RPM, div = 128) ALARM
> CPU Fan:    88 RPM  (min =  659 RPM, div = 64) ALARM
> Aux Fan:     0 RPM  (min = 10546 RPM, div = 128) ALARM
> fan5:        0 RPM  (min =  753 RPM, div = 128) ALARM
> Sys Temp:    +44 C  (high =    -5 C, hyst =   -34 C)   ALARM
> CPU Temp:  +38.0 C  (high = +80.0 C, hyst = +75.0 C)
> AUX Temp:  +43.5 C  (high = +80.0 C, hyst = +75.0 C)
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> 
> coretemp-isa-0001
> Adapter: ISA adapter
...
> I'll reboot in a minute into 2.6.22(-rc5) and post the "sensors" output.

# sensors
w83627ehf-i2c-9191-290
 ERROR: Can't get adapter or algorithm?!?
VCore:     +0.95 V  (min =  +0.00 V, max =  +1.74 V)
in1:      +12.20 V  (min =  +1.64 V, max =  +3.22 V) ALARM
AVCC:      +3.26 V  (min =  +1.89 V, max =  +1.94 V) ALARM
3VCC:      +3.26 V  (min =  +0.18 V, max =  +0.72 V) ALARM
in4:       +1.58 V  (min =  +0.57 V, max =  +0.90 V) ALARM
in5:       +1.71 V  (min =  +0.41 V, max =  +1.19 V) ALARM
in6:       +3.43 V  (min =  +0.31 V, max =  +3.05 V) ALARM
VSB:       +3.26 V  (min =  +0.37 V, max =  +3.01 V) ALARM
VBAT:      +3.18 V  (min =  +3.94 V, max =  +0.74 V) ALARM
in9:       +1.88 V  (min =  +0.79 V, max =  +1.40 V) ALARM
Case Fan:  484 RPM  (min = 84375 RPM, div = 16) ALARM
CPU Fan:  1424 RPM  (min = 21093 RPM, div = 4) ALARM
Aux Fan:     0 RPM  (min = 10546 RPM, div = 128) ALARM
fan5:        0 RPM  (min = 10546 RPM, div = 128) ALARM
Sys Temp:    +45 C  (high =    -5 C, hyst =   -34 C)   ALARM
CPU Temp:  +39.5 C  (high = +80.0 C, hyst = +75.0 C)
AUX Temp:  +44.5 C  (high = +80.0 C, hyst = +75.0 C)

coretemp-isa-0000
Adapter: ISA adapter

coretemp-isa-0001
Adapter: ISA adapter

-- 
Stefan Richter
-===-=-== =--- -=-=
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
