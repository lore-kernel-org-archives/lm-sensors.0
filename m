From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: bt869 user feedback
Message-Id: <3F185730.7040309@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



-------- Original Message --------
From: 	- Fri Jul 18 13:21:06 2003
X-UIDL: 	2ef9b05b94e308a4
X-Mozilla-Status: 	0001
X-Mozilla-Status2: 	00800000
Return-Path: 	<thephantom@aei.ca>
Received: 	from aeimail.aei.ca (root@aeimail.aei.ca [206.123.6.14]) by 
Ren.netroedge.com (8.12.8p1/8.9.1) with ESMTP id h6IK9LvL013499 for 
<phil@netroedge.com>; Fri, 18 Jul 2003 13:09:22 -0700
Received: 	from aei.ca (phantom@dsl-140-185.aei.ca [66.36.140.185]) by 
aeimail.aei.ca (8.11.6/8.10.1) with ESMTP id h6IKIHk04571 for 
<phil@netroedge.com>; Fri, 18 Jul 2003 16:18:17 -0400 (EDT)
Message-ID: 	<3F185605.8070802@aei.ca>
Disposition-Notification-To: 	Phantom <thephantom@aei.ca>
Date: 	Fri, 18 Jul 2003 16:18:13 -0400
From: 	Phantom <thephantom@aei.ca>
User-Agent: 	Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030625
X-Accept-Language: 	en-us, en
MIME-Version: 	1.0
To: 	phil@netroedge.com
X-Enigmail-Version: 	0.74.3.0
X-Enigmail-Supports: 	pgp-inline, pgp-mime
Content-Type: 	text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 	7bit
X-SpamBouncer: 	1.5 (8/16/02)
X-SBClass: 	OK
X-Spambayes-Classification: 	unsure; 0.26



Hi
I tried the bt869 driver and here is the result:
1) insmod it enable the output, but in monochrome
2) cat any value to the proc files make the screen goes blank, rmmod and 
insmod fix it
3) reading the value of those proc files also blank the screen (same as 2)
4) colorbar dosen't show up (blank screen, issue 2)
5) svideo dosen't seems to work (issue 2 related?)

System:
Voodoo 3 3500TV
NTSC composite tv


amd athlon 1.4, 512megs ddr
gentoo
kernel 2.4.20-openmosix
xfree 4.3.0 / gnome



