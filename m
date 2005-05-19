From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Please analyse output
Message-Id: <B9FA5C69.447D%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F99D36.445B%zdavatz@ywesee.com>
In-Reply-To: <B9F99D36.445B%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 14.11.2002 19:04 Uhr, "Jean Delvare" <khali@linux-fr.org> wrote:

> VCore 1/2 min/max are obviously wrong.
> +3.3V is also probably wrong.
How can I correct this?

> +5V and +12V make sense.
> -12V and -5V are obviously wrong, but IIRC nobody cared about these
> values anymore.
> V5SB and VBat look good.
Ok.
>> fan1:        0 RPM  (min = 3000 RPM, div = 2)
>> fan2:        0 RPM  (min = 3000 RPM, div = 2)
>> fan3:        0 RPM  (min = 3000 RPM, div = 2)

> Do you have any fan on your system?
> Do they have the ability to report
> their speed? If you don't have any fan that can report its speed, you
> may prevent them from apearing here by editing /etc/sensors.conf
I do have a fan. How can I finde out if it can report speed?

>> temp1:       -48__C  (limit =  +60__C)                       sensor >> thermistor      
>> temp2:     +45.0__C  (limit =  +60__C, hysteresis =  +50__C) sensor >> thermistor      
>> temp3:     +43.5__C  (limit =  +60__C, hysteresis =  +50__C) sensor >> thermistor      
> 
> temp1 is of course wrong, temp2 and temp3 make sense.
What would temp1 be for?

>> vid:      +1.450 V
> 
> Obviously correct, which makes me wonder why VCore1/2 min/max are wrong.
What is the relationship between the two?

>> eeprom-i2c-0-50
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
>> 
>> eeprom-i2c-0-51
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
>> 
>> eeprom-i2c-0-54
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
>> 
>> eeprom-i2c-0-55
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
>> 
>> eeprom-i2c-0-56
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
>> 
>> eeprom-i2c-0-57
>> Adapter: SMBus PIIX4 adapter at e800
>> Algorithm: Non-I2C SMBus adapter
> 
> This is much more intriguing.
> 
> What is your system? (motherboard or laptop model)
Debian with a customised 2.4.19 Kernel. Dual Prozessor PIII, 1,2 Ghz with
ASUS TR-DLS motherboard. 4 GB Ram, Software Raid 80 GB.

> What did sensors-detect detect and what modules did it suggest you
> should load?
Shall I run sensors detect again?

> I would like you to do some tests for us if you have some time left.
> Thanks.
Of course, no problem. Just tell me what I should do.

Thanks for your help and time.

Zeno
