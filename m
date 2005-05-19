From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: Technical reference - Ali M5879
Message-Id: <20040317211342.24a119fb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c4081b$427e5010$051010ac@tuby>
In-Reply-To: <000c01c4081b$427e5010$051010ac@tuby>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've tried to test your sensors-detect on a Suse 8.2 distribution, but
> I've seen that the i2cdetect file is missing.

No luck :/

> This week I'm very busy on driver development under XP.
> Next week I will install the latest versions of i2c and sensors
> packages and I retry your new detection program.

OK, thanks :)

> By the way, on Suse 8.2 I was not able to detect a Texas Instrument
> BQ2060 smartbattery controller.
> There is a detection of a I2C chip at address 0x0B, but the
> smartbattery detection fails.
> I'll retry this detection too, after upgrading the i2c/sensors
> packages.

The detection code is qualified as "lousy" in the driver. And I can see
that this detection code is mostly different from the one in
sensors-detect. This would need fixing.

Mark, care to take a look?

Stefano, which detection is failing, sensors-detect's or smartbatt's?
You can still try forcing the smartbatt driver to load with force=0,0x0b
(assuming this is on i2c bus 0). This will bypass the detection and
maybe you'll get results.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
