From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Oct 2012 15:12:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/err.h>
Message-Id: <20121003151215.GB19625@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121003131908.3a36fe3a@endymion.delvare>
In-Reply-To: <20121003131908.3a36fe3a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 03, 2012 at 01:37:15PM +0200, Jean Delvare wrote:
> These drivers use IS_ERR so they should include <linux/err.h>.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Henrik Rydberg <rydberg@euromail.se>
> Cc: Luca Tettamanti <kronos.it@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
