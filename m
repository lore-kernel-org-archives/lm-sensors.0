From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: Setting w83627hf fan divisor 128 fails.
Message-Id: <20050512183308.713a7ee7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9lj58114ceoef48hfo6lect8u0m38hc0ai@4ax.com>
In-Reply-To: <9lj58114ceoef48hfo6lect8u0m38hc0ai@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Jarkko Lavinen provided patch to fix: "couldn't set the divisor 128 
> through fan1_div sysfs entry even though the chip supports it and 
> setting divisors 1..64 worked. This was due to POWER_TO_REG() only 
> checking 2's powers 0 till 5 but not 6."
>  
> This patch applies that fix to w83627hf and w83781d drivers. 

Applied, thanks.

-- 
Jean Delvare
