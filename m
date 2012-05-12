From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 May 2012 15:39:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (it87) Convert to use devm_kzalloc and devm_request_region
Message-Id: <20120512173951.1c9651b0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336772553-12823-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1336772553-12823-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 May 2012 14:42:32 -0700, Guenter Roeck wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> This makes the code a bit simpler and smaller.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Also convert devm_request_region for further simplification
> 
>  drivers/hwmon/it87.c |   32 +++++++++-----------------------
>  1 files changed, 9 insertions(+), 23 deletions(-)
> (...)

Looks good.

Acked-by: Jean Delvare <khali@linux-fr.org>

It might make sense to rename ERROR4 to something more meaningful? With
only this label remaining, the name looks obscure.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
