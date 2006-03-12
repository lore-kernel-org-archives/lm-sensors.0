From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Mar 2006 16:40:17 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060312174017.0085920e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,

> Configuring a barebone (Aopen MZ915-M) I tried the sensors stuff.
> After running sensors-detect this is what sensors reports:
> 
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.36 V  (min =  +1.94 V, max =  +1.94 V)       ALARM
> +12V:     +12.28 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +3.18 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.93 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -12.11 V  (min = -13.18 V, max = -10.80 V)
> V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.10 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min =  664 RPM, div = 8)              ALARM
> CPU Fan:     0 RPM  (min =  664 RPM, div = 8)              ALARM
> fan3:        0 RPM  (min =  664 RPM, div = 8)              ALARM
> M/B Temp:     +7 C  (high =   +45 C, hyst =  +101 C)   sensor = diode
> CPU Temp:   -5.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> temp3:      +7.5 C  (high =   +80 C, hyst =   +75 C)   sensor = diode           (beep)
> alarms:
> beep_enable:
>           Sound alarm enabled
> 
> 
> Esp. CPU fan, M/B and CPU temperature look unreasonable. If I reboot
> and look into the bios, then it says the fan is at 3150 rpm, CPU temp.
> is 53C, and sys temperature is 49C. There is no second fan.
> 
> Below you can find the output of sensors-detect after manually
> unloading the sensor modules. Any help would be highly appreciated.

I've replied to you on the LKML already:
http://lkml.org/lkml/2006/3/8/52

-- 
Jean Delvare

