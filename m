From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Please analyse output
Message-Id: <20021114190412.758fb9fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F99D36.445B%zdavatz@ywesee.com>
In-Reply-To: <B9F99D36.445B%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok, my sensors are up and running or at least some of them. Can you
> tell me what the output means after the data:
> 
> w83782d-i2c-0-28
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.45 V  (min =  +4.08 V, max =  +4.08 V)
> VCore 2:   +2.78 V  (min =  +4.08 V, max =  +4.08 V)
> +3.3V:     +2.80 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +4.94 V  (min =  +4.50 V, max =  +5.48 V)
> +12V:     +11.25 V  (min = +10.79 V, max = +13.11 V)
> -12V:      +0.30 V  (min = -13.21 V, max = -10.90 V)
> -5V:       +1.62 V  (min =  -5.51 V, max =  -4.51 V)
> V5SB:      +4.70 V  (min =  +4.50 V, max =  +5.48 V)
> VBat:      +3.18 V  (min =  +2.70 V, max =  +3.29 V)

VCore 1/2 min/max are obviously wrong.
+3.3V is also probably wrong.
+5V and +12V make sense.
-12V and -5V are obviously wrong, but IIRC nobody cared about these
values anymore.
V5SB and VBat look good.

> fan1:        0 RPM  (min = 3000 RPM, div = 2)
> fan2:        0 RPM  (min = 3000 RPM, div = 2)
> fan3:        0 RPM  (min = 3000 RPM, div = 2)

Do you have any fan on your system? Do they have the ability to report
their speed? If you don't have any fan that can report its speed, you
may prevent them from apearing here by editing /etc/sensors.conf

> temp1:       -48__C  (limit =  +60__C)                       sensor > thermistor         
> temp2:     +45.0__C  (limit =  +60__C, hysteresis =  +50__C) sensor > thermistor         
> temp3:     +43.5__C  (limit =  +60__C, hysteresis =  +50__C) sensor > thermistor         

temp1 is of course wrong, temp2 and temp3 make sense.

> vid:      +1.450 V

Obviously correct, which makes me wonder why VCore1/2 min/max are wrong.

> eeprom-i2c-0-50
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-51
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-54
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-55
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-56
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> 
> eeprom-i2c-0-57
> Adapter: SMBus PIIX4 adapter at e800
> Algorithm: Non-I2C SMBus adapter

This is much more intriguing.

What is your system? (motherboard or laptop model)
What did sensors-detect detect and what modules did it suggest you
should load?

I would like you to do some tests for us if you have some time left.
Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
