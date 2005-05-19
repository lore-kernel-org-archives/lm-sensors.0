From: cgfreita@netsite.com.br (cgfreita)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040803215233.08cbfd9e.cgfreita@netsite.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

	Uff, finally I ran the tests.
	As usually, I patched -R beta2.diff, patched -p1 beta3.diff and
make bzImage, make install, make modules, make modules_install.
	Everything was fine. No .rej.

> > Please, take a look at probs4.txt attached.
> 
> The good point is that you seem to be able to control fan 1's speed.
> But the reported value goes weird as soon as the fan is stopped.
> Either the value isn't updated anymore (i.e. last value is reported)
> or random values are reported. Since it reported 5851 RPM once,
> which doesn't seem possibe, I would opt for the second case.
> However, I would like you to do some more tests to confirm that.
> 
> Please stop the fan (pwm_enable=1, pwm=0) and run sensors several
> times in a row, with some delay between each run. Check if the
> (obviously wrong value) which is reported is the same each time, or
> not.
> 
> > Please, take a look at results_jean.txt
> 
> My code was obviously bogus, fan min was not preserved at all when
> changining fan div. I just took a look and have to say I'm a bit
> ashamed, since it was caused by... a misplaced parenthesis.
> 
> Fixed patch is available:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-beta3.diff
> if you can please test again using the same script. Oh, BTW:
> 
> > modprobe i2c_sensor
> > modprobe i2c-i801
> > modprobe i2c-isa
> > modprobe adm1025
> > modprobe smsc47m1
> 
> You don't need to explicitly modprobe i2c_sensor, it'll be loaded as
> needed automatically.

	Forgive me for the giant quote.
	You can see at j1 (jean.tar.bz2) directory, the results you asked
for. Please take a look.

> > and results_jean_dump.txt.
> 
> Fan alarms are not set on the dump you sent, so there's nothing I
> can check. The case I'm interested in is when "sensors" show an
> alarm which you think should not be there. If you provide both the
> output of"sensors" and the dump at that instant, I may be able to
> check if sensors' output matches the registers dump or not. If you
> are not able to reproduce that corner case or are not worried about
> it, just forget about it, it's not critical.

	Please, take a look at j2 (jean.tar.bz2) directory. There are the
tests you asked for. Oh, check if the .sh is ok to you.
	I don't matter about the ALARMS. I just tried to give you
the more information I could.

> > From today, I can delay a little more to answer because I am back
> > to college classes. (The end of vacation)
> 
> Oh, I wish you well then :)

	So do I. Thank you. :-)
 
> > P.S. My english is not good enough. :-)
> 
> Like mine is perfect? ;) Come on, you must be kidding, your English
> is honest to say the least. You have no idea what bad English is.

	Well, if you are understanding what I write, it is fine. :-)
	Please, if you need more information, tell me.
	I was wondering, are there some other things that can influence the
behaviour of sensors? I mean, that could be affecting the results?
	Thanks.

Freitas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: jean.tar.bz2
Type: application/octet-stream
Size: 2275 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040803/45e281c7/jean.tar.obj
