From: David Anderson <davea42@gmail.com>
Date: Sun, 03 Nov 2013 20:10:39 +0000
Subject: Re: [lm-sensors] w83795.c no longer compiles
Message-Id: <5276ADBF.4060102@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5273CD89.6030803@gmail.com>
In-Reply-To: <5273CD89.6030803@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/03/2013 11:37 AM, Jean Delvare wrote:
> Hi David, Guenter,


... older part of the conversation deleted.
> The drivers in http://khali.linux-fr.org/devel/lm-sensors/drivers/ are
> all snapshots of the respective upstream driver at some point in time,
> to which I added some compatibility glue so that it build for a range
> of older kernels. I update them manually as my time permits and needs
> arise, which means that they are all lagging behind most of the time,
> by construct.
>
> For example, "my" w83795 driver is currently based on the upstream
> driver from kernel 2.6.36.1 (doh, this is so old) with enough
> compatibility glue to work with kernels down to 2.6.27.
>
> In most cases, this shouldn't be a problem, because if you're running a
> very recent kernel, you shouldn't need to use a standalone driver in
> the first place, the upstream driver should work just fine. Which
> brings a question to David: why are you not just using the driver which
> comes with your kernel?

I should have thought of that earlier.

>
> In the case of the w83795 driver I admit it is about time to remove all
> the dust because it's indeed very old...
>
So lets try it now:

Rebooted and "sensors" did not show the proper details, as usual.
I used sensors-detect and the I2C/SMBus Adapter detection found
SMBus I801 adapter at 0400 (i2c-0)
which found
    Nuvoton W83795G/ADG

I said yes to adding lines to /etc/modules
and ran "service kmod start" as sensors detect started
and sensors worked right.

Rebooted again.
And now I get sensors working properly automatically on reboot.
Yay!

Thanks again.
David Anderson




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
