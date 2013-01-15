From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 15 Jan 2013 19:36:11 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (sht15) check GPIO directions
Message-Id: <20130115193611.GA22507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1358274786-30521-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1358274786-30521-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

On Tue, Jan 15, 2013 at 01:33:06PM -0500, Vivien Didelot wrote:
> Without this patch, the SHT15 driver may fail silently with a
> non-bidirectional data line and/or an input-only clock line.
> 
> This patch checks the return value of gpio_direction_* function calls
> and returns the error code (if any) to the caller. If an error occurs in
> the read work function (work_funct_t), we wake the queue up directly
> without updating the data->state flag, to notice the waiter of the I/O
> error.
> 
> The patch also makes minor cleanups: s/error_ret/unlock for some labels
> and uses devm_gpio_request_one() for the clock line.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
