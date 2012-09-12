From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Sep 2012 16:30:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) move header to linux/platform_data/
Message-Id: <20120912163024.GA23096@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347467024-3231-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1347467024-3231-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 12, 2012 at 12:23:44PM -0400, Vivien Didelot wrote:
> This patch moves the sht15.h header from include/linux to
> include/linux/platform_data, and update existing support (stargate2
> platform) accordingly.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next, and fixed:

/home/groeck/src/linux-staging/.git/rebase-apply/patch:80: new blank line at
EOF.
+
warning: 1 line adds whitespace errors.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
