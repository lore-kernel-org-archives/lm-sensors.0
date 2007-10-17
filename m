From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 17 Oct 2007 19:54:39 +0000
Subject: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071017195439.GD3778@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Riku Voipio <riku.voipio@iki.fi>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

drivers/hwmon/f75375s.c contains the following code:

<--  snip  -->

...
static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *attr,
                const char *buf, size_t count)
{
...
        if (val != 0 || val != 1 || data->kind = f75373)
                return -EINVAL;
...

<--  snip  -->

I'm not sure what exactly was intended, but it was for sure not intended 
to always return -EINVAL...

Spotted by the Coverity checker.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
