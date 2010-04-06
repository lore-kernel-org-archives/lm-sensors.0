From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 06 Apr 2010 12:16:02 +0000
Subject: Re: [lm-sensors] [PATCH] V3, TI ads7871 a/d converter,
Message-Id: <4BBB2602.9000500@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/05/10 19:57, Paul Thomas wrote:
> On Wed, Mar 31, 2010 at 8:55 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 03/31/10 16:02, Paul Thomas wrote:
>>> Great, just a couple of responses.
>>>
>>
>> ...
>>
>>>>> +static const struct attribute_group ads7871_group = {
>>>>> +     .attrs = ads7871_attributes,
>>>>> +};
>>>>> +
>>>>> +static int __devinit ads7871_probe(struct spi_device *spi)
>>>>> +{
>>>>> +     int status, ret, err = 0;
>>>>> +     uint8_t val;
>>>>> +     struct ads7871_data *pdata;
>>>>> +
>>>> There is still a lot of debug code in here that is useful for development
>>>> but probably doesn't want to be in the final driver.
>>> I'm happy with what you think is best, but in other driver I've been
>>> glad to have a little bit in demesg.
>> Fair enough.  How much you report tends to be a personal decision, so
>> it's fine with me as is.
>>
>> Jonathan
>>
> 
> Is there a staging git tree for hwmon? I see this:
> http://lm-sensors.org/kernel, but both branches look old. Should I cc
> another mailing list with this patch? I'm just trying to understand
> how the flow between hwmon and the upstream kernel stuff works.

Sadly hwmon is without a specific maintainer at the moment.  Andrew
Morton is handling some patches in his role as maintainer of last
resort and I think Jean still takes some patches in through his tree,
though they may be mostly work on drivers he has a particular interest
in.

Jonathan






_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
