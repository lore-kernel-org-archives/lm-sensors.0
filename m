From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 28 May 2015 10:10:49 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <20150528121049.7a2596f9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

On Wed, 27 May 2015 14:48:14 +0000 (UTC), Chris Godbout wrote:
> > If that doesn't help, I'm afraid I can't offer any help as long as I
> > don't know what the two I2C chips are. Providing register dumps (using
> > i2cdump from the i2c-tools package) may help, but it may also make
> > things worse, so it's up to you if you want to give it a try.
> > Alternatively you may try contacting Lenovo's support and asking them
> > for the information, but chances that they actually reply with useful
> > data seems thin.
> 
> For better or worse, if I were worried about making things worse I probably
> would have stuck with the defaults and wouldn't be in this predicament. So I
> went ahead and did the i2cdump. I'm glad I did, because it seems to actually
> have improved things. Here's the i2cdump
> 
> # i2cdump 6 0x4f
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-6, address 0x4f, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 00 XX XX 03 XX XX XX XX XX XX XX XX XX XX XX XX    .XX?XXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

OK, clearly the device does not have a regular 8-bit addressed register
map. Only sub-addresses 0x00 and 0x03 seem to return actual register
values (assuming a second call to i2cdump would return the same - maybe
not.) Sensors-detect has protection code against devices with no
register map at all, but I can't think of a way to safely detect the
case above.

I am curious if:

$ i2cget 6 0x4f 0x00
$ i2cget 6 0x4f 0x03

would be always successful and returning consistent values, or if it
is random. The fact that register 0x00 holds value 0x00 and register
0x03 holds value 0x03 is rather suspicious, I'd say.

> Immediately after hitting yes, my screen flickered a little and got really
> bright (as it did when doing sensors-detect). But as it continued with the
> dump, it got darker and now it seems like it's corrected itself. The colors
> are all back to normal now.

This suggests that the reads done by i2cdump are in fact interpreted as
writes by whatever chip lives at I2C address 0x4f. This is a recurrent
problem with I2C as it only defines directions for messages on the bus,
but no semantics for them.

You might want play with i2cset. If the device reacts to short writes
(and the description you made of what happened during the dump pretty
much suggests so) then something like:

$ i2cset 6 0x4f 0x80

would write value 0x80 to the chip. And the following command should
reproduce the state at the end of i2cdump:

$ i2cset 6 0x4f 0xff

Sensors-detect OTOH reads register values in completely random order so
it is difficult to know which was the last one.

Probably one value corresponds to the initial state of the chip before
the very first sensors-detect run. If we had access to a similar system
where the problem did not happen, we may be able to get the right value
with:

$ i2cget 6 0x4f

> I think it's all better and I have no idea what happened. I can do more
> probes or logs or whatever if that's helpful to other people, though.

Did you run i2cdump on I2C address 0x2c too? I'm going to blacklist
0x4f on graphics cards by default, I need to know if I should do the
same for 0x2c too.

> > I can also offer to create a ticket in our bug tracking tool, to record
> > the issue in case other users are affected, and tweak sensors-detect to
> > be even safer even when the user explicitly asks for DDC channels to be
> > probed.
> 
> That might not be a bad idea, but hopefully other people are smarter than I am.

You'd be surprised and disappointed ;-)

I have created:
http://www.lm-sensors.org/ticket/2392

I'll add further discoveries there.

> Anyway, thanks a lot for looking at my post and helping me out.

You're welcome, I'm glad if you managed to get the display to a usable
state again, to be honest I did not think we would succeed.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
