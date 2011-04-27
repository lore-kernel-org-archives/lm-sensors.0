From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Apr 2011 14:17:13 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon/f71882fg: Add support for F71808A
Message-Id: <20110427161713.466d48de@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303393458-4001-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1303393458-4001-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Err, wait a minute...

On Thu, 21 Apr 2011 15:44:18 +0200, Hans de Goede wrote:
> @@ -164,6 +169,7 @@ static const char f71882fg_fan_has_beep[] = {
>  
>  static const char f71882fg_nr_fans[] = {
>  	[f71808e]	= 3,
> +	[f71808a]	= 2, /* +1 fan which is monitor + simple pwm only */
>  	[f71858fg]	= 3,
>  	[f71862fg]	= 3,
>  	[f71869]	= 3,

The values related to the extra fan are never read from the chip, are
they?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
