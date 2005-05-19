From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: pca9540 driver question
Message-Id: <Pine.LNX.4.58.0406191046250.3448@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406181758580.19803@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406181758580.19803@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Jun 2004, Jean Delvare wrote:

<snip>
> > I guess my question is what was what
> > functionality was the driver attempting to provide?  Does it actually
> > allow for the phillips arbitration protocol when trying to talk to any
> > sensors on the I2C bus, or does it only show what channel is selected
> > at the time?  I looked in the code, and I could not see how it was
> > actually allowing for the arbitration of the bus, but I very well
> > could have missed something.
> 
> It is a really simple driver that just gives the user a manual control
> over the multiplexer. There were plans to integrate such chips at a
> lower level in the i2c core so that it is transparent to the user:
>   http://archives.andrew.net.au/lm-sensors/msg04238.html
>   http://archives.andrew.net.au/lm-sensors/msg05047.html
Yeah, Mark Hoffman pointed me to these threads, earlier, but I hadn't 
looked at 2.8.7 yet so I was hopping (-;

> But it was never completed, so I decided to write that simple driver so
> that people can control the chip manually in the meantime. But actually
> I'm not even sure it was ever used. We had no feedback so far.
> 
> As you pointed out, manually switching the multiplexer at the wrong time
> (when i2c bus isn't idle) is likely to cause trouble. The driver is
> definitely meant as a temporary solution (which basically means it'll
> probably be used for another two years or so before a better solution is
> implemented ;)).
>
I actually have a need for such arbitration today, so I am willing to do 
whatever it takes to get it (similar to the LM93 support).   Speaking with
Mark, I came to the understanding that I don't need everything that was in 
the original patch (i.e. the virtual busses and such), but I really want 
to make the arbitration portion work in a way that will ultimately be 
received back to the sensors project.  At anyrate, after I have more 
closely studied the original patches, and the phillips docs, I will 
probably be back in touch asking more specific questions about what would
be an acceptable way to graft in general support for I2C multipexors.

Thanks for the response...james

P.S.  I am very new to working this close to the hardware, so forgive
me if I ask any really brain dead questions.  I am doing my best, though
to read the source, and appropriate docs (and re-read).  I will say 
this your architecture is really nice, and the code is very clean, so 
really the only thing that hinders is my lack of experience with the 
lower level hardware details.  So again, many thanks!
