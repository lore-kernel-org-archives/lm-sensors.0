From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Jan 2013 03:43:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) avoid CamelCase
Message-Id: <20130108034356.GA11958@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1357586319-2089-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1357586319-2089-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

On Mon, Jan 07, 2013 at 02:18:38PM -0500, Vivien Didelot wrote:
> This patch renames the supply_uV* variables to supply_uv* to avoid
> CamelCase as warned by the checkpatch.pl script.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
