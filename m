From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Feb 2008 19:07:19 +0000
Subject: Re: [lm-sensors] [PATCH] Update: Add driver for AD7414 i2c
Message-Id: <20080219200719.0ebc7daa@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00008096EC6@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00008096EC6@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Feb 2008 13:45:11 -0500, Sean MacLennan wrote:
> Jean Delvare wrote:
> >
> >> +	/* Register values */
> >> +	u16			temp_input;
> >> +	u8			temp_max;
> >> +	u8			temp_min;
> >>     
> >
> > Temperature values can be negative, so these should be s16 and s8
> > respectively.
> >
> >   
> I think these are fine as is. They are the raw values back from the chip 
> and are always passed through  AD7414_TEMP_FROM_REG.

temp_input is passed through AD7414_TEMP_FROM_REG(); temp_max and
temp_min aren't. So, the driver would fail to report negative limits
properly.

> Good catch on the simple_strtoul. I only tested positive values since 
> the taco will only be dealing in positive values.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
