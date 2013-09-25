From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Sep 2013 16:10:52 +0000
Subject: Re: [lm-sensors] Tmp75 sensor installation
Message-Id: <20130925181052.00767e38@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
In-Reply-To: <A0BF65D4B054AE4A96B849EB86D293E0B9C74B5657@ex01.acromag.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Sep 2013 11:49:15 -0400, Benjo Dans wrote:
> I did check the log and there was initially an error with i2c-i801 where it stated "module verification failed: signature and/or required key missing - tainting kernel".  I added #include <linux/init.h> and have not seen it again.

Not sure where you got your driver from then, because both the upstream
i2c-i801 driver and my standalone variant already include
<linux/init.h>.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
