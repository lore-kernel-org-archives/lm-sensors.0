From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 04 Feb 2010 18:22:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100204102203.ecf4bbb5.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
In-Reply-To: <201002031723.49976.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven King <sfking@fdwdc.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 3 Feb 2010 17:23:49 -0800
Steven King <sfking@fdwdc.com> wrote:

> The TI TMP102 is similar to the lm75.  It differs from the lm75 by having a 16 bit conf register
> and the temp registers have a minimum resolution of 12bits; the extended conf register
> can select 13 bit resolution (which this driver does) and also change the update rate (which this
> driver currently doesn't use).
> 

A neat little driver.

checkpatch spits this warning:

    WARNING: struct dev_pm_ops should normally be const
    #387: FILE: drivers/hwmon/tmp102.c:300:
    +static struct dev_pm_ops tmp102_dev_pm_ops = {

which seems truthful enough.

--- a/drivers/hwmon/tmp102.c~hwmon-driver-for-ti-tmp102-temperature-sensor-checkpatch-fixes
+++ a/drivers/hwmon/tmp102.c
@@ -297,7 +297,7 @@ static int tmp102_resume(struct device *
 	return 0;
 }
 
-static struct dev_pm_ops tmp102_dev_pm_ops = {
+static const struct dev_pm_ops tmp102_dev_pm_ops = {
 	.suspend	= tmp102_suspend,
 	.resume		= tmp102_resume,
 };
_



And doing this will hurt readers' brains less:



Use conventional array-walk loop.

--- a/drivers/hwmon/tmp102.c~hwmon-driver-for-ti-tmp102-temperature-sensor-fix
+++ a/drivers/hwmon/tmp102.c
@@ -91,13 +91,14 @@ static struct tmp102 *tmp102_update_devi
 
 	mutex_lock(&tmp102->lock);
 	if (time_after(jiffies, tmp102->last_update + HZ / 4)) {
-		int i = 0;
-		do {
+		int i;
+		
+		for (i = 0; i < ARRAY_SIZE(tmp102->temp); i++) {
 			int status = tmp102_read_reg(client, tmp102_reg[i]);
 			if (status > -1)
 				tmp102->temp[i] = tmp102_reg_to_mC(status);
 
-		} while (++i < ARRAY_SIZE(tmp102->temp));
+		}
 		tmp102->last_update = jiffies;
 	}
 	mutex_unlock(&tmp102->lock);
_


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
