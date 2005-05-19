From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: installing lm_sensors 2.8.1
Message-Id: <20031106190828.0d345682.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Please think of setting a subject to your e-mail next time.

> I', getting compile errors.  I've tried what was in
> the  documentation.  Any clues on the following.
> 
> Kirby
> 
> [root@alpha lm_sensors-2.8.1]#
> kernel/busses/i2c-nforce2.c:387: warning: implicit
> declaration of function `__devexit_p'
> > kernel/busses/i2c-nforce2.c:387: initializer element
> is not constant
> > kernel/busses/i2c-nforce2.c:387: (near
> initialization for `nforce2_driver.remove')
> > kernel/busses/i2c-nforce2.c:388: initializer element
> is not constant
> > kernel/busses/i2c-nforce2.c:388: (near
> initialization for `nforce2_driver')
> bash: syntax error near unexpected token
> ``nforce2_driver')'
> [root@alpha lm_sensors-2.8.1]# make: ***
> [kernel/busses/i2c-nforce2.o] Error 1
> bash: make:: command not found
> [root@alpha lm_sensors-2.8.1]#
> [root@alpha lm_sensors-2.8.1]#

You must install i2c-2.8.1 prior to lm_sensors-2.8.1. For details on how
to install i2c-2.8.1, please refer to our installation guide:

http://delvare.free.fr/i2c/
(or http://www.ensicaen.ismra.fr/~delvare/devel/i2c/)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
