From: pascal.ronecker@centrale-lille.net (Pascal Ronecker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: [Fwd: sensors, kernel 2.4.19, bttv ...]
Message-Id: <1067191364.14649.3.camel@lenny.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's me again... i just would like to add a word : I've just read i2c
2.8.0 was included in kernels after 2.4.21.
Does it mean that simply upgrading my kernel from 2.4.19 to - say -
2.4.22 will do the trick ?
I mean, then I'll only have to compile lm_sensors and everything will be
fine (bttv and i2c sensors ?)

thanks again

regards,

Pascal


-----Forwarded Message-----
> From: Pascal Ronecker <pascal.ronecker@centrale-lille.net>
> To: sensors@stimpy.netroedge.com
> Subject: sensors, kernel 2.4.19, bttv ...
> Date: 26 Oct 2003 18:24:46 +0100
> 
> Hi,
> 
> I must say i'm a bit confused with lm_sensors.
> I'd like to have it work, i'm running a 2.4.19 kernel. (an old fellow,
> but still working that's what sounts eh :-) )
> I *need* bttv modules, and i read is the i2c package documentation that
> the latest i2c drivers you provide instead of the native kernel modules
> conflitcs with the bttv (or is it the other way round ? doesn't matter).
> 
> what should I do ?
> 
> What is more, i am running a Redhat 9 based system, so I fetched a
> lm_sensors version 2.6.5-5, as a rpm package. This version is not listed
> on your web site ?? what is this package ?? [great confusion :-) ]
> 
> Thanks for some help and explanations ...
> 
> 
> A last word on your "RPM README" and spec files ... they seem slightly
> buggy (Requires : kernel v 2.4.19, Conflicts : kernel v >= 2.3.33, for
> example, but worst : looking for file in /lib/modules/{vmodules}/misc
> instead of /lib......./kernel and /lib..../kernel/drivers and so on). I
> must admit i'm not a rpm-champion, so excuse me if I just wrote stupid
> things, anyway this rpm story is not that important.
> 
> regards
> 
> Pascal
