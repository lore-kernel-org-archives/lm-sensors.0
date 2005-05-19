From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: 2.4.22 + lm-2.8.1
Message-Id: <20031118022306.GA17276@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FB8B798.6020107@datafast.net.au>
In-Reply-To: <3FB8B798.6020107@datafast.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Tim McCoy <tmccoy@datafast.net.au> [2003-11-17 22:57:12 +1100]:

> Build and install goes fine, but I'm getting nothing interesting out of 
> the sensors themselves... Any suggestions? I'll include the 
> sensors-detect data, but for now, we're wondering what to do. Maybe you 
> can shed some light - is the support ready for this chipset?

Yes, nForce2 SMBus adapter works fine.  The output of sensors-detect
shows that you are successfully scanning this bus.

> sensors-detect results:
> 
> Driver `eeprom' (should be inserted):
>  Detects correctly:
>  * Bus `SMBus nForce2 adapter at 5000' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x51
>    Chip `Serial EEPROM' (confidence: 8)
> 
> Driver `w83781d' (should be inserted):
>  Detects correctly:
>  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x2d (and 0x48 0x49)
>    Chip `Asus AS99127F' (confidence: 8)
> 
> Driver `pcf8591' (may not be inserted):
>  Misdetects:
>  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x48
>    Chip `Philips Semiconductors PCF8591' (confidence: 1)
>  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x49
>    Chip `Philips Semiconductors PCF8591' (confidence: 1)
> 
> Driver `lm75' (may not be inserted):
>  Misdetects:
>  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x49
>    Chip `National Semiconductor LM75' (confidence: 3)
> 
> Driver `ds1621' (may not be inserted):
>  Misdetects:
>  * Bus `SMBus nForce2 adapter at 5500' (Non-I2C SMBus adapter)
>    Busdriver `UNKNOWN', I2C address 0x49
>    Chip `Dallas Semiconductor DS1621' (confidence: 6)
> 
> ------------------------------
> sensors results:
> 
> pcf8591-i2c-1-48
> Adapter: SMBus nForce2 adapter at 5500
> Algorithm: Non-I2C SMBus adapter
> Chan. 0:  255
> Chan. 1:  255
> Chan. 2:  255
> Chan. 3:  255
> Output:   0 (enabled)
> 
> pcf8591-i2c-1-49
> Adapter: SMBus nForce2 adapter at 5500
> Algorithm: Non-I2C SMBus adapter
> Chan. 0:  24
> Chan. 1:  24
> Chan. 2:  24
> Chan. 3:  24
> Output:   0 (enabled)

Oops... you shouldn't load the pcf8591 module.  Unload it (`rmmod pcf8591`)
then load the correct one (`modprobe w83781d`) and you should be all set.
Look at your sensors-detect output again - this is what it suggests.  If
that still doesn't work, reply again to the list...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
