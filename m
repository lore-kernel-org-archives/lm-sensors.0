From: gtj.devel@peakin.com (George T. Joseph (development))
Date: Mon, 27 Nov 2006 23:14:14 +0000
Subject: [lm-sensors] Working on a driver for the Andigilog aSC7621
Message-Id: <22E26940476D1E48AA6F292B5316C9C33743@bes1.peakin.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
In-Reply-To: <22E26940476D1E48AA6F292B5316C9C33738@bes1.peakin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sensors-detect patch has a little bug:  You're using $mid to test
for the chip id instead of $cid.   

-----Original Message-----
From: Rudolf Marek [mailto:r.marek at assembler.cz] 
Sent: Saturday, November 25, 2006 8:50 AM
To: George T. Joseph (development)
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] Working on a driver for the Andigilog aSC7621

Hi George,

> The new Intel 975XBX2 MB has a aSC7621 sensor chip from Andigilog
(also
> just released).
> 
> http://www.andigilog.com/downloads/aSC7621_70A06010.pdf

Ok.

> I've gone through all the developer docs and have both the kernel
driver
> and userspace stuff working fairly well on 2.6.18.2.  Kernel patches
> I'll submit to the list but what do you want done for the lm-sensors
> userspace stuff? 

In separate patch, yes please to mailing list.

> The docs mention svn commit access but the referenced
> perl script to generate a password isn't in the latest svn trunk.
Just
> submit to list?

Yep.

> 
> BTW, thanks to all who went before me.  This was easier than I
expected.

Good ;) Btw I have written a sensors-detect patch for all Andigilog
devices. 
Please can you try that out?

Also they are using stepping fields to identify the device. This is no
good, the 
  patch as it is now will miss new steppings. Any idea how to solve it?
(perhaps 
some stepping interval?)

Do you have any good contact at that company to ask?

Thanks,
Regards
Rudolf

