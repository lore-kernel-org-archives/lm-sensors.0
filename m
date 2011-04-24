From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 24 Apr 2011 08:44:24 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asc7621) Drop duplicate dependency
Message-Id: <20110424084424.GA9032@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110424091937.02f4943e@endymion.delvare>
In-Reply-To: <20110424091937.02f4943e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 24, 2011 at 03:19:37AM -0400, Jean Delvare wrote:
> The config SENSORS_ASC7621 entry is inside an if HWMON / endif block,
> so it already depends on HWMON.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
