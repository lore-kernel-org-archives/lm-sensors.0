From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Jul 2009 15:33:48 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <20090709173348.5bec7f14@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lu,

On Thu, 9 Jul 2009 13:41:38 +0000, lu zhihe wrote:
> From: Lu Zhihe <tombowfly@gmail.com>
> 
> Subject: [PATCH] hwmon: add support for GM/GME965 IGP temperature report.
> 
> Exported the graphics hot spot temperature report via sysfs.
> 
> Signed-off-by: Lu Zhihe <tombowfly@gmail.com>
> ---
> (...)
> +static unsigned long chipset_ids[] = {
> +	PCI_DEVICE_ID_INTEL_82965GM,
> +	PCI_DEVICE_ID_INTEL_82965GME,
> +	0
> +};

These defines do not exist in the current kernel tree. I presume you
forgot to includes changes to include/linux/pci_ids.h?

I am also curious what these PCI devices are. We do not want to have
driver conflicts, so it might make more sense to add hardware
monitoring functionality to an existing driver than writing a brand new
driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
