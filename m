From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Temps on S755MAX IT8705F
Message-Id: <20040717082742.08235ff5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40F5A42D.9070301@verizon.net>
In-Reply-To: <40F5A42D.9070301@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well, I tried  to install the 2.8.7 with make user and make
> user_install and it hosed up and to top that My new drive is about
> dead. Already got an rma for it, so I may have to put this on the back
> burner for a little while. It's taking 10-20 minutes to boot every
> time with fsck running every time on several partitions.

Iirk :( That's no good news for certain. What brand/model is it?

> >Yes, please try 2.8.7. Some of the changes made to the it87 driver,
> >most notably in the init part, may have fixed your problem as a side
> >effect.
> >
> >If it still doesn't work, please provide a dump of your it87 chip
> >(with"isadump 0x295 0x296").
>
> Here's where I'm at now.:-)
> [wes@wes2 wes]$ sensors
> it87-isa-0290
> Adapter: ISA adapter
> ERROR: Can't get IN0 data!
> (...)

Ah. I completely missed the fact that you could be using a 2.6 kernel.
2.6.2 or 2.6.3 from Mandrake I guess? The trick is that in early 2.6 we
changed the interface, so each kernel needs a specific version of
lm_sensors. With lm_sensors 2.8.7 you'll need a 2.6.5-rc1 or later
kernel.

Second, this means that my comments on "changes on the it87 driver of
the lm_sensors package may help you" are irrelevant. The it87 driver you
use is from the kernel tree, so the changes I was monitoring do not
affect you. OTOH, the 2.6 driver has had changes too, most notably in
2.6.5, but actually in almost all versions since 2.6.1. This, upgrading
kernels may bring some insight as well.


> But here's the dump.
> 
> [root@wes2 wes]# isadump 0x295 0x296
>   WARNING! Running this program can cause system crashes, data loss
>   and 
> worse!
>   I will probe address register 0x0295 and data register 0x0296.
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 11 06 67 00 00 00 00 00 00 00 00 09 00 c7 ff ff
> 10: e1 e1 e1 70 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 5d 5f cb b9 b8 c6 46 bb c5 46 6c 17 00 00 00 00
> 30: 75 60 ac 8d 71 5d cc a8 d8 b2 72 5e 3d 33 cc a8
> 40: 3c 14 3c 14 3c 14 00 00 2d 00 00 00 00 00 00 00
> 50: ff 2a 7f 7f 7f 00 00 00 90 56 02 00 00 00 00 00
         ^^
Sensor types. 0x2A means temp2 is a diode while temp1 and temp3 are
thermistors. Not quite what you tried to do, is it?

It could be interesting to try changing the sensor type values with
"sensors -s" and check this value so as to make sure it changes
accordingly. The fact that reported temperatures didn't change at all
when changing types is suspect, and I wouldn't be surprised if it did
never change actually.

Bonus question, did you try changing voltage or temperature limits, and
did it work?

> Until I get the drive replaced, I'm going to do as little as possible 
> with the file system and hopefully I can recover most of my setup. If 
> you don't hear from me for a while, you'll know why.:-)

Sure, don't do anything before your drive is back in good health. I just
hope that your drive didn't die of overheating because lm_sensors missed
to tell you...

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
