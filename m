From: Chris Godbout <chris@mathologist.net>
Date: Thu, 28 May 2015 13:31:28 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <loom.20150528T152445-780@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, clearly the device does not have a regular 8-bit addressed register
> map. Only sub-addresses 0x00 and 0x03 seem to return actual register
> values (assuming a second call to i2cdump would return the same - maybe
> not.) Sensors-detect has protection code against devices with no
> register map at all, but I can't think of a way to safely detect the
> case above.
> 
> I am curious if:
> 
> $ i2cget 6 0x4f 0x00
> $ i2cget 6 0x4f 0x03
> 
> would be always successful and returning consistent values, or if it
> is random. The fact that register 0x00 holds value 0x00 and register
> 0x03 holds value 0x03 is rather suspicious, I'd say.

They do both return consistent values, actually. 0x00 always returns 0x00
and 0x03 always returns 0x03.
 
> This suggests that the reads done by i2cdump are in fact interpreted as
> writes by whatever chip lives at I2C address 0x4f. This is a recurrent
> problem with I2C as it only defines directions for messages on the bus,
> but no semantics for them.
> 
> You might want play with i2cset. If the device reacts to short writes
> (and the description you made of what happened during the dump pretty
> much suggests so) then something like:
> 
> $ i2cset 6 0x4f 0x80
> 
> would write value 0x80 to the chip. And the following command should
> reproduce the state at the end of i2cdump:
> 
> $ i2cset 6 0x4f 0xff
> 
> Sensors-detect OTOH reads register values in completely random order so
> it is difficult to know which was the last one.
> 
> Probably one value corresponds to the initial state of the chip before
> the very first sensors-detect run. If we had access to a similar system
> where the problem did not happen, we may be able to get the right value
> with:
> 
> $ i2cget 6 0x4f
> 
> > I think it's all better and I have no idea what happened. I can do more
> > probes or logs or whatever if that's helpful to other people, though.
> 
> Did you run i2cdump on I2C address 0x2c too? I'm going to blacklist
> 0x4f on graphics cards by default, I need to know if I should do the
> same for 0x2c too.
>

Yes, I did 0x2c as well and there were no problems at all. Only the 0x4f
address did anythig. Here's the result of the dump:

 i2cdump 6 0x2c
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-6, address 0x2c, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
a0: 01 06 03 01 01 00 ff ff ff ff ff ff ff ff ff ff    ?????...........
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................

> > > I can also offer to create a ticket in our bug tracking tool, to record
> > > the issue in case other users are affected, and tweak sensors-detect to
> > > be even safer even when the user explicitly asks for DDC channels to be
> > > probed.
> > 
> > That might not be a bad idea, but hopefully other people are smarter
than I am.
> 
> You'd be surprised and disappointed 
> 
> I have created:
> http://www.lm-sensors.org/ticket/2392
> 
> I'll add further discoveries there.
> 
> > Anyway, thanks a lot for looking at my post and helping me out.
> 
> You're welcome, I'm glad if you managed to get the display to a usable
> state again, to be honest I did not think we would succeed.
> 

Yeah, I didn't think it would happen, either. Fortunately, it was still
usuable, just rather unpleasant. I also set it to 0xbf like you mentioned in
your followup and that seems to work just fine.  Again, thanks so much.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
