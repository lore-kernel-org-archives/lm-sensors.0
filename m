From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: lm_sensors and wrong values on MSI MS-6704 (845PE Max2 FIR)
Message-Id: <20030823220648.2961879e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F44B811.5010809@iit.demokritos.gr>
In-Reply-To: <3F44B811.5010809@iit.demokritos.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am trying to install support for monitoring cpu temp under
> my redhat 9.0 box, but without much success.
> I have ran sensors-detect, which identified LM80 in my
> system. Everything seems to have been installed fine,
> but the readings I get are:
> 
> lm80-i2c-0-2f
> Adapter: SMBus I801 adapter at 0c00
> Algorithm: Non-I2C SMBus adapter
> +5V:       +6.71 V  (min =  +6.71 V, max =  +6.71 V)   ALARM
> VTT:       +2.55 V  (min =  +2.55 V, max =  +2.55 V)   ALARM
> +3.3V:     +4.43 V  (min =  +4.43 V, max =  +4.43 V)   ALARM
> +Vcore:    +3.76 V  (min =  +3.76 V, max =  +3.76 V)   ALARM
> +12V:     +16.10 V  (min = +16.10 V, max = +16.10 V)   ALARM
> -12V:     -16.11 V  (min = -16.11 V, max = -16.11 V)   ALARM
> -5V:       -6.70 V  (min =  -6.70 V, max =  -6.70 V)   ALARM
> fan1:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> fan2:        0 RPM  (min =    0 RPM, div = 8)          ALARM
> temp:     -1.00 C (hot:limit =  -1C,  hysteresis =  -1C) ALARM
>          (os: limit =  -1C,  hysteresis =  -1C) ALARM
> alarms:   Board temperature input (LM75)               ALARM
> (...)
> These values are constant (I have never seen them change) and of
> course are not in accordance with what I see from my boards
> monitor. By the way, the manifacturer supplied monitor
> supports 2 temps (CPU & system), 3 Fan speeds & voltages.
> Is there a way I can check if sensor_detect has
> made the right decision?

The first thing to do is to find which chipset you really have on your
motherboard. If the values really don't change, I believe to do *not*
really have a LM80. The output of "i2cdetect 0" and "i2cdump 0 0x2f"
would help. Reading your motherboard's manual would help a lot too.

BTW, which version of lm_sensors are you using?

> Can somebody help me to get the correct values in my system?

Maybe you forgot to run "sensors -s". Still I think it won't help if
your chipset isn't a LM80.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
