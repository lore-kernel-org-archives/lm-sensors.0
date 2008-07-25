From: Jonathan Cameron <Jonathan.Cameron@gmail.com>
Date: Fri, 25 Jul 2008 11:12:36 +0000
Subject: Re: [lm-sensors] [Patch 0/4] IndustrialIO subsystem (ADCs,
Message-Id: <4889B524.5010602@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <488763AD.4050400@gmail.com> <alpine.LNX.1.10.0807250025080.11551@fbirervta.pbzchgretzou.qr>
In-Reply-To: <alpine.LNX.1.10.0807250025080.11551@fbirervta.pbzchgretzou.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@medozas.de>
Cc: LKML <linux-kernel@vger.kernel.org>, spi-devel-general@lists.sourceforge.net, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dtor@mail.ru>, "Hans J. Koch" <hjk@linutronix.de>, hmh@hmh.eng.br, David Brownell <david-b@pacbell.net>, mgross@linux.intel.com, Ben Nizette <bn@niasdigital.com>, Anton Vorontsov <avorontsov@ru.mvista.com>

Jan Engelhardt wrote:
> On Wednesday 2008-07-23 19:00, Jonathan Cameron wrote:
>
>   
>> Dear All,
>>
>> The need for an industrialio subsystem was discussed in
>> http://lkml.org/lkml/2008/5/20/135
>>
>> Firstly thanks to all the people who have contributed to the discussion
>> of this in the past.
>>
>> In brief the intention is provide a kernel subsystem directed towards the
>> handling on sensors (and later related output devices) such as ADC's,
>> accelerometers and many others.
>>     
>
> Could this be done using UIO instead?
>   
No, this lot is directed towards devices that use serial buses such as
i2c  and SPI whereas
UIO is, from my admittedly cursory knowledge, intended for devices which
can have
their control registers memory mapped into user space.

Looks like I need to be a bit more specific in my descriptions. It's
terrible but as all the
sensors etc I work with are connected like this it never occurred to me
to make it
explicit in the description.
--
Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
