From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Feb 2011 18:08:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) add support for AMD
Message-Id: <20110217190838.381962f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5CDAD0.7030006@ladisch.de>
	<20110217172639.GA19982@ericsson.com>
In-Reply-To: <20110217172639.GA19982@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Clemens Ladisch <clemens@ladisch.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 17 Feb 2011 09:26:39 -0800, Guenter Roeck wrote:
> On Thu, Feb 17, 2011 at 03:22:40AM -0500, Clemens Ladisch wrote:
> > Add the PCI ID to support the internal temperature sensor of the
> > AMD "Llano" and "Brazos" processor families.
> > 
> > Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> 
> Applied, thanks.
> 
> Since it meets the requirements for a stable patch, I applied it to the
> patch list for 2.6.38 and added Cc: stable@kernel.org.

Can we have a sensors-detect patch too?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
