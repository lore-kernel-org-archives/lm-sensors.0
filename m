From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <20040606112045.7f5beeac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Dumps of the chip are attached, as stated in the previous e-mail.

In1, in5 and in6 are OK at steps 1 and 2 (after reboot and driver load,
respectively) and go off at step 3 (after sensors -s). For some reason,
in7, in8 and in10 are not affected. I'm not too sure about in2, it never
seemed to work.

So I am now very suspicious about sensors -s. One or more "set" lines of
the configuration file would be causing the trouble. What is even more
strange is that "sensors -s" didn't seem to have any other effect than
breaking these readings. I guess that this means that the limit setting
were preserved through the reboot process (didn't you do a _cold_
reboot?).

> I believe that temp6 is my cpu temp; I ran a blow-drier at my cpu and 
> temp5 and 6 showed changes... I then compiled Mplayer to give the cpu 
> some work and temp6 changed from 39 to 48 degrees, and oddly, temp4
> did the same. Temp 5 continued to hover between 40 and 43 degrees.

You analysis makes sense, temp6 would be the CPU temp then. The changes
on temp4 and temp5 strongly depend on where these thermistors are
located. maybe temp5 is located near the cpu socket so it was affected
by the first test, while temp4 is on a device that heats much when
compiling (the CPU is not the only part used when compiling, of course).
You may try using your blow-drier on random locations of your
motherboard and see if temp4 reacts, this may provide additional hints.

> Also, I re-installed a clean slackware 9.1, and compiled a 2.4.26
> kernel with the same config file as used in my last install. I
> rebooted, and the first thing I did was install i2c cvs and
> lm_sensors2 (snapshots I downloaded yesterday, June 2). When I put in
> the custom sensors.conf changes, the voltage values did fall in the
> range specified! And this worked all during that session. Stupidly
> though, I didn't do any dumps or even copy the output.... rebooted and
> now the sensors output are no different than before.

According to what I saw in the dumps, I'd guess that either the end of
the first session or the beginning of the second one included a "sensors
-s".

If I'm correct and "sensors -s" is really causing the problem, I'd be
very interested in you trying to locate which line precisely is doing
it. Start from a working system, comment out all set lines, then
uncomment then one after the other and run "sensors -s && sensors" each
time. I'd hope (sort of) that at some point the readings will go down
and we'll now which line breaks it all. I know it's a long process but I
have no other idea at the moment... Note that lines concerning
temp4-temp6 are good candidates since this is the last thing I added and
I don't think there was any problem before that.

Any additional data you could provide about what would cause the
readings to suddenly break is welcome, of course.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
