From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: new MAX6653 driver
Message-Id: <20040910125641.M17092@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094741705.29203.18.camel@pavement.sandburst.com>
In-Reply-To: <1094741705.29203.18.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Sep 2004 08:42:44 -0400, Travis B. Sawyer wrote
> On Fri, 2004-09-10 at 05:29, Jean Delvare wrote:
> >  If it is something other users are
> > likely to have on their boards,
> 
> ;)  Not likely, its a reference/demo 'board' (err, ^h^h System) for our
> chips.  The HW folks sprinkled the '53s across the back, so I have 4
> fans connected to 5 chips.  Only one of the '53s remote sensor is
> connected, the rest are 'ambient' temp.
> 
> >  I have a patch (attached) which adds support
> > for the MAX6653 (and MAX6663/MAX6664 for that matter) to sensors-detect.
> 
> I'll see what I can do, I didn't build most of the utils as I didn't
> want to fight with the cross-compiler, etc.

For what it's worth, sensors-detect is a perl script, so there is no
cross-compilation involved (providing you have perl available on the target
plateform).

That said, is it is unlikely that regular folks will have these chips on their
motherboards, I probably won't bother applying my patch to the CVS tree - so
test it for fun if you want but don't spend extra time on this.

> No, sir, Thank You!  The drivers in the sensors and i2c packages have
> been a HUGE time saver for me!

You're welcome :)

(BTW I am definitely not the one to thank here - I am only maintaining a
project those bases were laid down by other folks years ago.)

-- 
Jean Delvare
http://khali.linux-fr.org/
