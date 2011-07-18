From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 18 Jul 2011 16:11:53 +0000
Subject: Re: [lm-sensors] [PATCH] iio: add support for Analog Devices ad7194
Message-Id: <4E245B49.90004@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>	<4E241286.3090103@cam.ac.uk>	<4E242605.9050400@cam.ac.uk> <CAD56B7d+rixhKSoHJ4zcKhT6xMUUZZPERoOzSO74q6ZrHS7-Sg@mail.gmail.com>
In-Reply-To: <CAD56B7d+rixhKSoHJ4zcKhT6xMUUZZPERoOzSO74q6ZrHS7-Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Thomas <pthomas8589@gmail.com>
Cc: lm-sensors@lm-sensors.org, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>

On 07/18/11 17:03, Paul Thomas wrote:
> On Mon, Jul 18, 2011 at 5:24 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 07/18/11 12:01, Jonathan Cameron wrote:
>>> cc'ing linux-iio and AD's driver list.
>>>
>>> Any particular reason for posting to lm-sensors? Now it's there we'll
>>> keep them in the list though as someone might be interested.
>>>
>>> On 07/18/11 08:46, Paul Thomas wrote:
>>>> This uses the iio sysfs interface, and inculdes gain and differential settings
>>
>> Hi Paul,
>>
>> This driver is lagging somewhat in interface terms. Having said that, it applies
>> and compiles fine which will make catching up to current point much easier.
>>
>> If you are short on time I'm happy to do the conversion (as it is a nice simple
>> driver), but obviously I'll need to test it to find out what I messed up this
>> time.
>>
>> Big issues:
>>
>> 1) iio_dev->dev_data is going away, so please use the iio_priv stuff.
>> 2) interface is not terribly close the abi spec.
>> 3) use chan_spec based registration. Actually that'll clean up the abi
>> issues as well and give you much shorter code.
>> 4) differential channels are treated as separate channels (with appropriate
>> numbering).  This is easy here as there are no nasty constraints on channel
>> combinations (it only reads one at a time anyway!).
>>
>> Various nitpicks inline.  Though the above seems like a lot, you have done
>> all the fiddly stuff about actually talking the the chips. Cleaning up
>> interfaces is relatively straight forward!  Lots of fun stuff to add to this
>> chip at a later date, but in the spirit of your driver, lets keep it simple
>> for now!
>>
>> As long as you are happy to do a couple of rounds of testing, we could merge
>> this as is and do the abi work as a series of small steps on top of it?
>>
>> Thanks,
>>
>> Jonathan
> 
> Hi Jonathan, I'd be happy to do the fixing. Is there an existing
> multi-channel driver that might be helpful to reference here?
> 
Cool.

Lots of suitable drivers to copy.  Max1363 is my standard adc and that
driver is reasonably fully featured. I think most of the ADI drivers
are mostly unipolar only, but a quick grep tells me the ad7793 has
a mixture of differential an unipolar.

max1363 is probably the closest to what you have here in that it supports
the same range of combinations of inputs.

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
