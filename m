From: Chris Godbout <chris@mathologist.net>
Date: Wed, 27 May 2015 14:48:14 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <loom.20150527T163449-12@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I know I should have stuck with the defaults, but I
> > didn't. Instead, I hit yes for everything which hasn't been a problem
before.
> 
> There's a reason for these defaults...

And sadly, there's a common reason many of my computers / laptops don't last
forever.

> > Everything was fine until I probed DPDDC-A (i2c-6). It went through a list
> > of sensors and part way through it my screen flickered. Afterwards, my
> > monitor got really bright and the colors were all washed out. Unfortunately,
> > I'm colorblind and have a hard time describing it more than that.
> > Additionally, in large blocks of the same color it's almost as if I can see
> > the individual pixels and some of them are actually black. This may be an
> > optical illusion, but when I look closely, it's almost as if they're moving.
> 
> Do I understand correctly that you are speaking of the internal laptop
> display and not an external display?

Yes, that's correct. Sorry I forgot to specify. I actually set the output to
my TV (via HDMI) and there seemed to be no problem.

> > Any suggestions, even if it's where else to look for help? Any other logs
> > you need?
> 
> Did you try try cold booting the laptop? This means: powering it down,
> unplugging the AC adapter, removing the battery, waiting for several
> minutes, then plugging everything back and starting the laptop.

Sadly, this didn't work. I'd rebooted several times, but never thought to
take the battery out and leave it out.

> Also if you also have Windows installed on the laptop, you may try
> booting it, maybe Lenovo's utilities can fix the problem.
> 
> If that doesn't help, I'm afraid I can't offer any help as long as I
> don't know what the two I2C chips are. Providing register dumps (using
> i2cdump from the i2c-tools package) may help, but it may also make
> things worse, so it's up to you if you want to give it a try.
> Alternatively you may try contacting Lenovo's support and asking them
> for the information, but chances that they actually reply with useful
> data seems thin.

For better or worse, if I were worried about making things worse I probably
would have stuck with the defaults and wouldn't be in this predicament. So I
went ahead and did the i2cdump. I'm glad I did, because it seems to actually
have improved things. Here's the i2cdump

# i2cdump 6 0x4f
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-6, address 0x4f, mode byte
Continue? [Y/n] 
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 XX XX 03 XX XX XX XX XX XX XX XX XX XX XX XX    .XX?XXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX

Immediately after hitting yes, my screen flickered a little and got really
bright (as it did when doing sensors-detect). But as it continued with the
dump, it got darker and now it seems like it's corrected itself. The colors
are all back to normal now. 

I think it's all better and I have no idea what happened. I can do more
probes or logs or whatever if that's helpful to other people, though.

> I can also offer to create a ticket in our bug tracking tool, to record
> the issue in case other users are affected, and tweak sensors-detect to
> be even safer even when the user explicitly asks for DDC channels to be
> probed.

That might not be a bad idea, but hopefully other people are smarter than I am.

Anyway, thanks a lot for looking at my post and helping me out.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
