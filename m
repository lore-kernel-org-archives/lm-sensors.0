From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Feb 2014 04:21:45 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <53043159.2000501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/18/2014 07:31 PM, ianp wrote:
> Minor correction:
>
>> You can see that in3 is "+3.3V". Of course I tried modifying in3 in my
>> configuration as follows:
>>
>> label in3 "+5V"
>> set in3_min 5 * 0.95
>> set in3_max 5 * 1.05
>> compute  in3  @*((20/10)+1), @/((20/10)+1) #### was in4
>
> Could this perhaps be a bug in the w83627ehf kernel module?
>
>

Theoretically yes, but I am quite sure that it is PBKC
(Problem Between Keyboard And Chair ;-).

Try sensors -u for raw values. That should help us determine
the correct compute statements.

As far as I can see from the driver, in3 has an automatic
built-in scaling factor of 2 for this chip, meaning it already
reports twice the voltage you would expect for other inputs,
and thus should not need scaling in the first place.
In other words, sensors -u should already report
the correct value for in3.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
