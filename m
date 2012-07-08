From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Jul 2012 17:06:41 +0000
Subject: Re: [lm-sensors] [PATCH 1/4][update] hwmon / abituguru: Use struct dev_pm_ops for power management
Message-Id: <20120708170641.GB16423@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201207072302.16491.rjw@sisk.pl>
 <201207072304.10067.rjw@sisk.pl>
 <201207072359.12439.rjw@sisk.pl>
In-Reply-To: <201207072359.12439.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Kukjin Kim <kgene.kim@samsung.com>

On Sat, Jul 07, 2012 at 11:59:12PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: hwmon / abituguru: Use struct dev_pm_ops for power management
> 
> Make the Abit uGuru driver define its PM callbacks through
> a struct dev_pm_ops object rather than by using legacy PM hooks
> in struct platform_driver.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
