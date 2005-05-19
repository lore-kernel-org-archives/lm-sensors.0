From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031127222437.4a255bc6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I don't know if you received this...

Now we do, but not before, if that was your question.

> I've downloaded i2c and lm-sensors from CVS patched a new "fresh"
> kernel source, compiled it and installed i2c and sensors, after i've
> ran sensors-detect, then rebooted and typed sensors... it worked!

Great :)

> fernando@athlon:~$ sensors
> eeprom-i2c-0-51
> Adapter: SMBus nForce2 adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Unknown EEPROM type (65)

That problem is still there.

Could you please ensure you have the change Mark made, that is supposed
to fix it? In lm_sensors2, type "cvs status
kernel/busses/i2c-nforce2.c". If it says version 1.6, you don't have the
fix. Please do "cvs update", recompile, reinstall and recycle modules
and try again. If it says version 1.7, this means that Mark's fix did
not work.

> root@athlon:~# wich sensors
> -su: wich: command not found
> root@athlon:~# ldd $(wich sensors)
> -su: wich: command not found
> ldd: missing file arguments

This is "which", not "wich" (this is why the commands are failing). But
we don't need that information anymore anyway.

Thanks for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
