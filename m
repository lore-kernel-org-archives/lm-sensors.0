From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 18 Apr 2011 07:33:12 +0000
Subject: Re: [lm-sensors] [PATCH v6 1/2] Use "request_muxed_region" in it87
Message-Id: <4DABE938.6020400@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302816996-6345-1-git-send-email-natg@google.com>	<1302817069-6389-1-git-send-email-natg@google.com>	<1302821370.26780.585.camel@groeck-laptop>	<BANLkTin6M0R4d+HMovbRwqthSHowUEKFow@mail.gmail.com>	<20110415024005.GA21642@ericsson.com>	<BANLkTi=t+AgRU47DhKoGOJ2mTa6AVfaPVw@mail.gmail.com>	<20110415055852.GA21905@ericsson.com> <BANLkTi=464Q8z7GzDZw9Mb-j-L4O0bPRjg@mail.gmail.com>
In-Reply-To: <BANLkTi=464Q8z7GzDZw9Mb-j-L4O0bPRjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Wim Van Sebroeck <wim@iguana.be>, Mike Waychison <mikew@google.com>

Hi,

On 04/15/2011 10:46 AM, Natarajan Gurumoorthy wrote:
> On Thu, Apr 14, 2011 at 10:58 PM, Guenter Roeck
> <guenter.roeck@ericsson.com>  wrote:
>> I have seen the list. I don't think you should fix everything in one go.
>> First step might be to get the w83697hf and it87 to work together, then
>> go from there.
>>
>> Is there a reason for loading (or trying to load) both the it87 and
>> the w83697hf driver at the same time ? Those drivers are usually only
>> loaded if the respective chip is known to exist. If there is no reason
>> to try loading both drivers, a simple workaround would be to not do it.
>>
> Guenter,
>        I agree the above should never happen. The only way the 2
> drivers will be loaded at the same time is a misconfigured kernel
> where these 2 drivers get built and the rc scripts end up loading them
> too. If we are agreed that I suggest we make the superio_enter routine
> be the following:
>
> static inline void
> superio_enter(void)
> {
> 	/*
> 	 * Reserve REG and REG + 1 for exclusive access.
> 	 */
> 	while (!request_muxed_region(REG, 2, WATCHDOG_NAME))
> 		continue;
>

Natajaran,

Please stop being so stubborn. XXX people have told you not to put a
while loop here, but simply to check for an error and propagate
it (in all places where superio_enter gets called).

Your bogus argument of the driver then failing to load when another
non muxed superio driver loads is really far fetched. No system ever
has 2 super io chips. So as long as all ite drivers use the muxed
version all will be fine.

And if some unforeseen scenario happens where the request_muxed_region
fails, we will get a bug report about a driver failing to load (*). Which
is a lot better for the end user then being stuck in an endless loop.

Regards,

Hans

*) And deal with that then.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
