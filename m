From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 30 May 2006 19:54:40 +0000
Subject: [lm-sensors] how accurate?
Message-Id: <447CA300.60209@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <447ABAC1.3080706@donehue.net>
In-Reply-To: <447ABAC1.3080706@donehue.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew wrote:
> Hi All,
> 
> I have a server (remote, 300kms away) that crash on me yesterday... 
> Anyhow, I upgraded it to a 2.6 kernel after it came back up, and 
> installed lm-sensors.  

Good. Most likely overheat.

> Sensors-detect found the following modules to install:
> i2c-piix4
> w83781d
> eeprom
> 
> 
> I have used sensors on about 15 other machines so far, and the results 
> always seemed to be accurate.  Is there a chance that the temps could be 
> wrong? (I haven't used this module before). The machine is reasonably 
> old, so I would not be surprised if the fans were broken...

Well there is always a chance...

Do you know the motherboard manufacturer? maybe we can compare with some 
database of motherboards to see which thermal lines means what.

Maybe you can try dmidecode utility which should tell you the manuf name.

> w83782d-i2c-0-29
> Adapter: SMBus PIIX4 adapter at 0580
> VCore 1:   +1.50 V  (min =  +0.00 V, max =  +4.08 V)
> VCore 2:   +1.25 V  (min =  +0.00 V, max =  +4.08 V)
> +3.3V:     +3.31 V  (min =  +2.82 V, max =  +3.79 V)
> +5V:       +5.08 V  (min =  +4.52 V, max =  +4.30 V)       ALARM
> +12V:     +11.86 V  (min =  +0.06 V, max =  +0.00 V)       ALARM
> -12V:      -1.01 V  (min =  -9.65 V, max = -12.28 V)       ALARM
> -5V:       +2.59 V  (min =  +0.33 V, max =  -0.93 V)       ALARM
> V5SB:      +5.08 V  (min =  +0.86 V, max =  +3.44 V)       ALARM
> VBat:      +1.04 V  (min =  +0.03 V, max =  +0.02 V)       ALARM
> fan1:        0 RPM  (min = 21093 RPM, div = 2)              ALARM
> fan2:        0 RPM  (min = 16071 RPM, div = 2)              ALARM
> fan3:        0 RPM  (min = 75000 RPM, div = 2)              ALARM

Try changing fan divisor to 4 or 8 if the fan really spins. (but slowly)

> temp1:       +77 C  (high =    +0 C, hyst =    +4 C)   sensor = 
> thermistor   ALARM

Thermistor...  Quite hot down the CPU socket...

> temp2:     +64.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor
> temp3:     +64.0 C  (high =   +80 C, hyst =   +75 C)   sensor = thermistor

64 quite hot inside.

You may try to change the temp inputs to diode to see if there some more 
reasonable temps...

Suggested steps: change the fan divisor (check fanX_div stuff in sensors conf) 
to see if the fans still reads 0
if so maybe someone should check the fan if it is stuck or not + PSU fan.

then you might try to change the sensor type to diode... (set senors stuff)

Best would be to know the motherboard manufacturer/type so we might know what 
sensors is what...

Regards
Rudolf

