From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Jun 2011 13:19:48 +0000
Subject: Re: [lm-sensors] pmbus driver
Message-Id: <20110609131948.GA11436@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Vivek,

On Thu, Jun 09, 2011 at 07:58:03AM -0400, Vivek Bardia wrote:
> Hi Guenter,
> 
> I do not know if this is the right way to ask you about PMBus driver
> implementation done by you. Do direct me to the right forum if not.
> 
The lm-sensors mailing list would be the best place to ask, but this will do.
I am copying the list.

> If a PMIC just has one temperature die sensor only, it does not support PAGE
> and PHASE commands, and is just a PMBus based buck controller; then does the
> driver written by you support such a hardware.
> 
The driver supports BMR45x, which are the same type of controller. So, yes, the driver
should work. Just give it a try. If the generic driver doesn't work, you (or I)
can write a little front-end driver to tell the PMBus core driver which registers are 
supported. Worst case the driver may need some patches, but that is unlikely.

Do you have a datasheet ?

Thanks,
Guenter

> some inputs from you can help me decide whether I need to write another driver
> or not. The pmic driver will be used by a voltage regulator driver.
> 
> Regards,
> Vivek
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
