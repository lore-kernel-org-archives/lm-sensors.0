From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: LM75 detection reworked
Message-Id: <20040708210615.175350ca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040703105636.6ba726d6.khali@linux-fr.org>
In-Reply-To: <20040703105636.6ba726d6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Bad news: I up'd to 1.334 of sensors-detect and 1.48 of lm75.c... now
> my two lm75s are not detected by the script nor by the driver.
> 
> Here's what I guess happened: earlier, when you asked me to test, I
> unloaded all the i2c/sensors drivers, rebuilt and tested; you saw
> the results.  Now when I tested again tonight, it's the first try
> since a reboot.
> 
> Certainly, I can't believe that the changes between 1.332 and 1.334 of
> sensors-detect should affect me w.r.t. the lm75s.
> 
> I apologize for the mixup; from now on I'll be sure to test following
> a fresh reboot as well as re-inserting the modules.  Here are the
> dumps immediately following a reboot for two lm75s.  Let me know if
> there's anything else I can provide.

OK, simply looks like we cannot assume anything about the lower
temperature bits. I removed the check for them. I *guess* that they are
either all 1's or all 0's but since we are not certain...

Please test lm75.c and sensors-detect from CVS. If it fixed the problem
for you I'll send an update to Greg for 2.6.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
