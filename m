From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Dec 2006 13:53:59 +0000
Subject: [lm-sensors] [PATCH] ad7418 driver
Message-Id: <20061224145359.092d12e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112153724.3e630d32@inspiron>
In-Reply-To: <20061112153724.3e630d32@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 24 Dec 2006 12:41:54 +0100, Jean Delvare wrote:
> On Sun, 12 Nov 2006 15:37:24 +0100, Alessandro Zummo wrote:
> > +config SENSORS_AD7418
> > +	tristate "Analog Devices AD7417/18"
> > +	depends on HWMON && I2C && EXPERIMENTAL
> > +	help
> > +	  If you say yes here you get support for the Analog Devices AD7417
> > +	  and AD7418 chips.
> 
> As said above, you don't actually support the AD7417. The driver might
> load, but it'll export more features than the device has, it'll select
> channels that don't exist, etc. So I wouldn't advertise the AD7147 as
> supported for now.

After reading the datasheet once more, I realize I was confused here:
you actually support the AD7417 (4 voltage inputs), and not the AD7418
(1 voltage input). My comment still holds, though.

-- 
Jean Delvare

