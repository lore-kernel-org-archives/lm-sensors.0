From: bmeier@infovia.com.ar (Beat Meier)
Date: Wed, 10 Aug 2005 16:09:52 +0000
Subject: [lm-sensors] Backport to 2.4 kernel of lm77 to use in wrap board
Message-Id: <42FA0A66.1050504@infovia.com.ar>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

I'm trying to backport lm77 to kernel 2.4.
lm77.c compiles :-) but it is not recognized on the wrap board.
The lm77 on wrap is accessible on secondary I2C bus at address 90h
How can I access it there?

I've seen in a thread that in 2.6 you must use scx200_acb (because no 
userspace support).
What can I use in 2.4 kernel so the lm77 is acessible?

To get/set temperature do I need userspace support?


Thanks for any help

Beat
