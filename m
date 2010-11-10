From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 10 Nov 2010 18:07:31 +0000
Subject: Re: [lm-sensors] [PATCH 05/11] hwmon: applesmc: Dynamic creation of
Message-Id: <20101110180731.GD18472@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289386685-9988-1-git-send-email-rydberg@euromail.se>
 <1289386685-9988-2-git-send-email-rydberg@euromail.se>
In-Reply-To: <1289386685-9988-2-git-send-email-rydberg@euromail.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 10, 2010 at 05:58:04AM -0500, Henrik Rydberg wrote:
> The current driver creates temperature files based on a list
> of temperature keys given per device. Apart from slow adaption
> to new machine models, the number of sensors also depends on
> the number of processors. This patch looks up the temperature
> keys dynamically, thereby supporting all models.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
