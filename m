From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 17 Feb 2011 17:26:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) add support for AMD
Message-Id: <20110217172639.GA19982@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D5CDAD0.7030006@ladisch.de>
In-Reply-To: <4D5CDAD0.7030006@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 17, 2011 at 03:22:40AM -0500, Clemens Ladisch wrote:
> Add the PCI ID to support the internal temperature sensor of the
> AMD "Llano" and "Brazos" processor families.
> 
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>

Applied, thanks.

Since it meets the requirements for a stable patch, I applied it to the
patch list for 2.6.38 and added Cc: stable@kernel.org.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
