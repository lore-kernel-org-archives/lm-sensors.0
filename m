From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Jun 2013 18:38:19 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (adm1021) Strengthen chip detection for ADM1021, LM84 and MAX1617
Message-Id: <20130607203819.4d509f67@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370624754-6832-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370624754-6832-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  7 Jun 2013 10:05:54 -0700, Guenter Roeck wrote:
> On a system with both MAX1617 and JC42 sensors, JC42 sensors can be misdetected
> as LM84. Strengthen detection sufficiently enough to avoid this misdetection.
> Also improve detection for ADM1021.
> 
> Modeled after chip detection code in sensors-detect command.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> rearrange register reads and error checks to catch read errors earlier

Tested-by: Jean Delvare <khali@linux-fr.org>
Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
