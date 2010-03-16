From: Phillip Pi <ant@zimage.com>
Date: Tue, 16 Mar 2010 15:25:03 +0000
Subject: Re: [lm-sensors] "FATAL: Module i2c_nforce2 not found." and "FATAL:
Message-Id: <20100316152503.GC25138@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B9E4A32.8090405@earthlink.net>
In-Reply-To: <4B9E4A32.8090405@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's not only i2c-* modules that can't be found. Apparently
> sensors-detect can't find _any_ module on your system. You have
> probably broken your kernel modules system-wide.

Yeah so weird. I don't know what happened or how it happened.

 
> > # uname -a
> > Linux foobar 2.6.32-trunk-686 #1 SMP Sun Jan 10 06:32:16 UTC 2010 i686 
> > GNU/Linux
> 
> This looks good, but OTOH I have no idea if your locate database is
> up-to-date. Try running "updatedb" first, then "locate i2c-nforce2"
> again.

I installed a newer kernel 2.6.32 package (non-trunk) from apt-get
install, trunk kernel wasn't working either, rebooted, used non-trunk
and all works now. WEIRD!

# uname -a
Linux foobar 2.6.32-3-686 #1 SMP Thu Feb 25 06:14:20 UTC 2010 i686 GNU/Linux

I noticed this kernel upgrade detected something new: 
http://pastie.org/872083 (too long to post in here). It never detected 
adt7473 module, but it never show it in sensors command. What is it? 
From a quick Google search, it seems to be fan controls or something?

# lsmod |grep adt7473
adt7473                 8792  0 
i2c_core               12648  3 adt7473,nvidia,i2c_nforce2
# lsmod |grep w83627ehf
<showed nothing>

Weird?
-- 
Quote of the Week: "What reason, like the careful ant, draws laboriously 
together, the wind of accident sometimes collects in a moment." 
--Friedrich von Schiller
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
