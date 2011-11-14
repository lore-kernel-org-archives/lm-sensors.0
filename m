From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Nov 2011 13:04:22 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: (pmbus) Fix two issues
Message-Id: <20111114140422.66a4cdb3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321260348-12341-1-git-send-email-Yuantian.Tang@freescale.com>
In-Reply-To: <1321260348-12341-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 14 Nov 2011 16:45:48 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <B29983@freescale.com>
> 
> 1. For PMBus device, we should use i2c_smbus_read_i2c_block_data
> to read block data.
> 2. Skip first byte when comparing device id string.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> V2:
> 	- modified description.
> 	- modified the issue 2.

Still nack, for the reasons explained before.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
