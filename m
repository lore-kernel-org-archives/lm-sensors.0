From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Aug 2015 15:25:11 +0000
Subject: Re: [lm-sensors] applesmc: about polling device and interrupt
Message-Id: <55BCE4D7.7010706@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/29/2015 05:51 AM, Matthieu Gautier wrote:
> Hi,
>
> I've recently get a macbook pro and I'm running a Fedora 22 (kernel
> 4.0.8-300.fc22.x86_64) on it.
>
> I'm looking to improve the power consumption, and I've found that
> applesmc continuously use 5% of CPU (and a bit less than a 1W).
>
> After investigation, it seems that the problem come from the motion
> sensor polling (at 50 ms interval) (see applesmc_idev_poll function)
>
> The sensor functionality is primarily intend to detect laptop fall and
> shutdown HDD before the shock.
>
> Matthew Garret sent a patch in 2011
> (http://thread.gmane.org/gmane.linux.drivers.sensors/26911/focus&960)
> to use interrupt to get free fall/high acceleration/shock information.
> This patch has been rejected cause a lack of use case for them. Shutting
> down the HDD could be a use case.
>
Sure is, and no problem with that. The reason for rejecting the patch was
that all it does was to dump some message on the console if an interrupt
occurred, which did not provide any value at all.

> This is already in use through /dev/freefall. (see
> Documentation/laptops/freefall.c for use case and
> drivers/platform/x86/dell-smo8800.c for a implementation)
>
> I understand that we may need polling the device to get motion input,
> but I don't use motion in user space and I prefer not using my CPU for
> nothing.
>
Separate problem, though, isn't it ?

Alternatively, if the interrupt handler can replace the polling, I would
be all for it.

> Maybe it would be useful to separate the motion sensor code in a
> different module (or using a dynamic configuration) to be able to have
> this functionality only when we want it.
>
>
> I'm ready to make patches to add /dev/freefall handling base on Matthew
> Garret patch and move sensor detection to another module (or make it
> deactivable). But I would like to see with you before if you are ok with
> my proposition.
>
The driver should probably be split into multiple parts, with an mfd driver
as common core.

>
> Regards,
> Matthieu Gautier.
>
> PS, I'm pretty (totally) new into kernel patching. I understand quickly
> but you may have to explain longer :)
>
No worries.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
