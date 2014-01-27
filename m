From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Jan 2014 14:39:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Fix driver to work on standard PCs with CONFIG_REGULATOR enab
Message-Id: <52E66FAB.5000203@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390777731-10277-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1390777731-10277-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/27/2014 12:14 AM, Jean Delvare wrote:
> On Sun, 26 Jan 2014 20:21:00 -0800, Guenter Roeck wrote:
>> On 01/26/2014 03:08 PM, Guenter Roeck wrote:
>>> On Ubuntu systems with CONFIG_REGULATOR enabled, the lm90 driver fails to load
>>> with an error mesage such as
>>>
>>> i2c 1-0018: Driver lm90 requests probe deferral
>>>
>>> This is a result of commit 3e0f964f2ad (hwmon: (lm90) Add power control)
>>> which adds mandatory regulator support to the lm90 driver. On non-dt systems
>>> with CONFIG_REGULATOR enabled, this fails if regulators are not fully
>>> specified. This is the case on a standard PC system.
>>>
>> Mark appears to object to that idea, so maybe we should just just revert
>> 3e0f964f2ad until a more acceptable solution is found.
>
> Well, I object as well, so I'm happy to not apply it. I hate seeing
> IS_ENABLED() creep into driver code. Any issue like that should be
> handled as a Kconfig dependency or with a better API.
>



Going back to the original problem, lm90 no longer works in any non-DT
system which has CONFIG_REGULATORS enabled, such as any Ubuntu distribution.

I agree that it would have been better if the regulator subsystem would deal
with the issue, but that seems unlikely to happen. If anything, it will get
worse with the assumption that regulators are fully declared in any ACPI
based system (such a system for sure won't know about an USB-I2C adapter
with an LM90 connected to it). So what do you want to do ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
