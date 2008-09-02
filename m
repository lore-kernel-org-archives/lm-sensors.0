From: =?iso-8859-1?Q?Hector_Lahoz_Gra=F1ena?= <hectorlahoz@yahoo.es>
Date: Tue, 02 Sep 2008 09:48:57 +0000
Subject: [lm-sensors] plans to implement Smartguardian support on it87 chips?
Message-Id: <732978.84919.qm@web26404.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello
Are there any plans to implement Smartguardian (i.e. fan speed control) for the it87 family?
I've discovered that the "fix_pwm_polarity" driver option is not so dangerous. But now that
I have PWM working I don't know how to do something useful with this.
Should I write a daemon to control the fans or is the driver who has to do the work?

Another possibility is using the smartguardian automatic mode which has the advantage, I think;
that it's easy to implement and causes no CPU overload.
By the way, the programming interface thar appears in the datasheet does not correspond to
my chip (it8705 version 2). I almost go crazy.

Sorry for my poor english



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
