From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Feb 2012 10:42:37 +0000
Subject: Re: [lm-sensors] [PATCH V4] hwmon: Add MCP3021 ADC driver
Message-Id: <20120221114237.5a6d99e7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329711239-11856-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1329711239-11856-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Feb 2012 09:52:09 +0000, Xie Xiaobo-R63061 wrote:
> > > +static inline u16 volts_from_reg(u16 vdd, u16 val) {
> > > +	if (val = 0)
> > > +		return 0;
> > > +
> > > +	val = val * MCP3021_OUTPUT_SCALE - MCP3021_OUTPUT_SCALE / 2;
> > > +
> > > +	return val * DIV_ROUND_CLOSEST(vdd,
> > > +			(1 << MCP3021_OUTPUT_RES) * MCP3021_OUTPUT_SCALE); }
> > 
> > I did not notice before, but can't this overflow? Say val = 0xfff0, 0xfff0 * 4 - 4 / 2
> > = 0x3ffbe, that doesn't fit in u16. I think you should introduce a local int variable
> > and return its value (as an int, not u16.)
> > 
> 
> I used the u16, because the val is from mcp3021_read16(), So the val always <= 0x3ff (I already defined MCP3021_SAR_MASK).

OK, you can ignore my comment then, sorry for the noise.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
