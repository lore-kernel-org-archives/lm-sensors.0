From: Nishanth Menon <nm@ti.com>
Date: Tue, 24 Feb 2015 20:06:17 +0000
Subject: Re: [lm-sensors] [PATCH V2] (gpio-fan): Add thermal control hooks
Message-Id: <CAGo_u6rwTARKbvQGcrFkhoUFsV4K7tadFXsG_vFpqXN-dO_6jA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1420740303-12529-1-git-send-email-nm@ti.com>
	<54AF5DA8.6080408@roeck-us.net>
	<20150224192933.GJ3448@developer.amazonguestwifi.org>
	<20150224195457.GA16245@roeck-us.net>
In-Reply-To: <20150224195457.GA16245@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, lkml <linux-kernel@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Feb 24, 2015 at 1:55 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Feb 24, 2015 at 03:29:35PM -0400, Eduardo Valentin wrote:
>> Guenter,
>>
>> On Thu, Jan 08, 2015 at 08:48:40PM -0800, Guenter Roeck wrote:
>> > On 01/08/2015 10:05 AM, Nishanth Menon wrote:
>> > > Allow gpio-fan to be used as thermal cooling device for platforms that
>> > > use GPIO maps to control fans.
>> > >
>> > > As part of this change, we make the shutdown and remove logic the same
>> > > as well.
>> > >
>> > > Signed-off-by: Nishanth Menon <nm@ti.com>
>> > > ---
>> >
>> > Applied to -next.
>>
>> What is the target kernel version for this change? It didn't make
>> 4.0-rc1
>>
> If I recall correctly, I had to pull it because the thermal framework
> does not provide hooks if disabled. Weird, I am sure I sent an e-mail
> about this, but I don't find it right now.
>
> It can't make it in before the hooks are in place, or we'll need
> another version with ifdefs around the thermal registration code.

I had posted the required hooks.
https://patchwork.kernel.org/patch/5828261/ -> I think Eduardo picked
this one up.. So once it hits mainline, we should ideally be clear.

-- 
---
Regards,
Nishanth Menon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
