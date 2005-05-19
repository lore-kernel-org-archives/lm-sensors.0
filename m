From: mluessi@hsr.ch (Martin Luessi)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: fan cotrol register for it87, kernel 2.6
Message-Id: <200409191830.01507.mluessi@hsr.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I use kernel 2.6 and my motherboard uses an IT8705 controller. 
With my mobo the cpu-fan runs allways at max. speed so I started
to look at the driver-source. In lm_sensors 2-8.7, it87.c there are functions 
to write to the  fan - control registers. 
I have already ported the code for some registers to the kernel 2.6 module
and it is working.

My questions are:
- does anybody know who maintains this module?
- what are the reasons that the fan-control code is not in the 2.6 module?

Thanks, Martin

PS: please reply to my e-mail address, I have not (yet) subscribed to this 
list 
