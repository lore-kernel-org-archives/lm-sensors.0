From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Wed, 04 Apr 2007 19:49:20 +0000
Subject: [lm-sensors] What about i2c_smbus_read_block_data() ?
Message-Id: <200704042149.21264.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm working on a driver for LM93. I've got some code by Mark Hoffman, (c)2004. 
It doesn't compile on a recent kernel, because it heavily uses a function called
i2c_smbus_read_block_data(). Googling for that, I found this old mail in the
archives (October 2005):

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-October/013971.html

Jean, what do you say to that today? Can we have that function back in
mainline, or do I have to find another solution?
If you agree to add it, I could prepare a patch for it, if you don't have
a recent version handy.

Thanks,
Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
