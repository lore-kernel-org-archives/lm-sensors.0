From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 21:15:37 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/3] hwmon: (hwmon-vid) Fix checkpatch issues
Message-Id: <20120131221537.219231d8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jan 2012 04:43:33 -0800, Guenter Roeck wrote:
> Fixed:
> ERROR: code indent should use tabs where possible
> ERROR: space required before the open parenthesis '('
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Not fixed (url):
> WARNING: line over 80 characters
> (...)

Looks alright, but for some reason this patch won't apply here.
Nevertheless:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
