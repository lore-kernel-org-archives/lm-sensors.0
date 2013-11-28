From: David Miller <davem@davemloft.net>
Date: Thu, 28 Nov 2013 23:22:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] tg3: Convert to use hwmon_device_register_with_groups
Message-Id: <20131128.182228.1780515135706805369.davem@davemloft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
	<1385186881-7931-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385186881-7931-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: netdev@vger.kernel.org, jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com, bruce.w.allan@intel.com, carolyn.wyborny@intel.com, donald.c.skidmore@intel.com, gregory.v.rose@intel.com, nsujir@broadcom.com, mchan@broadcom.com, e1000-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 22 Nov 2013 22:07:57 -0800

> Use new hwmon API to simplify code, provide missing mandatory 'name'
> sysfs attribute, and attach hwmon attributes to hwmon device instead
> of pci device.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thanks.

Jeff Kirsher will pull the rest of this series in via his Intel ethernet
driver tree.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
