From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jan 2012 16:07:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (lm63) Add support for external
Message-Id: <20120110170712.1d0ab548@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  9 Jan 2012 19:41:59 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> LM63 and compatibles support a temperature offset register for the external
> temperature sensor. Add support for it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm63.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> (...)

Already reviewed and in my patch queue.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
