From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 16 Jun 2007 19:35:56 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <46743B9C.7060401@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi all:
> 
> * Jean Delvare <khali@linux-fr.org> [2007-04-11 13:49:01 +0200]:
>> Hi Hans,
>>
>> On Mon, 09 Apr 2007 14:34:35 +0200, Hans de Goede wrote:
>>> Oh and another thing I just came up with, last time I checked, it isn't 
>>> possible from userspace to change an inX_input to a tempX_input, or are you 
>>> suggesting that I export all 48 sensors, 3 times, once as in, once as temp and 
>>> once as fan and them make user space ignore temp1 and fan1, and use in0, as 
>>> sensor 0/1 actually is an in sensor?
>> You're right, this isn't possible, because it's not needed. The drivers
>> are usually able to read the device configuration from its registers,
>> and create the right sysfs entries based on that information. The only
>> exceptions being the vt1211 and gl520sm drivers, which I mentioned in
>> my previous reply.
> 
> In this case, there is no practical difference between reading that info from a
> register on the chip and inferring it from a register on the motherboard.
>

To be precise, the info actually is read from a register on the chip, not a 
register on the motherboard (the chip is on the motherboard ofcourse).

So there really is no difference here, a register gets read and based on its 
contents it gets determined what inputs are available and what their types are.

As an added bonus, one can also determine the scaling factors and labels for 
the inputs too.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
