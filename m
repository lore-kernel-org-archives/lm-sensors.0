From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: [Fwd: i850 && lm_sensors]
Message-Id: <20030720112530.43c44d6a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F16EFDB.4040504@edgedesign.us>
In-Reply-To: <3F16EFDB.4040504@edgedesign.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > get our new 2.8.0 release and try again to run sensors-detect.
> > If it doesn't work email us the output of 'lspci -n'.
> 
> I tried it before. It doesn't work.
> (...)
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `Serial EEPROM' (confidence: 8)
>   * Bus `SMBus I801 adapter at efa0' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x51
>     Chip `Serial EEPROM' (confidence: 8)
> 
> only eeprom, no fan speed, etc ...

This at least shows your bus driver is working. What is missing is a
chip driver. Please send us the output of "i2cdetect 0". A complete log
of sensors-detect's output would help too.

You may simply have no sensor chip on your motherboard (or at least not
one we see on the I2C bus).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
