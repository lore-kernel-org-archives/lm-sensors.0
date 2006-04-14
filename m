From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 14 Apr 2006 06:24:24 +0000
Subject: [lm-sensors] many wrong values from w83627hf since kernel 2.6.14
Message-Id: <20060414082424.c675a976.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060413004532.GA4802@spiegl.de>
In-Reply-To: <20060413004532.GA4802@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andy,

> Up to kernel 2.6.13.4 the sensor readings were perfectly okay,
> but ever since I upgraded the kernel there were many wrong values.
> 
> Right now I am running Debian/Unstable with kernel 2.6.16.4
> and lm-sensors 1:2.10.0-4 on an ASUS P4C800 board.

2.6.14 is when we made the chip reset optional in the w83627hf driver.
This would explain why you have different results since this version.

You may try to load the w83627hf driver with option reset=1, this
should bring you back to the results you had before. This can't be
considered a permanent fix though, as the reset parameter is more or
less planned for removal.

> sensors 
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.60 V  (min =  +0.69 V, max =  +0.77 V)       ALARM  
> +12V:     +11.98 V  (min = +10.82 V, max = +13.19 V)              
> +3.3V:     +3.28 V  (min =  +3.14 V, max =  +3.47 V)              
> +5V:       +4.99 V  (min =  +4.75 V, max =  +5.25 V)              
> -12V:      +2.94 V  (min = -13.18 V, max = -10.80 V)       ALARM  
> V5SB:      +5.08 V  (min =  +4.76 V, max =  +5.24 V)              
> VBat:      +2.10 V  (min =  +2.40 V, max =  +3.60 V)       ALARM  
> fan1:        0 RPM  (min = 3515 RPM, div = 128)              ALARM  
> CPU Fan:  2235 RPM  (min = 84375 RPM, div = 4)              ALARM  
> fan3:     1885 RPM  (min =   -1 RPM, div = 4)              ALARM  
> M/B Temp:    +36?C  (high =   -96?C, hyst =    +0?C)   sensor = thermistor   ALARM   
> CPU Temp:  +35.0?C  (high =   +80?C, hyst =   +75?C)   sensor = diode           
> temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor           
> vid:      +0.725 V  (VRM Version 9.0)
> alarms:   
> beep_enable:
>           Sound alarm enabled

Assuming that this is the 2.6.14+ output, which you consider bad, could
you provide your output for an earlier kernel where you were happy with
the results?

You should be able to obtain the same results without the reset, by
adding some statements in /etc/sensors.conf and running "sensors -s".

For example, the temperature alarm is caused by uninitialized limits,
and could be fixed by adding the following lines to sensors.conf
(section w83627thf-*):
    set temp1_over 50
    set temp1_hyst 45
Run "sensors -s" afterwards to actually write the changes to the chip
registers.

BTW, what is your CPU? Is it overclocked? Please provide the output of
"cat /proc/cpuinfo". You should make sure that you have no more "set
vrm" line active in your sensors.conf file, as this is autodetected by
the kernel since 2.6.16.

-- 
Jean Delvare

