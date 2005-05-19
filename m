From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <20030803151844.1260a5aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> [root@coyote root]# lsmod.old
> WARNING: lsmod.old: I am not the old version!
> Module                  Size  Used by
> qcamvc_usb              4252  0 (autoclean) (unused)
> qcamvc                 13528  0 [qcamvc_usb]
> videodev                6208  1 (autoclean) [qcamvc]
> nvidia               1624576  11 (autoclean)
> via8233                 8800  2
> pnp                    49620  2 [via8233]
> ac97                   16384  2 [via8233]
> soundbase             567520  2 [via8233 pnp ac97]
> sndshield              10636  0 [via8233 pnp ac97 soundbase]
> eeprom                  3508  0
> adm1021                 5624  0 (unused)
> i2c-viapro              3760  0 (unused)
> w83781d                19312  0
> i2c-proc                6992  0 [eeprom adm1021 w83781d]
> i2c-isa                 1096  0 (unused)
> i2c-core               14472  0 [eeprom adm1021 i2c-viapro w83781d 
> i2c-proc i2c-isa]

It seems that the adm1021 module isn't used, so you may not load it.

> And thats with thermaltake's best all copper big fan cooler on it.  
> Sensors currently says:
> [root@coyote root]# sensors
> w83697hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore:     +1.66 V  (min =  +0.00 V, max =  +0.00 V)

You need to set valid limits in the config file for that
(/etc/sensors.conf, section w83697hf-*).

> +3.3V:     +3.26 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +4.99 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +12.39 V  (min = +10.79 V, max = +13.11 V)
> -12V:     -12.39 V  (min = -13.21 V, max = -10.90 V)
> -5V:       -5.36 V  (min =  -5.51 V, max =  -4.51 V)
> V5SB:      +5.44 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.21 V  (min =  +2.70 V, max =  +3.29 V)

Voltages are correct, except V5SB which is a bit high.

> fan1:     5273 RPM  (min =  187 RPM, div = 32)
> fan2:        0 RPM  (min =  187 RPM, div = 32)

Div 32 is very unusual, you'll probably have better precision using
lower values (4 or 2 should be OK).

> temp1:       +69?C  (limit =  +60?C)                       sensor = 
> thermistor   ALARM
> temp2:    +208.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 
> thermistor

Temp1 is damn too hot, you *do* have a cooling problem.

> There is no temp2 thermistor on this board.

I'd have guessed (your computer would be on fire).


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
