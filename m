From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jan 2012 16:52:21 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (lm63) Add support for unsigned
Message-Id: <20120110175221.171b47a3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326166923-11187-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326166923-11187-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  9 Jan 2012 19:42:01 -0800, Guenter Roeck wrote:
> From: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> LM96163 supports unsigned upper limits for the external temperature sensor.
> Add support for it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

I'm a bit confused by this double signed-off-by statement. What's the
point?

> ---
>  drivers/hwmon/lm63.c |   62 +++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 51 insertions(+), 11 deletions(-)
> (...)

Looks OK. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
