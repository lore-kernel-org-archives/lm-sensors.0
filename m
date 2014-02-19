From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 14:23:33 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <5304BE65.5030609@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/19/2014 06:14 AM, Jean Delvare wrote:
> On Wed, 19 Feb 2014 05:52:54 -0800 (PST), ianp wrote:
>> I'm almost ready with my configuration. Now here's my +5V scaling computation:
>>
>> +5V BIOS samples: 5.040, 5.064, 5.136
>
> And I've found 5.088 on the web (G41M-GS but hopefully it's the same):
> http://www.3dnews.ru/582775/page-2.html
>
>> 5.064 - 5.040 = 0.024
>> 5.136 - 5.064 = 0.072
>
> 5.088 - 5.064 = 0.024
> 5.136 - 5.088 = 0.048
> (just to confirm your findings)
>
>> 5.136 / (24/8) = 1.712
>>
>> 1.712 is close enough to in5 (1.688). So my compute statement is:
>
> I'd even say that 5.064 / (24/8) = 1.688 is close enough to your in5 ;-)
>
>> compute in5 @*3, @/3
>>
>> Apparently, the scaling factor I use above maps exactly with the BIOS values I have seen. So if everything checks out and you concur with my computation, then I can send in my configuration.
>
> Yes, I completely agree with your computations. Great job! Glad to see
> my guide working in practice :-)
>

... and sorry for my misleading advice earlier.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
