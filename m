From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6] I2C: New hardware monitoring driver: w83627ehf
Message-Id: <qj3361d298bhv5a02cad9ja8ue3oujo63i@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416201701.7e4a5e74.khali@linux-fr.org>
In-Reply-To: <20050416201701.7e4a5e74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sat, 16 Apr 2005 23:00:13 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>
>Good catch. I thought that the "if" clause was handling that case, but
>there is a small window (42 to 54 RPM or so) which will go through and
>actually result in an invalid divider (256), you're correct.

It is a very small window at low speed end, took me ages to work it 
out and find the special case when I lifted your code :)

>I also noticed that the "if" clause would fail to catch 41 RPM as it
>should, so I fixed it by using a less error-prone test.
>
>I now have:
>
>	if (!val) {
>		/* No min limit, alarm disabled */
>		data->fan_min[nr] = 255;
>		new_div = data->fan_div[nr]; /* No change */
>	} else if ((reg = 1350000U / val) >= 128 * 255) {
>		/* Speed below this value cannot possibly be represented,
>		   even with the highest divider (128) */
>		data->fan_min[nr] = 255;
>		new_div = 7; /* 128 = (1 << 7) */
>	} else {
>		/* Automatically pick the best divider, i.e. the one such
>		   that the min limit will correspond to a register value
>		   in the 96..192 range */
>		new_div = 0;
>		while (reg > 192 && new_div < 7) {
>			reg >>= 1;
>			new_div++;
>		}
>		data->fan_min[nr] = reg;
>	}
>
>Looks OK now?

Yes, but is the (!val) test needed?  I'd merge it with next test 
like so:
	if (val < 1350000U / (128 * 254)) {

as same end result is to store 255 to fan_min.

Cheers,
Grant.
