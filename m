From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Aug 2014 05:00:26 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/2] hwmon: (ads1015) Use of_property_read_u32 at appropriate places
Message-Id: <53E064EA.10300@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1407204038.20206.1.camel@phoenix>
In-Reply-To: <1407204038.20206.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/04/2014 07:52 PM, Axel Lin wrote:
> 2014-08-05 10:49 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:
>> On 08/04/2014 07:00 PM, Axel Lin wrote:
>>>
>>> Simplify the code a bit and also improve readability.
>>>
>>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>>
>>
>> Hi Axel,
>>
>> Unfortunately, this patch does not apply for me. Looks like your branch is
>> missing
>> commit 56de1377 (hwmon: (ads1015) Fix off-by-one for valid channel index
>> checking).
>> Can you rebase your branch to make sure it is included ? The above patch
>> should
>> hopefully be in mainline in a day or so, but you should have it already
>> (after all,
>> it is one of your patches ;-).
> It's because I use linux-next tree.
> And the commit 56de1377 (hwmon: (ads1015) Fix off-by-one for valid
> channel index checking is still
> not in linux-next (20140804).
>
Yeah, sorry. I missed to rebase my -next branch to my bug-fix branch
last week, and only noticed this morning when I prepared my pull request.
Vacation does that for you. I already got a ding on my head for it from
Stephen, with copy to Linus :-(.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
