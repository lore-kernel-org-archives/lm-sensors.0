From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3 i2c it87 sensor support
Message-Id: <20040225232118.6f0ab8f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <CBF4B814-67DF-11D8-89D2-000393034272@polytechnique.org>
In-Reply-To: <CBF4B814-67DF-11D8-89D2-000393034272@polytechnique.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi I have a motherboard wich uses an it87. My problem is that the 
> latest linux kernel (2.6.3) includes a driver for this chip, but that 
> driver is older than the one included in latest lm_sensors : in
> effect, it lacks support for it87_reset, which is implemented in
> latest lm_sensors and which is really usefull. It also lacks
> FanGuardian (aka SmartFan), which is also really usefull, and already
> implemented in lm_sensors 2.8.4.
> 
> I ABSOLUTELY needed to be able to boot without reseting the it87, so
> I manually patched the vanilla kernel (I simply removed the
> corresponding line), but the SmartGuardian feature still isn't there.

Takeru Komoriya is working on porting the changes from our CVS
repository to Linux 2.6. Temperature sensor types setting is already
done [1], reset is in good shape but need some rework, and we'll work on
the Guardian thing right after that. With a bit of luck, we should equal
the level of functionality of the CVS driver as soon as in Linux 2.6.4.

> Anyway; thanks for such an awesome project

Thanks :)

[1] http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.2-rc2-i2c-it87-sensor-type.diff

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
