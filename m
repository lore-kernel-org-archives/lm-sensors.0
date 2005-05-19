From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf
Message-Id: <20050416230013.6e3b7554.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> >+	} else {
> >+		unsigned int reg = 1350000U / val;
> >+
> >+		/* Automatically pick the best divider, i.e. the one such
> >+		   that the min limit will correspond to a register value
> >+		   in the 96..192 range */
> >+		new_div = 0;
> >+		while (reg > 192) {
> >+			reg >>= 1;
> >+			new_div++;
> >+		}
> >+		data->fan_min[nr] = reg;
> >+	}
> 
> This part of your code produces an error, as it fails to check for 
> for going one step too far in fan clock divider.

Good catch. I thought that the "if" clause was handling that case, but
there is a small window (42 to 54 RPM or so) which will go through and
actually result in an invalid divider (256), you're correct.

I also noticed that the "if" clause would fail to catch 41 RPM as it
should, so I fixed it by using a less error-prone test.

I now have:

	if (!val) {
		/* No min limit, alarm disabled */
		data->fan_min[nr] = 255;
		new_div = data->fan_div[nr]; /* No change */
	} else if ((reg = 1350000U / val) >= 128 * 255) {
		/* Speed below this value cannot possibly be represented,
		   even with the highest divider (128) */
		data->fan_min[nr] = 255;
		new_div = 7; /* 128 = (1 << 7) */
	} else {
		/* Automatically pick the best divider, i.e. the one such
		   that the min limit will correspond to a register value
		   in the 96..192 range */
		new_div = 0;
		while (reg > 192 && new_div < 7) {
			reg >>= 1;
			new_div++;
		}
		data->fan_min[nr] = reg;
	}

Looks OK now?

Thanks,
-- 
Jean Delvare
