From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Epox 8RDA+: Unknown EEPROM type (101)
Message-Id: <20031103222433.5ce2cb32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <32819.192.168.0.4.1067821063.squirrel@www.gsmlandia.com>
In-Reply-To: <32819.192.168.0.4.1067821063.squirrel@www.gsmlandia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> When runing the sensors binary I get the message:
> # /usr/local/bin/sensors
> eeprom-i2c-0-50
> Adapter: SMBus nForce2 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (101)
> (...)
> What is the problem. Whay Can I do?

This simply means that you have memory chips of a new kind, that we
don't support yet. What kind of memory modules do you have on that
machine? According to the data sheet, it is regular DDR-SDRAM, so it's
strange it isn't supported (it is supposed to be, but is known to have a
different type value).

Anyway, the eeprom modules only provides information about your memory -
mainly the memory size. This isn't very interesting. That module is
interesting for us developers because it's a simple one, but it has no
real interest for the users.

However, if you want us to support your memory chips, please send us the
output of the folowwing command (after removing the eeprom module):

i2cdump 0 0x50 b

And we'll see what we can do. Also, please let us know the size of the
memory chip.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
