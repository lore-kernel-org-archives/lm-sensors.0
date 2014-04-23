From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 23 Apr 2014 18:16:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: vexpress: Use legal hwmon device names
Message-Id: <20140423181624.GA30121@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1398274025-13618-2-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1398274025-13618-2-git-send-email-pawel.moll@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 23, 2014 at 06:27:04PM +0100, Pawel Moll wrote:
> The driver used to directly us a DT 'compatible' property for
> the 'name' attribute of the hwmon devices. Unfortunately it
> contains '-' which is illegal in this context. It messes up
> libsensors and thus every application using it.
> 
> Fixed by providing equivalent (and simpler) name strings.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Hi Pawel,

can you use hwmon_device_register_with_groups() to register
the hwmon device ?  This would take care of the name attribute.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
