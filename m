From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 15 Jun 2009 12:46:45 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: Add driver tmp421
Message-Id: <4A3642B5.8030402@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090615074254.GA4667@ubuntu>
In-Reply-To: <20090615074254.GA4667@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 06/15/2009 09:42 AM, Andre Prendel wrote:
> Hello Jean, hello Hans,
>
> here is the tmp421 driver. It supports TI's TMP421/422/423 chips. I've
> tested the driver with Hans' great welcome gift, the
> tiny-usb-adapter. Further I played a bit with the dump to test remote
> sensors, extended temperature range, etc.
>

Hi Andre,

Both patches look fine to me, good work!

As for the extra checks during probe, I think not having those is fine.

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
