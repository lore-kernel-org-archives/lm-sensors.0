From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [Fwd: userland i2c ioctl commands..]
Message-Id: <3FAACF03.3040900@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm guessing somebody else can answer this better than I can.  Who wants 
to take a stab?


Phil

-------- Original Message --------
From: 	- Thu Nov 6 14:43:07 2003
X-UIDL: 	63bd79ec803c391a
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00000000
Return-Path: 	<kkyzivat@physiometrix.com>
Received: 	from mercury.physiometrix.com (mercury.physiometrix.com 
[66.112.162.232]) by Ren.netroedge.com (8.12.10/8.12.8) with ESMTP id 
hA6MSoJE002924 for <phil@netroedge.com>; Thu, 6 Nov 2003 14:28:50 -0800
Received: 	from MA01WK-KK.physiometrix.com [192.168.168.83] by 
mercury.physiometrix.com with XWall v3.28 ; Thu, 6 Nov 2003 17:42:14 -0500
Message-ID: 	<3FAACE45.3010200@physiometrix.com>
Date: 	Thu, 06 Nov 2003 17:42:13 -0500
From: 	Keith Kyzivat <kkyzivat@physiometrix.com>
User-Agent: 	Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) 
Gecko/20030924 Thunderbird/0.3
X-Accept-Language: 	en-us, en
MIME-Version: 	1.0
To: 	phil@netroedge.com
Subject: 	userland i2c ioctl commands..
Content-Type: 	text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 	7bit
X-Quarentine-Loop: 	Processed
X-Spambayes-Classification: 	ham; 0.01



Hello Phil,

I'm trying to track down why i2c ioctl command defines and other 
userland useful bits were left out of i2c-dev.h in the kernel includes. 

After upgrading to the latest 2.4.22 kernel from an older 2.4.21 kernel, 
our i2c SMBus code failed to compile -- I tracked it down to a missing 
i2c IOCTL command define that was originally in i2c.h - (still is 
actually) that was included by i2c-dev.h.  This no longer happens...
I noticed that the newer version of i2c.h doesn't have kernel 
conditional code, and it breaks if userland code includes it (due to the 
externed syscall function prototypes for one)...

I poked around at your lmsensors package, and I notice that it provides 
its own i2c-dev.h file -- including all the ioctl commands and other 
parameters that are in i2c.h, along with the normal contents of 
i2c-dev.h from the kernel includes.

My question to you is, will the __KERNEL__ checking return, letting 
userspace programs include i2c.h again?
I'm trying to keep my program as OS independant as possible, and this 
just adds to the os-specific stuff (having to add a modified i2c-dev.h 
file)...

Thank you!
Keith Kyzivat
Software Architect
Physiometrix, Inc.


