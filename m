From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Oct 2012 23:37:58 +0000
Subject: Re: [lm-sensors] [PATCH v5 2/2] hwmon: (ads7828) add support for ADS7830
Message-Id: <20121003233758.GC21410@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1349297648-19843-1-git-send-email-vivien.didelot@savoirfairelinux.com>
 <1349297648-19843-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1349297648-19843-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, Steve Hardy <shardy@redhat.com>

On Wed, Oct 03, 2012 at 04:54:08PM -0400, Vivien Didelot wrote:
> From: Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
> 
> The ADS7830 device is almost the same as the ADS7828,
> except that it does 8-bit sampling, instead of 12-bit.
> This patch extends the ads7828 driver to support this chip.
> 
> Signed-off-by: Guillaume Roguez <guillaume.roguez@savoirfairelinux.com>
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
