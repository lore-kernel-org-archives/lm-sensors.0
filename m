From: kirbratr@yahoo.com (Kirby Dotson)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: No subject
Message-Id: <20031106002950.94724.qmail@web40504.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I', getting compile errors.  I've tried what was in
the  documentation.  Any clues on the following.

Kirby

[root@alpha lm_sensors-2.8.1]#
kernel/busses/i2c-nforce2.c:387: warning: implicit
declaration of function `__devexit_p'
> kernel/busses/i2c-nforce2.c:387: initializer element
is not constant
> kernel/busses/i2c-nforce2.c:387: (near
initialization for `nforce2_driver.remove')
> kernel/busses/i2c-nforce2.c:388: initializer element
is not constant
> kernel/busses/i2c-nforce2.c:388: (near
initialization for `nforce2_driver')
bash: syntax error near unexpected token
``nforce2_driver')'
[root@alpha lm_sensors-2.8.1]# make: ***
[kernel/busses/i2c-nforce2.o] Error 1
bash: make:: command not found
[root@alpha lm_sensors-2.8.1]#
[root@alpha lm_sensors-2.8.1]#


__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
