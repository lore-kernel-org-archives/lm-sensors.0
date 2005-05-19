From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: sensors gives no useful output.
Message-Id: <20030806190354.78b9903a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806183452.4755ebf8.zdavatz@ywesee.com>
In-Reply-To: <20030806183452.4755ebf8.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> ok, done that. And followed the instructions of the 'sensors-detect'
> output. I did not ad the lines to /etc/rc.* as the lm75 and eeprom are
> already loaded at bootup.

Yes, I think I remember that.

> My sensors output now is:
> lm75-i2c-0-48
> Adapter: uni-n 0
> Algorithm: Keywest i2c
> temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)
> 
> lm75-i2c-0-49
> Adapter: uni-n 0
> Algorithm: Keywest i2c
> temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)
> 
> eeprom-i2c-0-50
> Adapter: uni-n 0
> Algorithm: Keywest i2c
> 
> lm75-i2c-1-48
> Adapter: uni-n 1
> Algorithm: Keywest i2c
> temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)
> 
> lm75-i2c-1-49
> Adapter: uni-n 1
> Algorithm: Keywest i2c
> temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)
> 
> eeprom-i2c-1-50
> Adapter: uni-n 1
> Algorithm: Keywest i2c
> 
> eeprom-i2c-2-56
> Adapter: mac-io 0
> Algorithm: Keywest i2c
> Machine name:
> Serial number:
> 
> Any hints to get some useful output?

Unfortunately, it seems that all these chips are awfully misdetected.
You probably don't have any LM75 chip on your system, and the eeproms
are of an unknown type. Since we skipped the compilation of the dump
tools in order to be able to install lm_sensors, there's almost nothing
we can do now :(

If we ever can figure out why these tools wouldn't compile correctly on
PPC, we'll let you know.

Sorry I can't help you more :/



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
