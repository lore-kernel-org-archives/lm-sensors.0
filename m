From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030620040419.GD16519@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-19 20:35:00 -0700]:
> > Now put the `data->fan_min[nr] = value;` part into xxxx_write_value()
> > (along with the proper locking) and be done with it; less code this
> 
> Are you saying that the assignment 'data->fan_min[nr] = value' would 
> happen inside the xxxx_write_value function?
> 
> If so, how does xxxx_write_value know which data member to store into? 
> Are you going to pass a pointer to data->fan_min[nr] as an argument to 
> write_value?  What about type and size issues.  Some values are u8, 
> others are s8, and u16.

Ack.  I was just about to modify lm78.c as an example when I realized
the same thing just as your message came in.

> The other issue I see is that of partially split values.  Perhaps I'm 
> the only one that's done this, but some registers contain bits for 
> several different sensors.  (fan divisors for example...)  I have been 
> breaking those appart and putting them back together as necessary for 
> the job at hand.  In fact fan_divisors are a excellent example since 
> they *have* to be split apart to make the fan RPM calculations easy.

Yeah, this is common to many chip drivers.

> What if we hoist the down/up out of update_client instead?  Is there 
> someplace higher up that we could serialize access to all the show/set 
> functions?  Is that a worse idea?

I don't know (to all three questions, more or less).  I'm going to step
back a bit and look at what we're trying to accomplish with this structure
cache of the register values in the first place.

Right, the way these chips typically work... they stop sampling while they
service read or write requests.  We want to allow updates no more often
than a defined frequency.  So is there a better way to accomplish that?

> :v)
> 
> Mark M. Hoffman wrote:
> >* Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-19 18:45:36 
> >-0700]:
> >
> >>The data->foo and device register need to be in sync.  So I suppose 
> >>both...
> >
> >
> >The device registers are protected by the I2C bus locking or ISA bus
> >locking in xxxx_write_value.  The race (in the original) that I see
> >looked like this:
> >
> >process a in show_bar()		process b in set_foo() 
> >
> >				data->foo = baz;
> >
> >/* changes data->foo */
> >xxxx_update_client();
> >
> >				/* wrong, doesn't = baz anymore */
> >				xxxx_write_value(..., data->foo);
> >
> >But now that I look again, why not this?
> >
> >{
> >	struct i2c_client *client = to_i2c_client(dev);
> >	u8 reg ;
> >	int val = simple_strtol(buf, NULL, 10);
> >
> >	reg = FAN_TO_REG(val);
> >	lm85_write_value(client, LM85_REG_FAN_MIN(nr), reg);
> >	return count;
> >}
> >
> >Now put the `data->fan_min[nr] = value;` part into xxxx_write_value()
> >(along with the proper locking) and be done with it; less code this
> >way and harder to accidentally break.  Actually, the more I look at
> >it, the more I like this idea (he writes after deleting 50 lines of
> >his first attempt.)  Comments?
> >
> >
> >>At first I thought that if I always updated the chip first and then the 
> >>data->foo cached value, I'd be OK, but it seemed like there were too 
> >>many exceptions where values were broken apart, or recombined...
> >>
> >>The primary thing I was trying to avoid was one CPU writing a value 
> >>while another CPU was reading a value (and therefore calling 
> >>update_client) and the result being that the data->foo cached value was 
> >>different from actual device register.
> >>
> >>:v)
> >>

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
