From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Aug 2005 17:14:44 +0000
Subject: [lm-sensors] Using i2c for inventory/asset management.
Message-Id: <NCxbKZJb.1123686436.9146830.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FA1706.8010608@winmutt.com>
In-Reply-To: <42FA1706.8010608@winmutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rolf,

> Error: No I2C busses found!
> Be sure you have done 'modprobe i2c-dev'
> and also modprobed your i2c bus drivers
>
> This is on debian with a vanilla kernal recompiled for i2c support. Are
> my i2c tools out of date?

Is the i2c-dev driver built into your kernel? If not, that's what
you're missing for i2cdetect to work properly.

--
Jean Delvare
