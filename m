From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 31 Mar 2010 15:45:32 +0000
Subject: Re: [lm-sensors] [PATCH] V3, TI ads7871 a/d converter,
Message-Id: <20100331174532.3a17c87e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
In-Reply-To: <1269124170-11623-1-git-send-email-pthomas8589@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

On Wed, 31 Mar 2010 15:52:57 +0100, Jonathan Cameron wrote:
> There are a few things I'd like to see in addition, but
> they can easily occur later in an incremental patch...
> > (...)
> > +	if (mux_cnv = 0) {
> > +		val = ads7871_read_reg16(spi, REG_LS_BYTE);
> > +		/*result in volts*10000 = (val/8192)*2.5*10000*/
> > +		val = ((val>>2) * 25000) / 8192;
> > +		return sprintf(buf, "%d\n", val);
> > +	} else {
> This shouldn't have gotten through check patch.  You never have 
> brackets round a single line like this.  Should be,
> 
> } else
> 	return -1;

Some developers don't like it when the if branch has braces and the
else branch doesn't, or vice-versa. For this reason, checkpatch no
longer complains about single line branches using braces as long as at
least one other branch needs braces (which is the case here.)

> sizeof(*pdata) is neater.
> > +	pdata = kzalloc(sizeof(struct ads7871_data), GFP_KERNEL);

I beg to disagree. It's really a matter of personal taste. I prefer
sizeof(struct foo) because you can't accidentally ask for the size of
the pointer that way. In the end there is no consensus, which is why
checkpatch doesn't complain either way.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
