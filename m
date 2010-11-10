From: Henrik Rydberg <rydberg@euromail.se>
Date: Wed, 10 Nov 2010 10:57:24 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon: applesmc: Introduce a
Message-Id: <4CDA7A94.7070302@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289315711-3011-1-git-send-email-rydberg@euromail.se>	 <1289315711-3011-5-git-send-email-rydberg@euromail.se>	 <1289329469.22931.221.camel@groeck-laptop>  <4CD9A1DC.2000407@euromail.se> <1289336024.22931.243.camel@groeck-laptop>
In-Reply-To: <1289336024.22931.243.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


>>
>> mutex_destroy() is defined as a nop, so I guess the question is whether anything
>> could be holding the lock when entering a second init. There are no sysfs files
>> created at that point, so I would say no. The mutex could be put back with a
>> static initializer, if this is not satisfactory. The real reason to move it to
>> the smcreg struct was to force a rename of the mutex itself.
>>
> 
> Alternatively, you could move the mutex initialization to the beginning
> of applesmc_init_smcreg() and make it
> 	mutex_init(&smcreg.mutex);


Looking at this again, it seems there are two other problems as well. Firstly,
the cache memory is not freed after probe failure, my apologies. Secondly,
execution continues after a probe failure, and the initialization is retried. I
would like to push the latter problem to some other occasion, since the whole
platform logic should be rewritten for the new interface, anyways.

>>
>> With the empirical failure rate, it is extremely unlikely to get more than a
>> couple of failures in a row - information which in itself could be very useful.
> 
> You would have alternative options, though, with less noise. For
> example, something along the line of
> 
> 	for (...) {
> 		...
> 		if (!ret) {
> 			if (ms)
> 				pr_info("smcreg initialization took %d ms\n", ms);
> 			return 0;
> 		}
> 	...
> 	}
> 	pr_err("smcreg initialization failed\n");


Looks nice, have applied, but without the last line; the probe failure report
should be enough to deduce this.

>>
>> Changing the place of the mutex will ripple through all patches, so I will
>> resend from this one onwards. I suppose you have more comments on the following
>> patches?
> 
> Maybe it won't be that bad if you initialize it as I suggested above.


I tried several types of changes, and they all had some effect on later patches.
The patch below comprise the resulting changes to patch 4. Hope you like. In
addition, patch 5 and 7 needed one line of wiggling. I am resending all three.

@@ -217,7 +217,9 @@ static struct applesmc_registers {
 	unsigned int key_count;		/* number of SMC registers */
 	bool init_complete;		/* true when fully initialized */
 	struct applesmc_entry *cache;	/* cached key entries */
-} smcreg;
+} smcreg = {
+	.mutex = __MUTEX_INITIALIZER(smcreg.mutex),
+};

 static const int debug;
 static struct platform_device *pdev;
@@ -581,8 +583,6 @@ static int applesmc_init_smcreg_try(void)
 	if (s->init_complete)
 		return 0;

-	mutex_init(&s->mutex);
-
 	ret = read_register_count(&s->key_count);
 	if (ret)
 		return ret;
@@ -611,19 +611,25 @@ static int applesmc_init_smcreg(void)

 	for (ms = 0; ms < INIT_TIMEOUT_MSECS; ms += INIT_WAIT_MSECS) {
 		ret = applesmc_init_smcreg_try();
-		if (!ret)
+		if (!ret) {
+ 			if (ms)
+				pr_info("smcreg initialization took %d ms\n", ms);
 			return 0;
-		pr_warn("slow init, retrying\n");
+		}
 		msleep(INIT_WAIT_MSECS);
 	}

+ 	kfree(smcreg.cache);
+	smcreg.cache = NULL;
+
 	return ret;
 }

 static void applesmc_destroy_smcreg(void)
 {
 	kfree(smcreg.cache);
-	memset(&smcreg, 0, sizeof(smcreg));
+	smcreg.cache = NULL;
+	smcreg.init_complete = false;
 }

 /* Device model stuff */

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
