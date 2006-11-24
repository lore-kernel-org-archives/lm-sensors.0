From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Fri, 24 Nov 2006 18:08:42 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello All,

The new Intel 975XBX2 MB has a aSC7621 sensor chip from Andigilog (also
just released).

http://www.andigilog.com/downloads/aSC7621_70A06010.pdf

I've gone through all the developer docs and have both the kernel driver
and userspace stuff working fairly well on 2.6.18.2.  Kernel patches
I'll submit to the list but what do you want done for the lm-sensors
userspace stuff?  The docs mention svn commit access but the referenced
perl script to generate a password isn't in the latest svn trunk.  Just
submit to list?

BTW, thanks to all who went before me.  This was easier than I expected.

Thanks...george




