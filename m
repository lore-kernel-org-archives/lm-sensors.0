From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Jun 2013 16:07:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1021) Do not create min sysfs attributes for LM84
Message-Id: <20130607180728.42f4e5a4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370620280-32415-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370620280-32415-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri,  7 Jun 2013 08:51:19 -0700, Guenter Roeck wrote:
> LM84 does not support minimum temperature registers.
> Only create the respective sysfs attributes for other chips.

Did you consider implementing this with .is_visible()? This might
result in a smaller binary.

Other than that, this looks good:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
