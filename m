From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 May 2005 14:48:11 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs class
Message-Id: <mffDf43m.1116851987.0503830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

> (...) It would seem to me that basically everything
> under drivers/i2c/chips should be moved into drivers/hwmon

No, not all i2c chip drivers are hardware monitoring monitors. At least
the following should stay in drivers/i2c/chips:
* ds1337
* eeprom
* isp1301_omap (what is this BTW?)
* m41t00
* pcf8574
* pcf8591
* rtc8564

And then there's atxp1, not too sure what to do with this one (it's
meant to overclock systems, not monitor them, but it shares code and
interface with hwmon).

> (...) and perhaps
> drivers/i2c/bus to drivers/i2c (although the latter isn't necessary,
> it just makes sense to me).

I don't this it is a good idea. The current scheme makes it clear which
drivers create i2c busses, which are i2c chip drivers, which are
algorithms and which are core drivers. I wouldn't change that.

Thanks,
--
Jean Delvare
