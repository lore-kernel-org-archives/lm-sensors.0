From: Riku Voipio <riku.voipio@iki.fi>
Date: Wed, 17 Oct 2007 20:45:08 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071017204508.GA32110@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de>
In-Reply-To: <20071017195439.GD3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

> <--  snip  -->
> 
> ...
> static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *attr,
>                 const char *buf, size_t count)
> {
> ...
>         if (val != 0 || val != 1 || data->kind = f75373)
>                 return -EINVAL;
> ...
> 
> <--  snip  -->

> I'm not sure what exactly was intended, but it was for sure not intended 
> to always return -EINVAL...

Aiee. val should be 1 or 0, and kind must not be f75373.

Signed-off-by: Riku Voipio <riku.voipio@iki.fi>
---
 drivers/hwmon/f75375s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index f1df57a..885bfe9 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -344,7 +344,7 @@ static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *attr,
    int val = simple_strtoul(buf, NULL, 10);
    u8 conf = 0;

-   if (val != 0 || val != 1 || data->kind = f75373)
+   if (!(val = 0 || val = 1 ) || data->kind = f75373)
        return -EINVAL;

    mutex_lock(&data->update_lock);
--
1.5.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
