From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Mar 2013 11:59:01 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (pmbus/ltc2978) Fix temperature reporting
Message-Id: <20130314125901.55dbb47b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1362069993-9530-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 Feb 2013 08:46:30 -0800, Guenter Roeck wrote:
> On LTC2978, only READ_TEMPERATURE is supported. It reports
> the internal junction temperature. This register is unpaged.
> 
> On LTC3880, READ_TEMPERATURE and READ_TEMPERATURE2 are supported.
> READ_TEMPERATURE is paged and reports external temperatures.
> READ_TEMPERATURE2 is unpaged and reports the internal junction
> temperature.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for -stable.

Agreed.

> 
> v3: Reduce to strictly fixes only
> (...)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
