From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 15:50:52 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110316165052.37482c0c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Emiliano, Guenter, Dirk,

On Wed, 9 Mar 2011 11:05:52 +0100, Emiliano Carnati wrote:
> > Another question - is it ok to keep the thread state as TASK_INTERRUPTIBLE 
> > after the wait is complete ?
> 
> Well, maybe it's better to put a set_current_state(TASK_RUNNING) after the 
> wait loop.

LDD3 doesn't say anything about setting TASK_RUNNING after
schedule_timeout(), and looking at other drivers, most don't do it, so
I am reasonably certain that we don't have to care.

OTOH, I believe that TASK_INTERRUPTIBLE is not appropriate here. A
received signal would shorten the wait time, meaning that the driver
would no longer wait for the maximum time and may thus return an error.
TASK_UNINTERRUPTIBLE is what we want here, I think, and as a matter of
fact this is what the abituguru driver is doing. TASK_INTERRUPTIBLE
would only be acceptable if the control loop was time-based rather than
count-based.

The missing set_current_state() in the original driver is a genuine
bug, so I'll merge the fix directly in the patch which adds the driver.
Thanks for noticing and reporting.

For reference, here is the change I applied:

--- linux-2.6.38.orig/drivers/hwmon/ads1015.c	2011-03-16 16:49:29.000000000 +0100
+++ linux-2.6.38/drivers/hwmon/ads1015.c	2011-03-16 16:45:04.000000000 +0100
@@ -98,6 +98,7 @@ static int ads1015_read_value(struct i2c
 	if (res < 0)
 		goto err_unlock;
 	for (k = 0; k < 5; ++k) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(msecs_to_jiffies(1));
 		res = ads1015_read_reg(client, ADS1015_CONFIG);
 		if (res < 0)

If anyone has a problem with this, please speak up.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
