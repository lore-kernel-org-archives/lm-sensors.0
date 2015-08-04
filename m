From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 04 Aug 2015 21:50:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8732F
Message-Id: <55C1338B.9060303@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Justin,

On 08/04/2015 02:29 PM, Justin Maggard wrote:
> On Tue, Aug 4, 2015 at 1:08 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Hi Justin,
>>
>> On Tue, Aug 04, 2015 at 12:45:31PM -0700, Justin Maggard wrote:
>>> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
>>> with the main difference being that the ADC LSB is 10.9 mV instead of
>>> 12 mV.
>>>
>>
>> I assume you have a datasheet. Since you say "main difference",
>> are you aware of any other differences ? Would it by any chance
>> be possible to share the datasheet with us ?
>>
>
> Yes, I do have a datasheet.  I'm investigating our confidentiality
> obligations now, but I'm unsure what that outcome will be.  I don't

Ok.

> have datasheets for any other chips, so I can't really do a proper
> comparison.  But the driver code for IT8721F seems to line up well
> with the IT8732F datasheet.
>
> IT8732F has up to 4 fan tachometer inputs, and up to 4 PWM outputs.
> The "SmartGuardian" piece appears identical.  As I mentioned in the
> doc change, it also has a fan tachometer closed-loop mode that seems
> new (at least I didn't see any reference to it in the driver).  That

IT8772F supports it as well. Datasheet isn't published, but you might be
able to find leaked versions on the web. Search for IT8772_F_V0.4_031612.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
