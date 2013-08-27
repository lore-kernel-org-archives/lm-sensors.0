From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Tue, 27 Aug 2013 14:55:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (acpi_power_meter) Fix incorrect placement of __initdata
Message-Id: <CAK9yfHxftaeoXtqpYygwxzHtD16cUSY2pXujH86Tdw88CxPDDQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375868833-566-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 27 August 2013 19:43, Jean Delvare <khali@linux-fr.org> wrote:
> On Tue, 27 Aug 2013 15:10:43 +0100, Russell King - ARM Linux wrote:
>> On Tue, Aug 27, 2013 at 03:57:53PM +0200, Jean Delvare wrote:
>> > Also note that the fix Sachin sent for acpi_power_meter is slightly
>> > different from what Russell complained about originally. Russell
>> > complained about:
>> >
>> > struct __initdata foo bar;
>> >
>> > While acpi_power_meter uses:
>> >
>> > struct foo __initdata bar;
>> >
>> > The former does indeed NOT work in my tests, so Russell was right
>> > complaining. The good news is that there are only a few dozen
>> > occurrences of this in the kernel tree.
>>
>> Indeed - and these "don't work" ones are definitely worth fixing.
>
> Agreed.
>
>> > The later OTOH works fine in my tests so I see no reason to change it -
>> > unless someone can find a gcc version and platform combination where it
>> > does not work. Hope this clarifies the whole situation...
>>
>> Yes, better not to change what's already there if it works fine.
>> However, as I mentioned in my previous email, it's probably better to
>> have a convention here for new code rather than having people stick
>> these markers in random places within the declaration and hit the "it
>> silently doesn't work" case.
>
> I totally agree, I think we want a checkpatch rule for this. I'll ask
> for it in a separate thread.

I had already asked Joe to add this as a checkpatch rule. He mentioned
the following (which I quote):
"There's no way for checkpatch to look at an __<foo> use
and determine it should be before or after a variable.

__scanf, __printf, __cold, etc are often place before
declarations."


-- 
With warm regards,
Sachin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
