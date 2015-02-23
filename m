From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 23 Feb 2015 16:23:05 +0000
Subject: Re: [lm-sensors] [PATCH v4 7/8] hwmon: pwm-fan: Read PWM FAN configuration from device tree
Message-Id: <20150223162305.GB2165@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-8-git-send-email-l.majewski@samsung.com>
 <54E7D0B3.7040800@roeck-us.net>
 <20150223171336.2e09ce50@amdc2363>
In-Reply-To: <20150223171336.2e09ce50@amdc2363>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

On Mon, Feb 23, 2015 at 05:13:36PM +0100, Lukasz Majewski wrote:
> Hi Guenter,
> 
[ ... ]

> > 
> > If devicetree is not configured, of_property_count_elems_of_size
> > returns -ENOSYS, which is returned, causing the driver to fail
> > loading.
> 
> Has of_property_count_elems_of_size() returns -ENOSYS?
> 
> Maybe something has changed, but in my linux-vanila (3.19-rc4)
> at ./drivers/of/base.c it returns -EINVAL, -ENODATA or number of
> elements.
> 
> Have I missed something?
> 
Hi Lukasz,

Yes, you have. Check include/linux/of.h, line 484, in latest mainline.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
