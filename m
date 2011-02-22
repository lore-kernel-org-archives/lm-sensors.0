From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 22 Feb 2011 12:14:41 +0000
Subject: Re: [lm-sensors] [PATCH 0/4] Move lis3lv02d and hp_accel out of
Message-Id: <4D63A8B1.4020904@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219141219.47aba4f8@endymion.delvare>
In-Reply-To: <20110219141219.47aba4f8@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/22/11 09:21, Jean Delvare wrote:
> Hi Jonathan,
> 
> On Mon, 21 Feb 2011 18:24:21 +0000, Jonathan Cameron wrote:
>> On 02/19/11 13:12, Jean Delvare wrote:
>>> Hi all,
>>>
>>> Here is a patch set moving lis3lv02d and hp_accel out of drivers/hwmon.
>>> hp_accel goes where it belongs, i.e. drivers/platform/x86 (next to
>>> hdaps.) For lis3lv02d, I would have preferred a more specific home, but
>>> none seems to be suitable at the moment, so I went for drivers/misc. We
>>> might revisit this later.
>>>
>>> [PATCH 1/4] Let Kconfig handle lis3lv02d dependencies
>>> [PATCH 2/4] Move hp_accel to drivers/platform/x86
>>> [PATCH 3/4] Move lis3lv02d drivers to drivers/misc
>>> [PATCH 4/4] hp_accel: Fix driver name
>>>
>>> As with every patch moving files around, the patches look very large
>>> but most of them can be ignored, all you really have to look at are the
>>> Kconfig and Makefile changes.
>>>
>>> Note that I don't have supported hardware so I wasn't able to test the
>>> patches. So I would welcome testing as much as review.
>>
>> Can't test either I'm afraid, but glad to see this move happened.
>> Fingers cross no one will ever submit an accelerometer to hwmon
>> again!
>>
>> I was kind of hoping that Dmitry would be happy to take the lis3lv02d bit
>> into input given that seems to be the primary use of the device, but
>> this is probably a simpler move to make.
> 
> The last statement I have from Dmitry is from
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-October/029814.html
> 
> "lis3lv02d could either go into drivers/misc or stay where it is for the
> time being, pending resolution on overall IIO/Input/accelerometers
> decision. I'd take it in input/misc but accelerometer guys need to
> decide on common sysfs layout for such devices."
> 
> I don't know if things changed is this area?
Sadly not.  Hemanth contribute some thoughts on this when we were discussing
his cma3000 driver, but in the end for ease of merging, the sysfs bits were
dropped entirely.  Alan Cox has been posting a bma023 driver to linux-input
which has a totally device specific interface.  I suspect Dmitry will 
block that one on this basis so the discussion may well reopen. (I've just
written a reply to that suggesting that perhaps it should). Alan is
making some progress towards at least getting rid of some of the magic
numbers attributes in that driver.

Eric, are you happy to contribute on such a discussion?

As ever I'll approach it from what we have for IIO as we have a wider
range of device types than anyone else, but within reason I'm happy to
propose changes to IIO's interfaces as long as they don't break with
our requirements of generality, specificness and ease of understanding.
> 
>> If they haven't already merged,
> 
> They are in my staging tree for the time being, which means they can
> easily be amended. We have a few weeks left to do so if needed (until
> the next merge window opens.)
Cool.
> 
>> feel free to add:
>>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk> to 
> 
> Thank you!
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
