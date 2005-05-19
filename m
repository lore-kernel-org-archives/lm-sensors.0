From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Ticket 1288
Message-Id: <20030814214215.42423773.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2147483647.1056216687@abrmsn288.med.upenn.edu>
In-Reply-To: <2147483647.1056216687@abrmsn288.med.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, I've installed 2.8.0, which auto-detects the sensor, but still
> seems to have problems with the temp:
> (snip)
> eeprom-i2c-0-51
> Adapter: SMBus AMD75x adapter at 06e0
> Algorithm: Non-I2C SMBus adapter
> Machine name:
> H
> Serial number:
> H

Don't you care about these ones, it's a known bug (my fault) and fixed
in CVS.

> (snip)
> temp1:       +25C  (limit =  +60C)                       sensor > thermistor temp2:     +58.5C  (limit =  +60C, hysteresis =  +50C)
> sensor = PII/Celeron diode   ALARM
> temp3:     +60.0C  (limit =  +60C, hysteresis =  +50C) sensor > PII/Celeron diode   ALARM

I can see in the configuration file that the sensor types can be
changed. Maybe the default configuration doesn't match your hardware.
Did you try changing these values in the config file (section
w83627hf-*, uncomment the lines), maybe it would give interesting
results?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
