From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sun, 27 Nov 2005 03:00:02 +0000
Subject: [lm-sensors] [PATCH 09/25] i2c:Drop i2c_driver.flags, 3 of 3
Message-Id: <20051127015952.GA4468@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051126203001.2b911d0b.khali@linux-fr.org>
In-Reply-To: <20051126203001.2b911d0b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2005-11-26 20:30:01 +0100]:
> Content-Disposition: inline; filename=i2c-client-use-03-allow-multiple-use.patch
> 
> Do not limit the usage count of i2c clients to 1. In other words,
> change the client usage count behavior from the old I2C_CLIENT_ALLOW_USE
> to the old I2C_CLIENT_ALLOW_MULTIPLE_USE. The rationale is that no
> driver actually needs the limiting behavior, and the unlimiting
> behavior is slightly easier to implement.
> 
> Update the documentation to reflect this change.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/i2c/porting-clients |    1 +
>  drivers/i2c/i2c-core.c            |    5 -----
>  include/linux/i2c.h               |    4 +---
>  3 files changed, 2 insertions(+), 8 deletions(-)

-EWRONGPATCH ?  This one is the same as 23/25 in the series.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

