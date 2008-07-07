From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jul 2008 11:25:28 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs
Message-Id: <20080707132528.0006a2b9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
In-Reply-To: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  7 Jul 2008 06:40:09 -0400, Andrew Paprocki wrote:
> This patch only creates the pwmN_enable, pwmN, and pwmN_freq
> sysfs interface files if the corresponding fanN is enabled by
> the chip.

Nack. PWM1 may control fan2, etc.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
