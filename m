From: c.bailiff+lmsensors@devsecure.com (Cris Bailiff)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: asus p4pe lm_sensors detection solved
Message-Id: <200306021819.39438.c.bailiff+lmsensors@devsecure.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been trying to get lm_sensors working correctly on an ASUS P4PE 
motherboard (the ASB100 Bach driver/ as99127f/w83781d) for quite a while.

The comments on your driver status page are:
---

Asus ASB100 Bach yes - as a as99127f (2.6.5) w83781d yes   2.6.5 

Contributed by Mark Hoffman. Several reports that the chip is not detected 
correctly.

---

I had tried a few months ago (using lm_sensors 2.7.0 as supplied with my 
mandrake9.1 distribution) and had a similar experience to that noted there 
and in your self-serve support ticket# 1108. The comment there said you were 
aware of the problem, but the fix may take a 'few weeks'.

(I couldn't find a way to comment on an existing ticket, and didn't want to 
open a new ticket to report a solution, so I'm sending this email to both the 
development list and the originator of #1108 directly.)

I noticed recently on the kernel mailing list that someone submitted a PCI 
quirks patch for the p4pe and other asus boards, to enable the i801 SMBus 
device, which asus have decided to disable by default on some boards:

http://www.cs.helsinki.fi/linux/linux-kernel/2003-11/0868.html

The patch was for 2.5.65, but I had no trouble pasting it into quirks.c on 
2.4.21 and re-building. 

This seems to do the trick - now sensors-detect has found some chips, made me 
a recommended configuration, and sensors now shows me a bunch of 
temperatures, voltages and speeds. I imagine I have some configuring still to 
do, but I figured you'd probably want to make a note of this in your FAQ...

Cheers,
Cris 

c.bailiff+lmsensors at devsecure.com


