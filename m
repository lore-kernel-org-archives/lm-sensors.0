From: brian@rapsure.net (Brian Beardall)
Date: Sun, 25 Jun 2006 02:26:03 +0000
Subject: [lm-sensors] CPU Temp on ECS NFORCE3-A939
Message-Id: <1151202363.986.5.camel@rapsure.rapsure.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000f01c69295$f481af80$7001a8c0@parisi02>
In-Reply-To: <000f01c69295$f481af80$7001a8c0@parisi02>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2006-06-20 at 14:52 +0200, Jean Delvare wrote:
> Hi Lou,
> 
> > > I wouldn't be surprised if you have the same chip as Brian.
> > 
> > I ran the new sensors-detect and the chip detected was the same as Brian's.
> > Can you please add my name also to the list of those interested in this
> > driver.  The output from the latest sensors-detect is at the bottom of this
> > page.
> 
> I've done so.
> 
> > Thank you for all of your help.  Lou
> 
> You're welcome :) Now the hard part would be to write, review and test
> a driver for that chip - but I just don't have the time to do that,
> unfortunately.

I've been working on a driver for the chip, but I can't get it to
interface with sensors. I have it reading from the registers correctly,
and I used a printk statement to make sure that the driver was reading,
and storing the values correctly, but when I run sensors it doesn't
print out anything. I based the code off of your lm63 driver. The driver
does initialize, and detect. Would you like to look at it, and how woule
you like me to send it? I have a couple things to fix with temperature
calculation, hyst, and min, and max, but I first want to get it to talk
to userland software.
> 
> > By the way, I heard back from ECS.  Their response:
> > ----------ECS Response ----------
> > Dear Valued Customer:
> > 
> > If a monitoring software is being used and is failing to collect data for
> > the CPU temprature, the software is incompatible and no monitoring software
> > is available for the board since Hardware Monitor was already integrated in
> > the BIOS.
> >  
> > Thank you for using ECS products
> > ---------------------------------
> 
> Well, at least they answered, but that wasn't really useful. Good thing
> that we found the answer by ourselves meanwhile!
> 


