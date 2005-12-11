From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Dec 2005 09:54:20 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d clear/simplify code
Message-Id: <20051211105420.5d135d7b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7BF77@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7BF77@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch collect simplifies and clear patches Jean has done with hwmon
> w83792d driver.
> And Fix the tolerance 2 and tolerance 3 can not be set bug.
> 
> I hope this patch is right, please can you check :)

Patch looks OK, except for data->low_bits which you had set to u8 while
it must be u16 (you have to fit 14 bits in there). I've just applied
it. Thanks for your contribution!

I noticed another bug in the w83792d driver while verifying your patch:
the fan control mode (PWM/DC) was not reported properly due to a typo
([1] instead of [i]). I've fixed that too. Linux 2.6 is not affected.

Thanks,
-- 
Jean Delvare

