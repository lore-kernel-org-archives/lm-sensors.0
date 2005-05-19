From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: SMSC 47M14x - where is the output?
Message-Id: <20040613162214.55ec1e90.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1086642878.5504.1239.camel@quickdraw.squawk.com>
In-Reply-To: <1086642878.5504.1239.camel@quickdraw.squawk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

> In the machine that I had previously gotten fan output from,
> I had installed an lm78.o module, and the more I think about it, the
> more I think that maybe it was not this one and I am sorry for that
> misinformation. I believe that it was this box, but that the machine's
> motherboard croaked and it now has the Intel motherboard with
> different chips on it...that makes it a different box for all intents
> and purposes, especially yours.

OK, that explains it all. The LM78 has voltage, fan and temperature
inputs. The ADM1025 (which you are supposed to have on the new system)
only has voltage and temperature inputs. Since the SMSC Super-I/O chips
only handles fans, having both on one motherboard makes perfect sense.

> > >i2c-core.o: i2c core module
> > >i2c-proc.o version 2.6.1 (20010825)
> > >lm78.o version 2.6.5 (20020915)
> > >i2c-core.o: driver LM78(-J) and LM79 sensor driver registered.
> > 
> > You should not load lm78, you don't need it and it could cause
> > trouble.
> 
> Does that mean I should not load i2c-core even though it was called by
> sensors-detect?

No, all I meant was that the lm78.o module was meant for LM78 chips and were useless for your configuration (ADM1025 + SMSC Super-I/O).

> > >Code:  Bad EIP value.
> > 
> > *This* is a problem. Never saw a kernel crash? That's what it looks
> > like. (...)
> (...)
> ksysguardd is the userspace daemon which is loaded when you start
> ksysguard - I think that the above dump happened when I unloaded the
> modules without stopping ksysguard.  I have never seen anything as
> inefficient. It uses 40% of a 2 gig intel box just preparing a tree
> sorted process list every couple seconds.  pstree can do the
> equivalent in about 6% of the cpu.

That may explain it... We have heard of race conditions on module
unloading. If you have a daemon continuously reading the sensor values,
that might have triggered it.

> > I guess that this means that you are using the latest kernel
> > available from your distribution?
> 
> Yes.  I have rebooted since they (Fedora Core 1) distributed the last
> kernel. 
> 
> lm_sensors-2.8.1-1
> lm_sensors-devel-2.8.1-1
> 
> are the levels of the packages.  It looks like the .h files and the
> unshared (debug?) versions of the libraries come with the -devel
> package while the rest of the sensors stuff comes with the other
> package, and as you suggested, none of the kernel stuff is in this.
> The kernel source is provided separately in kernel packages.

This is really strange. Having such "recent" userspace tools doesn't
make much sense when at the same time you use really old drivers. Oh, it
shouldn't hurt though.

> No.  Now, you might like this. I spent about 5 minutes with a migraine
> pending trying to rebuild the kernel module, but to no avail. So I
> edited it with emacs hexl-mode.  I was slightly surprised to note that
> a hex byte with the  value 0x59 appeared at only one place in the .o
> module. I edited it to 0x5f and saved the module, having made a copy
> of it first.  depmod -a (probably not needed) and modprobe smsc47m1
> and the module loaded and then I ran sensors -s and sensors started
> reporting fan speeds.
> 
> So, yes, that was the problem and, frankly, I would not have any idea
> how to build the modules without doing a complete kernel rebuild, and
> I would have to find a how-to for that.  emacs was a lot easier.
> 
> I am an old IBM mainframe systems programmer.  We had a utility called
> "superzap" that we would fix modules with all of the time.  I got
> pretty good at reading hex instruction codes in IBM, although I can't
> do it in Intel at all.  But I am comfortable with making binary
> changes to modules like this one, even without a good utility to do
> them with.  In any case, I was lucky that there was only the one 59,
> else there would have been some trial and error.  It was not in a
> literal pool as far as I could tell...I think it was an immediate byte
> in an instruction.

Aha, nice story :) I did something similar a few months ago, same
conditions (no ability to recompile everything, and only a different ID
was needed). Binary edit worked great :)

OK, so if I summarize your problems, you now have the adm1025 and
smsc47m1 drivers working well together and everything's fine?

-- 
Jean Delvare
http://khali.linux-fr.org/
