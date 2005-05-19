From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6.12-rc1] I2C: Fix breakage in m41t00 i2c rtc driver
Message-Id: <sw1d3eXe.1110365882.3208480.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E4313.6000004@mvista.com>
In-Reply-To: <422E4313.6000004@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> Remove setting of deleted i2c_client structure member.
>
> The latest include/linux/i2c.h:i2c_client structure no longer has an
> 'id' member.  This patch removes the setting of that no longer existing
> member.

Oops. I tried to catch all new drivers using it because I knew it was
soon to be removed, but obviously missed this driver. Sorry :( I also
tried to compile all drivers to catch potential leftovers, but it was on
a non-PPC system so my test did not include your driver.

Sorry again, and thanks for the update. Greg, please apply and push to
Linus soon.

Thanks,
--
Jean Delvare
