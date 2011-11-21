From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 17:39:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Add support for external
Message-Id: <20111121183900.3a7d4fd9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321894365-24285-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321894365-24285-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Nov 2011 08:52:44 -0800, Guenter Roeck wrote:
> LM63 and compatibles support a temperature offset register for the external
> temperature sensor. Add support for it.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm63.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> (...)

Looks good. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
