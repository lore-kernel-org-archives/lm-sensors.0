From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 18 Sep 2010 13:34:33 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100918133433.GA26854@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
On Sat, Sep 18, 2010 at 07:56:01AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
[ ... ] 
> >  
> > +/*
> > + * type is either 1 or 2.
> > + * 1: index := index --> could use index + type - 1
> > + * 2: index := index + 1 --> could use index + type - 1
> > + * Suggestion:
> > + *  #define IN_LSB_REG(index, type) W83795_REG_IN_HL_LSB[(index + type - 1)]
> > + * or at least use type = IN_MAX instead of type = 1.
> > + */
> >  #define IN_LSB_REG(index, type) \
> >  	(((type) = 1) ? W83795_REG_IN_HL_LSB[(index)] \
> >  	: (W83795_REG_IN_HL_LSB[(index)] + 1))
> 
> I agree that (type) = 1 is ugly, given that all callers use symbolic
> values rather than numeric constants. I have a pending patch changing
> this and also reworking the handling of voltage LSBs at large, but it
> wasn't ready in time for this series.
> 
> But your optimization proposal is interesting too, although your actual
> implementation is bogus: we want [index] + 1, not [index + 1]. I will
> consider it, assuming it doesn't interfere with my pending changes.
> 
oops ... so it should have been

	#define IN_LSB_REG(index, type) W83795_REG_IN_HL_LSB[index] + type - 1)

[ ... ] 

> > +		 * But that causes lsb to be undefined across loop instances,
> > +		 * doesn't it, since it is only defined inside the loop ?
> > +		 * And what happens if an even fan does not exist
> > +		 * but the odd one does ?
> > +		 */
> >  		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
> >  			lsb = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
> >  
> 
> I don't see any problem with lsb being undefined. lsb is always set if
> it is going to be needed. I also don't see any problem with odd and
> even fans: lsb is set if _any_ fan in a given pair is present (see the
> 3 << i).
> 
> If you can think of a specific scenario where it doesn't work, please
> let me know. The code looks good to me.
> 
Looks like lsb survives across loop instances; at least the compiler doesn't complain 
about it. So I guess you are right.

[ ... ]

> >  
> > +	/* Those reversed comparisons always confuse me.
> > +	 * I think the compiler should refuse to compile 
> > +	 * such code to make me happy. And, no, I don't buy
> > +	 * the argument that the compiler magically produces
> > +	 * better code this way.
> > +	 * They are used in this driver to compare variables against
> > +	 * defined constants (though not all the time).
> > +	 * Direct value comparisons are (most of the time) the other way.
> > +	 * Any reason ?
> > +	 * Maybe I shouldn't even ask since this one always create a lot of
> > +	 * heated discussion. Let me know.
> > +	 */
> >  	if (FAN_INPUT = nr)
> >  		val = data->fan[index] & 0x0fff;
> >  	else
> 
> I fully agree with you. Again the code isn't mine.
> 
Would it make sense to add a cleanup patch on top of the other ones ?
I always find that such style issues are distracting, and make it difficult
to review it.

> > @@ -855,6 +890,13 @@ show_pwm_enable(struct device *dev, struct device_attribute *attr, char *buf)
> >  	int index = sensor_attr->index;
> >  	u8 tmp;
> >  
> > +	/* so we are talking about
> > +	 *  (index = 0 && (data->pwm_fcms[0] & 1)),
> > +	 * correct ? Or maybe
> > +	 *  (index = 0 && (data->pwm_fcms[0] & (1 << index))),
> > +	 * Seems to me that would be less confusing and actually be less
> > +	 * expensive.
> > +	 */
> >  	if (1 = (data->pwm_fcms[0] & (1 << index))) {
> >  		tmp = 2;
> >  		goto out;
> 
> Seems to me that the code is simply buggy. There is no reason to handle
> the case index = 0 (pwm1) any differently from the rest. Probably the
> "1 =" shouldn't be there, but I'd rather review the function entirely
> to make sure it's correct.
> 
> This is a part of the driver I didn't review yet, but quick testing a
> few days ago suggested there where bugs to be fixed. Your code review
> confirms this.
> 
Guess that explains a lot.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
