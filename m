From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 05 Jun 2010 22:12:22 +0000
Subject: Re: [lm-sensors] [RFC][PATCH 22/26] hwmon: Add JZ4740 ADC driver
Message-Id: <4C0ACBC6.6050209@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-6-git-send-email-lars@metafoo.de>     <4C0A87F1.8000201@jic23.retrosnub.co.uk> <4C0AA0CA.9020808@metafoo.de> <4C0ABC75.9020908@jic23.retrosnub.co.uk>
In-Reply-To: <4C0ABC75.9020908@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <kernel@jic23.retrosnub.co.uk>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, lm-sensors@lm-sensors.org

Jonathan Cameron wrote:
> On 06/05/10 20:08, Lars-Peter Clausen wrote:
>   
>> Hi
>>
>> Jonathan Cameron wrote:
>>     
>>> On 06/02/10 20:12, Lars-Peter Clausen wrote:
>>>   
>>>       
>>>> This patch adds support for the ADC module on JZ4740 SoCs.
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Cc: lm-sensors@lm-sensors.org
>>>> ---
>>>>  drivers/hwmon/Kconfig      |   11 ++
>>>>  drivers/hwmon/Makefile     |    1 +
>>>>  drivers/hwmon/jz4740-adc.c |  423 ++++++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/jz4740-adc.h |   25 +++
>>>>  4 files changed, 460 insertions(+), 0 deletions(-)
>>>>  create mode 100644 drivers/hwmon/jz4740-adc.c
>>>>  create mode 100644 include/linux/jz4740-adc.h
>>>>     
>>>>         
>>> Hi, I'm just wondering of one wants the majority of this driver to sit in hwmon?
>>>
>>> Looks to me like a fairly classic case for something that might be best implemented
>>> as an mfd with the hwmon, touchscreen and battery drivers separately hanging off that.
>>> You might well have someone who needs the battery driver to work, but doesn't care
>>> about hwmon and so doesn't want to build that bit in... 
>>>
>>> Just an immediate thought.  Perhaps this is the best way to do things...
>>>   
>>>       
>> I've thought about it before and rejected the idea at that time, because
>> I thought it will add more abstraction then actually needed.
>> But at that time the adc driver was not a hwmon driver yet and thus
>> didn't pull in the whole hwmon framework if you only wanted to use the
>> battery driver.
>> But the more I'm thinking about it now it might actually make sense to
>> move the common code to a MFD driver.
>>     
>>> Also after a quick look.  How is it used by the touchscreen driver?
>>> If not, please remove the reference from kconfig until it it is true.
>>>   
>>>       
>> There is no touchscreen driver yet. But if I'm going to remove the
>> reference I'm pretty sure that someone will come up and ask why it
>> actually is necessary to have a separate driver instead of putting all
>> the code into the battery driver.
>>     
> Fair enough.  Perhaps a comment for the patch rather than in Kconfig
> as it currently is.  People will enable it then go 'Why can't I now
> enable the touchscreen driver?'
>
>   
I guess that will work.
>>> Few other bits and bobs inline.
>>>   
>>>       
>>>> diff --git a/drivers/hwmon/jz4740-adc.c b/drivers/hwmon/jz4740-adc.c
>>>> new file mode 100644
>>>> index 0000000..635dfe9
>>>> --- /dev/null
>>>> +++ b/drivers/hwmon/jz4740-adc.c
>>>> @@ -0,0 +1,423 @@
>>>> + [...]
>>>> +static ssize_t jz4740_adc_read_adcin(struct device *dev,
>>>> +					struct device_attribute *dev_attr,
>>>> +					char *buf)
>>>> +{
>>>> +	struct jz4740_adc *adc = dev_get_drvdata(dev);
>>>> +	unsigned long t;
>>>> +	uint16_t val;
>>>> +
>>>> +	jz4740_adc_clk_enable(adc);
>>>> +
>>>>     
>>>>         
>>> Is there a possible race here?
>>>   
>>>       
>> Where exactly?
>>     
> I can't recall off the top of my head if sysfs attributes can having multiple
> simultaneous readers. If they can then thread two is just past the next line.
> Whilst the earlier thread has passed the t = wait.... line as the interrupt has
> fired.  The irq is then disabled by thread 1 whilst thread 2 enables the adc.
> Clearly the timeout will prevent any serious issues but the 2nd thread is going
> to falsely wait a second I think... ?
>   
Hm, right. I didn't thought of that. There can be multiple simultaneous
reads.
Actually there are multiple issues with concurrent reads from adcin pin,
I guess the whole function should be protected by a mutex.
And additionally the clock is not turned off in case of an error.

- Lars

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
