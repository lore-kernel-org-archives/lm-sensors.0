From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 08 Jun 2015 15:03:12 +0000
Subject: Re: [lm-sensors] Dealing with optional i2c devices in a devicetree
Message-Id: <5575AEB0.70807@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <55713BB1.80004@alliedtelesis.co.nz> <55714FFB.3000608@roeck-us.net> <55752FD4.6050700@alliedtelesis.co.nz> <55758667.70501@melag.de>
In-Reply-To: <55758667.70501-d/C+FbuhHiA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Enrico Weigelt, metux IT consult" <weigelt-d/C+FbuhHiA@public.gmane.org>, Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org" <guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>

On 06/08/2015 05:11 AM, Enrico Weigelt, metux IT consult wrote:
> Am 08.06.2015 um 08:01 schrieb Chris Packham:
>
> Hi folks,
>
>  > Sounds like my best bet is to mark the nodes as disabled in the
>  > dts and have my bootloader update them on the way through.
>
> In case your bootloader can take that decision (eg. if the device
> is present at boot time, and the bootloader has the proper probing
> logic or simply knows the device has to be there), that would be
> an pretty easy way.
>
>
> But let me add another usecase, which might be a bit more tricky:
>
> Let's assume we can plug in some more complex device, which consists
> of several (pretty standard) subdevices, behind certain bus'es (maybe
> it's attached via USB, and somewhere behind are some I2C bus'es with
> regulators, pwm-generators, etc).
>
> Let's further assume, we already got some DTS or some piece of memory
> with an DTB subtree for that device (eg. some simple bulk endpoint that
> just gives back a bunch of bytes with the DTB).
>
> Now, when the device is plugged in, I'd like to get that piece of DTB
> loaded and the corresponding drivers initialized. And, of course, when
> it's plugged-out, everything should be shut down cleanly.
>
> How could we achieve that ?
>

Use devicetree overlays.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
