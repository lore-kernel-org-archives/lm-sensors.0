From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Tyan S2882 and S2880
Message-Id: <20040819095537.M67810@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > The high temperatures you obtain are not impossible if they are
> > reported by CPU built-in thermal diodes (very near from the CPU
> > core) and the fans are insufficent. Maybe you should consider that
> > case. After all, this is why monitoring is important ;)
> 
> Yes, the machine is question is hanging after a few minutes of
> load. :/

Overheating would be a good reason, but there could be others as well.

> I just wonder that there are 6 different tempereature sensors around,
> and that there were three at 35-45? and three at 70-80?, so it looks
> like a wrong multiplier has been applied to one set.

As said above, it really depends on what each probe is measuring and how. The
the 35-45 are ambient temperature in the box while 70-80 are measured directly
on CPU cores or similar, there's nothing wrong there.

Did you take a look at the BIOS setup screen offered by your motherboard? If
it presents some hardware monitoring information, you want to compare this
with what our Linux drivers report.

At any rate, multipliers are rarely needed for temperatures, contrary to
voltages where they are part of the game. Most of the time, the temperature
compute lines are there to match what the BIOS does, and what the BIOS does is
(usually) broken. An example of this is my Asus TX97-E board, where the socket
temperature is measured by a thermistor, and Asus arbitrarily decided that the
CPU temperature was likely to be twice the temperature measured in the socket.
This is really nothing more than an estimation. The temperature displayed by
the BIOS was never measured as such. Asus especially seems to be quite good at
this kind of trickery.

Most of the time the idea is to increase the measured value so as to
compensate for the distance between the probe and the CPU. This means that,
more often than not, the measured value will be lower than the
supposedly-actual/displayed value. This doesn't seem to quite match your case.

Another case is with thermistors, where the beta value can change from one to
the other. Some chips can be configured for non-default beta values, some
cannot and you may need to compensate in /etc/sensors.conf but I've never seen
this required so far.

> > You may want to get in touch with that person and share your experience
> > together.
> 
> I did so, he is using the sysfs values directly.

Did he told you which average temperatures he was getting? Would be
interesting to compare with yours.

> I can read the "alarm" file, sensors is looking for "alarm_mask" 
> which does not exist:

Aha OK, I get it now. The 2.4 lm85 driver had this extra file for the ADM1027,
but this feature was dropped in the 2.6 driver. All we have to do is ignore
the "error" in this case. That's not a very important information anyway
(which is probably why it was dropped).

I'll commit a patch doing this in the evening.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
