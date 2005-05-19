From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <Pine.LNX.4.58.0406280904030.1313@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
In-Reply-To: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Jun 2004, Jean Delvare wrote:

> > How about this (and I am assuming I will eventually have to produce a 
> > patch with the lm87 driver and drill it down into lib sensors for any
> > real by in).  The routine that reads all the sensor data detects that
> > there is error when reading one of the registers.  In the event of
> > such an error it sets a value to one in the chips structure (or a
> > bit).  If the read was succesful it sets it to zero.  A new proc entry
> > is created called perhaps readerror (please give me a better name). 
> > Whenever someone is scanning the the proc values they can check this
> > proc entry to see if the last read of the registers had no errors.  If
> > it did not then all is well, if it did then the program can act
> > appropriately (ultimately, I would hope sensors the program would
> > return an error and print one).  Also, when an error on a read is
> > detected the syslog is notified.
> > 
> > I haven't thought through writes yet, but how does that sound for
> > making read errors visable to user space?  This would not have to be
> > implemented for all sensors either but if the mechansim was agreed
> > upon implentation could occur as individuals cared.
> 
> Mmm, I don't see much benefit over what is done in w83l785ts.
>
Oh, I was just trying to come up with a middle of the road approach that 
could go into to 2.4, and also I wanted some way for userlevel stuff to 
know that the error occured.  
 
> With your method, the user application will be told that some of the
> values are wrong, but not which ones. So every value will have to be
> ignored. 
Agreed, its not optimal.  OTOH, in my case when I have seen the bus errors
it tends to span long enough that all the values tend to  be hosed.
But that is not necessarily the case all the time.

> Second, every application will have to do it. I guess that the
> application will return the old value instead in this case, which means
> it'll have to remember it. All in all you want to do at the chip level
> in user-space what my method (as implemented in the w83l785ts driver)
> does at feature level in kernel-space, so it's finer grained and not
> every application has to handle it. Since our chip drivers already cache
> the old values, the amount of additional code needed is low.
> 
> Please take a look at what is done in w83l785ts and tell me why it
> woudln't solve you problem, if it actually doesn't.
> 
I will definately take a look at this.  Again, I was just trying to find 
some middle ground that might be acceptable in 2, and as said above I 
do want some sort of exposure to user space (for application alarming 
purposes, so that real bugs with our I2C hardware don't get missed, 
and perhaps can be fixed).  Also, be aware, I am very new to this sensors 
stuff,  so lame brained ideas are quite possible (-;

Many Thanks...james
