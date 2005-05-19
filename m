From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: hi about lm_sensors issue
Message-Id: <20050318215658.1f4b550e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b050315215248daf6e5@mail.gmail.com>
In-Reply-To: <ea9ff50b050315215248daf6e5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Filip,

> problem is in :
> [root@cook rc.d]# sensors
> it8712-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.70 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
> VCore 2:   +2.61 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
> +3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.25 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> +12V:     +11.84 V  (min = +11.39 V, max = +12.61 V)
> -12V:     -15.70 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:       -8.10 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
> Stdby:     +4.65 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> VBat:      +4.08 V
> fan1:     2596 RPM  (min =  664 RPM, div = 8)
> CPU Temp:    +38?C  (low  =   +15?C, high =   +60?C)   sensor = thermistor
> M/B Temp:    +27?C  (low  =   +15?C, high =   +50?C)   sensor = thermistor
> (...)
> [root@cook rc.d]#
> 
> CPU temp is at leasr 55C and that's mostly what I want to monitor and
> voltages but they are not right

How do you know that "CPU temp is at least 55 degrees C"? 38 degrees C
is possible if the CPU is idle and has an efficient fan.

For voltages, you need to adjust some lines in sensors.conf:

    label in1 "Vram"
    label in5 "Vagp"

    compute in3 2*@ ,  @/2
    compute in5 @, @ # or remove the line altogether
    compute in7 2*@ ,  @/2

    set in0_min 1.7 * 0.95
    set in0_max 1.7 * 1.05
    set in1_min 2.6 * 0.95
    set in1_max 2.6 * 1.05
    set in5_max 1.5 * 0.95
    set in5_min 1.5 * 1.05

That should give you much better results. Don't forget to run "sensors
-s" after you edited the configuration file. Also make sure you edit the
it8712-* section.

You can also comment out the "ignore  vid" line, and use vid to set
in0_min/max.

-- 
Jean Delvare
