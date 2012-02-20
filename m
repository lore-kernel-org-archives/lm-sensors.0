From: Roland Stigge <stigge@antcom.de>
Date: Mon, 20 Feb 2012 18:58:31 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <4F4297D7.4010100@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

On 02/20/2012 06:39 PM, Guenter Roeck wrote:
>> Please resubmit a (-p1) patch fixing the issue your originally spotted
>> instead.
>>
> We really need input from Roland on the initialization problem.
> Might make sense to kwwp him copied on this exchange.

Thanks for your notification and sorry for the delay!

Unfortunately, when I ported the driver from the other original author,
I kept the initialization procedure which is obviously wrong, doing
initialization only for one channel. (I adjusted the driver locally
platform-dependent, so didn't find a chance for mainline integration and
this way, the obvious problems in the mainline driver slipped.)

Therefore, a fix for doing this for both channels, possibly in a loop,
would be good, IMO.

Jean's note about the broken variable initialization is correct. Should
have done this differently.

The other note about initialization only with platform_data is also a
good idea.

I'm using the chip on a custom ARM board without BIOS initialization,
but providing platform_data in this case should be the correct way, anyway.

So Chris, if you are already at it, do it this way. Otherwise please
notify me and I can prepare patches.

Thanks for your work!

Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
