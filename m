From: Richard Retanubun <RichardRetanubun@RuggedCom.com>
Date: Thu, 18 Nov 2010 17:45:34 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <4CE5663E.5060400@RuggedCom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5595B.60300@RuggedCom.com>
In-Reply-To: <4CE5595B.60300@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I can not comment on ltc4215 behavior, but ltc4261 tends to have alarm bits
> set after boot. To display that would simply add noise and not provide any value.
> If the ltc4215 does the same, adding the log message would only (and unnecessarily)
> cause users to be concerned. This in turn would subject the mailing list, and thus
> the maintainers, to e-mails such as "I get this message during boot, is this
> a problem ?".
>
> I don't like the proposed change, unless someone can convince me that it adds value
> and not just noise (and maybe volunteers to forever reply to the resulting e-mails).
>
Agreed, the print at boot may not be a good idea, I am working on adding this as
an attribute that can be checked via sysfs and stop printing this at boot.

> So the EN bit changed state, which might just mean that the chip was enabled at some point
> in the past. What would be the value of displaying that information ?

Consider this scenario:
If the SW reboots the system, and it does so by toggling EN-bit when this happens the ltc4125 cuts out the voltage it is regulating and (most) of the components reboots,
but because it is still alive (its VDD is still good) it will set the EN-toggled-bit, which will be detected at next-boot.

If the system actually loses power, the ltc4215 itself is powered down, and at next-boot the EN-toggle-bit will not be set.

Using this, one can differentiate a "SW-reboot" Vs "A real power-down because external power is cut lost"

> If you want to do anything, you might consider displaying the _current_ EN state
I am considering displaying both the fault-reg value at boot and its current one in the sysfs access method.

> if the chip is disabled, or maybe not even instantiate the driver in the first place
> if that is the case.
>
> Thanks,
> Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
