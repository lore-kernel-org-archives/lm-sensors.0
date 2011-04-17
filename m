From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Apr 2011 20:54:52 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Driver for MAX16065 System
Message-Id: <20110417225452.79e2badb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1303063632-31864-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1303063632-31864-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 17 Apr 2011 11:07:12 -0700, Guenter Roeck wrote:
> This patch adds hardware monitoring support for Maxim MAX16065, MAX16066,
> MAX16067, MAX16068, MAX16070, and MAX16071 flash-configurable system managers
> with nonvolatile fault registers.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Reviewed-by: Jean Delvare <khali@linux-fr.org>
> ---
> Note: I had planned to add support for MAX16047 and MAX16049. That did not
> work out; register functionality is the same, but register addresses are
> different.
> 
> v4:
> (...)

Looks very good now. Great work!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
