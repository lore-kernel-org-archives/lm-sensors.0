From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Jun 2015 07:26:35 +0000
Subject: Re: [lm-sensors] Dealing with optional i2c devices in a devicetree
Message-Id: <2658431.5aULpGi9jh@wuerfel>
List-Id: <lm-sensors.vger.kernel.org>
References: <55713BB1.80004@alliedtelesis.co.nz>
In-Reply-To: <55713BB1.80004-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jdelvare-l3A5Bk7waGM@public.gmane.org" <jdelvare-l3A5Bk7waGM@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <shardy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org" <guillaume.roguez-4ysUXcep3aM1wj+D4I0NRVaTQe2KTcn/@public.gmane.org>

On Friday 05 June 2015 06:03:30 Chris Packham wrote:
> 
> Is there a better way of getting the devicetree machinery to avoid the 
> call to the driver probe function in the first place?
> 
> 

The newly added DT overlay support should do what you need, but it might
not be the easiest solution.

To start out with the device not getting probed at first, add a
'status="disabled"' property, which will prevent the i2c_device from
getting added. At runtime you then need a way to change that from
"disabled" to "ok" and retrigger the probe. I haven't done that myself,
so it might need some i2c core changes to work correctly.

	Arnd

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
