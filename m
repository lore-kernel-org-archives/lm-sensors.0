From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 22 Jun 2011 09:42:39 +0000
Subject: Re: [lm-sensors] pmbus driver
Message-Id: <20110622094239.GB21791@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110609131948.GA11436@ericsson.com>
In-Reply-To: <20110609131948.GA11436@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 22, 2011 at 04:45:14AM -0400, Vivek Bardia wrote:
> Hi Guenter,
> 
> sorry for the delayed reply from my end. 
> 
> Right now I am under the constraint where I cannot share the datasheet. But
> yes, the datasheet is going be out very soon. I shall update u about the same
> 
> Can the pmbus driver be used to set output voltage from another driver in the
> kernel space itself. what I understood about the pmbus driver is that it is
> meant for monitoring and controlling. at my end if the monitoring is being done
> by another entity(voltage regulator) and the controlling only needs to be done
> by the PMIC then how do I go about? say I just want to use VOUT_TRIM command. 
> 
At least right now that is not supported. The current driver only supports hwmon
functionality, ie pure monitoring; control is not implemented. A clean implementation
for control would probably require a rewrite with a generic part (probably in mfd),
control (probably in regulator) and monitoring (in hwmon).

Note that you can not have an I2C slave chip controlled by multiple entities.
If you wrote or have a regulator driver, it has control over the chip, and hwmon access
to it will not be possible.

Not sure what your application is. If it is for mfg testing (which the VOUT_TRIM command
suggests), you might be better off just using raw I2C commands from user space (which again 
would only work while the chip is not 'claimed' by a kernel driver).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
