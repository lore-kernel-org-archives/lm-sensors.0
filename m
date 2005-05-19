From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: MotherBoard !!!!
Message-Id: <20030126095635.3a93f3b1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030126001001.1c8b936b.sesshoumaru@altern.org>
In-Reply-To: <20030126001001.1c8b936b.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'd like to know if lm_sensors run on every motherboard type ? 

No, it doesn't.

> Because i have an ASUS A7V-333X for one month and i have some
> problems with lm sensors whereas with the old motherboard i 
> had no problem.

The behaviour of lm_sensors strongly depends on the motherboard because
different motherboards will have different SMBus/I2C busses and
different chipsets attached to them. So, I simply guess that the
A7V-333X has some hardware we don't support yet, and you'll have to wait
for us to write the support before it works.

Just in case, I'd like to insist on the fact that you need to
reconfigure lm_sensors when changing motherboards. Do to so, rerun
sensors-detect and apply any suggested change to your init files.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
