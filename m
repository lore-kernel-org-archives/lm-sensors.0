From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Apr 2009 20:57:03 +0000
Subject: Re: [lm-sensors] w83793 related question
Message-Id: <20090422225703.790834da@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E45712.6020906@aei.mpg.de>
In-Reply-To: <49E45712.6020906@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Apr 2009 22:16:19 +0200, Rudolf Marek wrote:
> Hi,
> 
> I have been thinking what it possibly could be. It seems like there might be two 
> reasons:
> 
> 1) the board is equipped with some kind of remote management conroller, which is 
> also doing transactions on I2C
> 
> Is there some?
> 
> 2) the SMM mode is doing its own i2c transactions, interfering with the driver.
> 
> The problem is that SMM iss transparent to OS.The only thing could possibly done 
> is a BIOS change, or one could add some code to acquire global ACPI lock. It 
> would require to modify the driver and add there those functions.

What makes you think there is a relation between SMM and ACPI?

> 
> 3) Make a driver more bullet proof. Maybe it would be possible somehow to force 
> the driver to have a longer timeouts, more retries etc.

This is pointless. If another entity is accessing the chip without
proper locking, no amount of timeouts or retries will help. In this
scenario, reported errors are in fact the best thing than can happen.
The worst case is silent misbehavior.

> 
> I would still need to know how often this problem  actually happens.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
