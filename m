From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: PATCH - ALI 1535
Message-Id: <1079084980.405187b42d9aa@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4050ECF0.4030302@isoar.ca>
In-Reply-To: <4050ECF0.4030302@isoar.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting "Andrew E. Mileski" <andrewm@isoar.ca>:

> The enclosed patch adds an adapter class to the ALI1535 bus driver.
> The patch is against Linux kernel 2.6.1, but is trivial so it should
> apply to more recent kernels.

This was known and fixed:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.4-rc2-i2c-busses-class.diff
And is already in 2.6.4-mm1.

But thanks for reporting though :)

> Additional
>    The ADM1021 chip driver returns success for several error
>    conditions.  This should probably be addressed.

Sure. Care to submit a patch? If you find similar issues in other chip
drivers as well, patches are welcome.

Patches are prefered against 2.6.4-mm1.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
