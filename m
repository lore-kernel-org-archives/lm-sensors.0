From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Aug 2012 16:06:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (sht15) remove multiple driver registration
Message-Id: <20120831160604.GB5756@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346377579-24849-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1346377579-24849-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On Thu, Aug 30, 2012 at 09:46:19PM -0400, Vivien Didelot wrote:
> Declare an array of platform_device_id, instead of registering a driver
> for each supported chip. This makes the code cleaner.
> Also add a module description.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
