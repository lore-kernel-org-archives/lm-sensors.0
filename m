From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Feb 2013 09:23:41 +0000
Subject: Re: [lm-sensors] [PATCH 3/7] hwmon: (pmbus/ltc2978) Fix peak attribute inizialization and clearing
Message-Id: <20130227102341.45586746@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361585975-5604-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361585975-5604-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 26 Feb 2013 15:32:33 -0800, Guenter Roeck wrote:
> Subject: [PATCH v2 3/7] hwmon: (pmbus/ltc2978) Fix peak attribute handling
> 
> Peak attributes were not initialized and cleared correctly.
> Also, temp2_max is only supported on page 0 and thus does not need to be
> an array.

Doing both in the same patch will make it harder to get it in stable.
The second change is clearly a clean up not a bug fix.

But other than this it looks good:

Acked-by: Jean Delvare <khali@linux-fr.org>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable.
> 
> v2: Fix still wrong initializations.
>     temp2_max is only supported/used on page 0 and does not have to be an array.
> 
>  drivers/hwmon/pmbus/ltc2978.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
