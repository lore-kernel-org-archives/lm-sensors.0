From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Jun 2006 20:28:19 +0000
Subject: [lm-sensors] [PATCH] I2C: Add MAX6900 I2C RTC support (4th try!)
Message-Id: <20060625222819.3614f1f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200511231317.41695.sr@denx.de>
In-Reply-To: <200511231317.41695.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

> Sorry for this mail flood. Jean assured me, that now my attachment should go 
> through.
> 
> This patch adds support for the Maxim/Dallas MAX6900 I2C RTC.
> 
> Signed-off-by: Stefan Roese <sr at denx.de>

Sorry, I didn't have the time to review your driver back then. Now
there is a new RTC subsystem where your driver would fit better, so if
you are still interested in having your driver merged, please submit it
again for inclusion into this subsystem (drivers/rtc). The RTC
subsystem is maintained by Alessandro Zummo.

-- 
Jean Delvare

