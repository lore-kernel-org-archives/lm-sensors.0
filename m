From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 11:49:01 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070411134901.6088ecbb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 09 Apr 2007 14:34:35 +0200, Hans de Goede wrote:
> Oh and another thing I just came up with, last time I checked, it isn't 
> possible from userspace to change an inX_input to a tempX_input, or are you 
> suggesting that I export all 48 sensors, 3 times, once as in, once as temp and 
> once as fan and them make user space ignore temp1 and fan1, and use in0, as 
> sensor 0/1 actually is an in sensor?

You're right, this isn't possible, because it's not needed. The drivers
are usually able to read the device configuration from its registers,
and create the right sysfs entries based on that information. The only
exceptions being the vt1211 and gl520sm drivers, which I mentioned in
my previous reply.

So I seem to understand that, for the abituguru3, you are not able to
read the configuration from the device? Again I must blame Abit for
their very poor design and/or lack of documentation :(

Didn't you have the same problem originally in the first abiturugu
driver? If so, how did you solve it?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
