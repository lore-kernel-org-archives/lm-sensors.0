From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: Controll CPU Cooler on MSI-NEO 2 Board
Message-Id: <42787A03.9050506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42772B44.8090204@jonasstein.de>
In-Reply-To: <42772B44.8090204@jonasstein.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>and full output of sensors command.
> 
> # sensors
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.42 V  (min =  +0.94 V, max =  +0.96 V)
> +12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)
> +3.3V:     +0.64 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +5.01 V  (min =  +4.75 V, max =  +5.25 V)
> -12V:     -14.91 V  (min = -10.80 V, max = -13.18 V)
> V5SB:      +5.05 V  (min =  +4.76 V, max =  +5.24 V)
> VBat:      +3.49 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:        0 RPM  (min = 56250 RPM, div = 2)
> CPU Fan:     0 RPM  (min = 37500 RPM, div = 2)
> fan3:        0 RPM  (min = 19285 RPM, div = 2)
> M/B Temp:    +39 C  (high =   +25 C, hyst =    +1 C)   sensor = thermistor
> CPU Temp:  +38.0 C  (high =   +80 C, hyst =   +75 C)   sensor = diode
> temp3:     -48.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> vid:      +0.275 V  (VRM Version 9.0)
> alarms:
> beep_enable:
>           Sound alarm disabled

This reminds me have you tried to change FAN divisors?

(Just edit   w83627thf section of config file and add:

set fan1_div 4
set fan2_div 4
 set fan3_div 4

If you have really slow fans you can try 8 instead.
Dont forget to run sensors -s to "commit the changes"
After that plz try sensors command again.


More info:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section-4_002e1

Regards

Rudolf
