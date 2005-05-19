From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030620041407.GF16519@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-06-20 00:04:19 -0400]:
> * Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-19 20:35:00 -0700]:
> > > Now put the `data->fan_min[nr] = value;` part into xxxx_write_value()
> > > (along with the proper locking) and be done with it; less code this
> > 
> > Are you saying that the assignment 'data->fan_min[nr] = value' would 
> > happen inside the xxxx_write_value function?
> > 
> > If so, how does xxxx_write_value know which data member to store into? 
> > Are you going to pass a pointer to data->fan_min[nr] as an argument to 
> > write_value?  What about type and size issues.  Some values are u8, 
> > others are s8, and u16.
> 
> Ack.  I was just about to modify lm78.c as an example when I realized
> the same thing just as your message came in.
> 
> > The other issue I see is that of partially split values.  Perhaps I'm 
> > the only one that's done this, but some registers contain bits for 
> > several different sensors.  (fan divisors for example...)  I have been 
> > breaking those appart and putting them back together as necessary for 
> > the job at hand.  In fact fan_divisors are a excellent example since 
> > they *have* to be split apart to make the fan RPM calculations easy.
> 
> Yeah, this is common to many chip drivers.
> 
> > What if we hoist the down/up out of update_client instead?  Is there 
> > someplace higher up that we could serialize access to all the show/set 
> > functions?  Is that a worse idea?
> 
> I don't know (to all three questions, more or less).  I'm going to step
> back a bit and look at what we're trying to accomplish with this structure
> cache of the register values in the first place.
> 
> Right, the way these chips typically work... they stop sampling while they
> service read or write requests.  We want to allow updates no more often
> than a defined frequency.  So is there a better way to accomplish that?

Sorry to reply to myself - attempt #3:

Remove this line from all set_foo():

	data->foo = FOO_TO_REG(...);

And add this to xxxx_write_value():

	data->valid = 0;

Hmmm, probably still need data->update_lock in xxxx_write_value(), but
that should take care of it no?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
