From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031011184042.15c9b951.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> One question.  If I do NOT insert the lm90 driver, but decide to use
> adm1021 (gulp), do I still need to ignore ports 0x4c and 0x4e?  I
> would imagine I would ignore 0x18 and 0x4e since lm90 appears to be at
> 0x4c. Maybe I'll back up again and try.....

Each driver will try to grab every address it knows about, and will
succeed if the device at that address meets some conditions (which of
course depend of the devices the driver is supposed to handle). So, if
the lm90 driver isn't loaded, the device at 0x4c is free, and the
adm1021 driver will try to get all three devices (0x18, 0x4c and 0x4e)
unless you explicitely prevent it to do so. In your case, and if you are
willing to try that, I would prevent it to access the devices at 0x18
and 0x4e, and would let it handle the device at 0x4c. I think it will
work (although you'll miss some features from the lm90 driver, such as
critical temperatures, hysteresis and extra accuracy). That said, and as
I know your system... backup first ;)

> I'll keep you informed.  Thanks again!

Thanks. I hope your daughter had a good time for the tournament :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
