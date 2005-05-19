From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030811155717.250dfa86.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I forgot to mention: The 2.8.0 enabled kernel and drivers have a tag
> like 2.4.20-19.23.rhxxx.at, while the non-enabled RH proper stuff has
> the usual 2.4.20-19.x tag.

Is it something we should mention somewhere on our site, or is it obvous
on your side?

> I will be on vacation this week, and lirc is quite a nasty beast to
> package (all different builds have the same name), so I won't be
> really looking into it until the end of August, I guess.

I finished the patches (one for 0.6.6 on another user's request, one for
CVS), they are available on my page.

> BTW the 2.8.0 patched drivers, do they compile against < 2.8.0? I
> assumed not, so I have built in a 2.8.0 kernel detection in the rpm
> specfiles, so the patches are only applied if the kernel has 2.8.0 i2c
> embedded (currently the match checking is exact, so it needs to be
> reworked for 2.8.1 or 2.9.0).

You assumed just right. The patches we provide are filling the gap
between us modifying the structures and these new structures being
integrated into the kernel tree. They are not definitive patches, they
are just meant to support the users during the transition time. Once our
patch is integrated into the kernel (should be in 2.4.23, or at least we
hope so), each other project using i2c will have to support the new
structures and should support both pre and post transition kernels.

My plan is to release 2.8.1 right after linux 2.4.22, so we can have a
real CVS version integrated into the kernel, not just a CVS snapshot at
a given point in time, so we'll have to rebuild another set of
user-supporting patches on my side, and another set of packages on your
side. After that, things should be somewhat easier.

Have a nice vacation :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
