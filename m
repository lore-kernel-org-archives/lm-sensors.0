From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Dec 2006 20:25:50 +0000
Subject: [lm-sensors] [patch 2.6.most] hwmon should subsys_init
Message-Id: <20061221212550.515503ca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612210437.04299.david-b@pacbell.net>
In-Reply-To: <200612210437.04299.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Dec 2006 04:37:03 -0800, David Brownell wrote:
> Subsystem infrastructure should normally register with "subsys_initcall",
> so that it's available to drivers that may need to initialize early.
> 
> This patch updates "hwmon" to do so.  It's common for embedded systems to
> have multifunction chips with hardware monitoring interfaces, and to have
> those chips be used during system bringup ... before a normal "module_init"
> would kick, or maybe just linked so they'd init before hwmon.
> 
> Signed-off-by: David Brownell <dbrownell at users.sourceforge.net>
> 
> Index: at91/drivers/hwmon/hwmon.c
> =================================> --- at91.orig/drivers/hwmon/hwmon.c	2006-04-06 18:30:25.000000000 -0700
> +++ at91/drivers/hwmon/hwmon.c	2006-12-21 03:16:13.000000000 -0800
> @@ -101,7 +101,7 @@ static void __exit hwmon_exit(void)
>  	class_destroy(hwmon_class);
>  }
>  
> -module_init(hwmon_init);
> +subsys_initcall(hwmon_init);
>  module_exit(hwmon_exit);
>  
>  EXPORT_SYMBOL_GPL(hwmon_device_register);

Applied, thanks.

-- 
Jean Delvare

