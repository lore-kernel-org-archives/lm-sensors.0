From: Chris <silverchris@gmail.com>
Date: Mon, 20 Feb 2012 22:14:17 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <CAO7tRnhHV-qYcmEpn2te=J2uPSXV6Q-8fXmiOG0GYdb2=MQYMQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The patches I just submitted fix the main issues with the driver on my
system. I didn't fix the variable initialization because it seems to
generate a warning when ever I move them closer to were they belong
in, it generates a compiler warning of "warning: ISO C90 forbids mixed
declarations and code". I am looking into how platform_data works to
see how it works to see if I can handle checking it and changing the
chip initialization to work with platform data if its provided and to
leave it alone if its not. Thanks for the patience with my patch
submissions, I am learning a lot from this

On Mon, Feb 20, 2012 at 1:58 PM, Roland Stigge <stigge@antcom.de> wrote:
> Hi!
>
> On 02/20/2012 06:39 PM, Guenter Roeck wrote:
>>> Please resubmit a (-p1) patch fixing the issue your originally spotted
>>> instead.
>>>
>> We really need input from Roland on the initialization problem.
>> Might make sense to kwwp him copied on this exchange.
>
> Thanks for your notification and sorry for the delay!
>
> Unfortunately, when I ported the driver from the other original author,
> I kept the initialization procedure which is obviously wrong, doing
> initialization only for one channel. (I adjusted the driver locally
> platform-dependent, so didn't find a chance for mainline integration and
> this way, the obvious problems in the mainline driver slipped.)
>
> Therefore, a fix for doing this for both channels, possibly in a loop,
> would be good, IMO.
>
> Jean's note about the broken variable initialization is correct. Should
> have done this differently.
>
> The other note about initialization only with platform_data is also a
> good idea.
>
> I'm using the chip on a custom ARM board without BIOS initialization,
> but providing platform_data in this case should be the correct way, anyway.
>
> So Chris, if you are already at it, do it this way. Otherwise please
> notify me and I can prepare patches.
>
> Thanks for your work!
>
> Roland

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
