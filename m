From: sami.virtanen@bredband.net (Sami Virtanen)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: SENSDEV problems with Makefile in prog/rrd/
Message-Id: <20040211120945.BNUH21240.mxfep02.bredband.com@mo0ze>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello there!

 

First of all i would like to thank you for your great work with the sensors!

 

Okay here's my problem:

 

 

I cant make the rrd package it just ends up saying: Makefile:32: *** error -
sensor asb100-i2c-1-2d not installed - check SENSDEV definition in Makefile.
Stop.

 

And according to output from doing the cmd sensors it is the asb100-i2c-1-2d
sensor being used.

 

My system: 

 

Debian 3.0 with 2.6.2 kernel and lm_sensors 2.8.4 compiled with make user
and make user_install.

 

What am I doing wrong? Or is it just the script package that isn't using the
new /sys instead of the old /proc?

 

I have no clue and im hoping for atleast a hint on this.

 

 

Best regards Sami Virtanen

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040211/6299f16f/attachment.html
