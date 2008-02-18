From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 09:50:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: normal_i2c arrays should be const
Message-Id: <20080218105023.4165c693@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218033459.GB29415@jupiter.solarsys.private>
In-Reply-To: <20080218033459.GB29415@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sun, 17 Feb 2008 22:34:59 -0500, Mark M. Hoffman wrote:
> commit 556782f2a261fe87d3aa820d24116660b16f3192
> Author: Mark M. Hoffman <mhoffman@lightlink.com>
> Date:   Sun Feb 17 22:28:03 2008 -0500
> 
>     hwmon: normal_i2c arrays should be const
>     
>     Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
> 

Looks good to me from a functional point of view.

Acked-by: Jean Delvare <khali@linux-fr.org>

Note though that checkpatch spits the following warnings, which you may
want to fix:

WARNING: line over 80 characters
#108: FILE: drivers/hwmon/adm1021.c:35:
+                                               0x4c, 0x4d, 0x4e, I2C_CLIENT_END };

WARNING: line over 80 characters
#420: FILE: drivers/hwmon/lm83.c:52:
+                                               0x4c, 0x4d, 0x4e, I2C_CLIENT_END };

WARNING: line over 80 characters
#463: FILE: drivers/hwmon/lm90.c:105:
+                                               0x4c, 0x4d, 0x4e, I2C_CLIENT_END };

WARNING: line over 80 characters
#508: FILE: drivers/hwmon/max1619.c:41:
+                                               0x4c, 0x4d, 0x4e, I2C_CLIENT_END };

total: 0 errors, 4 warnings, 353 lines checked

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
