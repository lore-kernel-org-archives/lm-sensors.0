From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf
Message-Id: <ver261p3du8josbf5tb7skkrdnhi6e1tfk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 16 Apr 2005 20:17:01 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>+	} else {
>+		unsigned int reg = 1350000U / val;
>+
>+		/* Automatically pick the best divider, i.e. the one such
>+		   that the min limit will correspond to a register value
>+		   in the 96..192 range */
>+		new_div = 0;
>+		while (reg > 192) {
>+			reg >>= 1;
>+			new_div++;
>+		}
>+		data->fan_min[nr] = reg;
>+	}

This part of your code produces an error, as it fails to check for 
for going one step too far in fan clock divider.

Cheers,
Grant.
