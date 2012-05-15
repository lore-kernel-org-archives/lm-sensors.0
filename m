From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 15 May 2012 14:18:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Generic ADC support for hwmon
Message-Id: <4FB265C1.7060306@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337092008-31263-1-git-send-email-jenny.tc@intel.com> <20120515121339.GA21600@ericsson.com> <4D68720C2E767A4AA6A8796D42C8EB59124E22@BGSMSX101.gar.corp.intel.com> <20120515134257.GA21933@ericsson.com>
In-Reply-To: <20120515134257.GA21933@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Tc, Jenny" <jenny.tc@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jonathan Cameron <jic23@kernel.org>

On 05/15/2012 03:42 PM, Guenter Roeck wrote:
> On Tue, May 15, 2012 at 08:42:57AM -0400, R, Durgadoss wrote:
>> Hi Guenter,
>>
>> Thanks for a quick reply.
>>
>>> On Tue, May 15, 2012 at 10:26:48AM -0400, Jenny TC wrote:
>>>> Currently drivers are using custom APIs to communicate with ADC driver.
>>>> So it make sense to have generic APIs to commnicate with ADC drivers.
>>>> This patch introduces generic APIs to communicate with ADC drivers.
>>>>
>>>> Signed-off-by: Jenny TC <jenny.tc@intel.com>
>>>
>>> Hi Jenny,
>>>
>>> Do you have a practical use case ?
>>
>> We have some platform specific component drivers, thermal drivers,
>> battery drivers using this General purpose ADC in the platform.
>> That's why we thought of doing something like this.
>>
>>>
>>> Also, shouldn't those generic ADCs rather be supported through the IO
>>> subsystem ?
>>> After all, hwmon is all about hardware monitoring, not to provide generic ADC
>>> access.
>>
>> In this case, can we try this in iio or mfd subsystem ?
>> Kindly advise.
>>
> I meant iio (more specifically staging/iio/adc).
> 
> I suspect it might make more sense to have a hwmon client, in parallel to the other
> users/clients (battery control, thermal etc), if the values reported by the ADC reflect
> information relevant for hardware monitoring.
> 

So there is already an experimental IIO to hwmon bridge in
drivers/staging/iio/, which you can use to expose a IIO ADC driver as an
hwmon device.

Add Jonathan to Cc.

- Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
