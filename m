From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 02 Jun 2010 06:11:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) Do not blacklist known
Message-Id: <4C05F602.7060908@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100601184732.7a498112@hyperion.delvare>
In-Reply-To: <20100601184732.7a498112@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> When detecting AM2+ or AM3 socket with DDR2, only blacklist cores
> which are known to exist in AM2+ format.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Andreas Herrmann <andreas.herrmann3@amd.com>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> +	return boot_cpu_data.x86_model < 4 ||
> +	       (boot_cpu_data.x86_model = 4 && boot_cpu_data.x86_mask <= 2);
> +

but that empty line is superfluous


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
