From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 31 Jul 2013 22:13:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6697) fix MAX6581 ideality
Message-Id: <20130731221324.GB29618@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375218874-10882-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1375218874-10882-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

On Tue, Jul 30, 2013 at 05:14:34PM -0400, Vivien Didelot wrote:
> Without this patch, the values for ideality (register 0x4b) and ideality
> selection mask (register 0x4c) are inverted.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Good catch. Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
