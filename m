From: tsawyer@sandburst.com (Travis B. Sawyer)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: new MAX6653 driver
Message-Id: <1094820164.26717.5.camel@pavement.sandburst.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094741705.29203.18.camel@pavement.sandburst.com>
In-Reply-To: <1094741705.29203.18.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2004-09-10 at 05:29, Jean Delvare wrote:
> On Thu, 09 Sep 2004 10:55:05 -0400, Travis B. Sawyer wrote
> > I've created a new max6653 chip driver but really don't have the 
> > time to do a proper submission.  Should I just send the driver code?
> 
> Yes, please do. That way it'll be available through the mailing-list archive
> if someone wants to do a proper submission at a later time.
> 
See attached...

> Which system do you have this chip on?

Custom hardware...

>  If it is something other users are
> likely to have on their boards,

;)  Not likely, its a reference/demo 'board' (err, ^h^h System) for our
chips.  The HW folks sprinkled the '53s across the back, so I have 4
fans connected to 5 chips.  Only one of the '53s remote sensor is
connected, the rest are 'ambient' temp.

>  I have a patch (attached) which adds support
> for the MAX6653 (and MAX6663/MAX6664 for that matter) to sensors-detect.

I'll see what I can do, I didn't build most of the utils as I didn't
want to fight with the cross-compiler, etc.

>  Could
> you please give it a try? If it works I'll apply it to the CVS repository (as
> soon as I get back to a decent Internet access).
> 
As a side note, the attached driver does work with the '63 also (should
be the same for the '64 too)




> Thanks.

No, sir, Thank You!  The drivers in the sensors and i2c packages have
been a HUGE time saver for me!


-- 
Travis B. Sawyer
Sandburst Corporation  http://www.sandburst.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6653.c
Type: text/x-csrc
Size: 27781 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040910/409a6435/max6653.bin
