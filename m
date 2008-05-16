From: Marc Hulsman <m.hulsman@tudelft.nl>
Date: Fri, 16 May 2008 20:53:34 +0000
Subject: Re: [lm-sensors] [PATCH] Transition w83791d maintenance to Marc
Message-Id: <200805162253.34211.m.hulsman@tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80805141236h4d32e3d1g914300019e9e8f63@mail.gmail.com>
In-Reply-To: <5bfe43f80805141236h4d32e3d1g914300019e9e8f63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Friday 16 May 2008 21:14:16 Jean Delvare wrote:

[snip]
> > diff -urpN linux-2.6.26-rc1-git3/MAINTAINERS
> > linux-2.6.26-rc1-git3_w83791d/MAINTAINERS ---
> > linux-2.6.26-rc1-git3/MAINTAINERS	2008-05-03 11:59:44.000000000 -0700 +++
> > linux-2.6.26-rc1-git3_w83791d/MAINTAINERS	2008-05-13 23:09:01.000000000
> > -0700 @@ -4387,8 +4387,8 @@ M:	johnpol@2ka.mipt.ru
> >  S:	Maintained
> >
> >  W83791D HARDWARE MONITORING DRIVER
> > -P:	Charles Spirakis
> > -M:	bezaur@gmail.com
> > +P:	Marc Hulsman
> > +M:	m.hulsman@tudelft.nl
> >  L:	lm-sensors@lm-sensors.org
> >  S:	Odd Fixes
>
> Will Marc only take care of the "odd fixes" or will he be fully
> maintaining the driver? In the latter case this line should be updated
> accordingly.

I'm planning to do full maintenance.  Somewhere in the next few weeks I will 
add support for PWM regulation (duty cycle registers already work fine on my 
machine, I will implement the rest when I have a bit more time)

Marc


Slightly modified maintainers patch (I assume Charles will still be ok with 
it):

Transition the maintenance of the w83791d driver to Marc Hulsman.

Signed-off-by: Charles Spirakis <bezaur@gmail.com>

---
 MAINTAINERS |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6.26-rc1-git6/MAINTAINERS 
linux-2.6.26-rc1-git6-modified/MAINTAINERS
--- linux-2.6.26-rc1-git6/MAINTAINERS	2008-05-08 18:49:34.000000000 +0200
+++ linux-2.6.26-rc1-git6-modified2/MAINTAINERS	2008-05-16 21:26:10.000000000 
+0200
@@ -4385,10 +4385,10 @@ M:	johnpol@2ka.mipt.ru
 S:	Maintained
 
 W83791D HARDWARE MONITORING DRIVER
-P:	Charles Spirakis
-M:	bezaur@gmail.com
+P:	Marc Hulsman
+M:	m.hulsman@tudelft.nl
 L:	lm-sensors@lm-sensors.org
-S:	Odd Fixes
+S:	Maintained
 
 W83793 HARDWARE MONITORING DRIVER
 P:	Rudolf Marek


>
> Thanks,



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
