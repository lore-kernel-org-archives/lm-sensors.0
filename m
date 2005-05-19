From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040203224625.50609b4b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Looks better now, but there are still problems with the fans:
> 
> video:~ # sensors
> fscher-i2c-0-73
> Adapter: SMBus I801 adapter at 2000
> Temp1/CPU:      +52.00 C
> Temp2/MB:       +44.00 C
> Temp3/AUX:      +47.00 C
> ERROR: Can't get FAN1 data!
> ERROR: Can't get FAN2 data!
> ERROR: Can't get FAN3 data!
> +12V:           +11.79 V
> +5V:             +5.05 V
> Battery:         +3.05 V

This is due to the fan_min vs pwm issue. The way it should be fixed
depends on what the driver will do. See my other reply for more.

> BTW: is it intended, that fscher is found at i2c-1-73 after reloading 
> i2c_i801, and at i2c-2-73, ... after reloading it again, ...?

Not really intended, but known. I don't like it much but I think I read
it couldn't be easily fixed. We'll have to cope with that for some times
at least.

> BTW2: your latest diff didn't contain FSCHER's DRIVER_ID.

Correct. It's not in the same directory so I forgot it. Anyway, my goal
was to send the new version of the driver itself as a base for future
changes. It wasn't meant as a definitive version. That said, thanks for
reminding me that the ID needs to be added, so that I will hopefully not
forget about it next time.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
