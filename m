From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Sep 2010 14:16:14 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100918161614.1f3426ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 18 Sep 2010 06:34:33 -0700, Guenter Roeck wrote:
> Hi Jean,
> On Sat, Sep 18, 2010 at 07:56:01AM -0400, Jean Delvare wrote:
> > > +		 * But that causes lsb to be undefined across loop instances,
> > > +		 * doesn't it, since it is only defined inside the loop ?
> > > +		 * And what happens if an even fan does not exist
> > > +		 * but the odd one does ?
> > > +		 */
> > >  		if ((i & 1) = 0 && (data->has_fan & (3 << i)))
> > >  			lsb = w83795_read(client, W83795_REG_FAN_MIN_LSB(i));
> > >  
> > 
> > I don't see any problem with lsb being undefined. lsb is always set if
> > it is going to be needed. I also don't see any problem with odd and
> > even fans: lsb is set if _any_ fan in a given pair is present (see the
> > 3 << i).
> > 
> > If you can think of a specific scenario where it doesn't work, please
> > let me know. The code looks good to me.
> > 
> Looks like lsb survives across loop instances; at least the compiler doesn't complain 
> about it. So I guess you are right.

Of course it does. Why wouldn't it?

> > > (...)
> > > +	/* Those reversed comparisons always confuse me.
> > > +	 * I think the compiler should refuse to compile 
> > > +	 * such code to make me happy. And, no, I don't buy
> > > +	 * the argument that the compiler magically produces
> > > +	 * better code this way.
> > > +	 * They are used in this driver to compare variables against
> > > +	 * defined constants (though not all the time).
> > > +	 * Direct value comparisons are (most of the time) the other way.
> > > +	 * Any reason ?
> > > +	 * Maybe I shouldn't even ask since this one always create a lot of
> > > +	 * heated discussion. Let me know.
> > > +	 */
> > >  	if (FAN_INPUT = nr)
> > >  		val = data->fan[index] & 0x0fff;
> > >  	else
> > 
> > I fully agree with you. Again the code isn't mine.
>
> Would it make sense to add a cleanup patch on top of the other ones ?
> I always find that such style issues are distracting, and make it difficult
> to review it.

I've written that patch already, based on your comments. I'll post it
with the next batch of w83795 patches.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
