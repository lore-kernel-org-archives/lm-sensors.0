From: marekm@amelek.gda.pl (Marek Michalkiewicz)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: lm_sensors in 2.4.x kernel?
Message-Id: <E163DtE-0007QO-00@alf.amelek.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I've been successfully using the latest (CVS) lm_sensors drivers
with various 2.4.x kernels for quite a long time now.  The only
problem I see so far is having to patch the kernel each time - while
the mkpatch.pl script makes it fairly easy, it would be even easier
to simply have it in the kernel.  So I'm asking, are there any good
reasons (serious bugs that still need fixing, etc.) why this hasn't
happened yet?  (partially done for i2c drivers, but not lm_sensors)

Another patch I've been using for some time (ext3 filesystem) is
now included in 2.4.15-pre2, so there is already some precedent for
adding a lot of new code to stable 2.4.x kernel series...
After all, it's just a set of new optional drivers, which shouldn't
break anything if not enabled during kernel configuration.

Thanks,
Marek
