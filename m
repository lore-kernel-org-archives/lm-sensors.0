From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: i2c-voodoo3
Message-Id: <40D9BBDA.4060000@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Humm, I've run into problems like this when mixing binaries of modules 
and kernel, or if different compilers were used when creating the kernel 
binary and/or modules.

Is it possible for you to build everything from source from scratch?  
Perhaps use the latest (2.8.7) of I2C and lm-sensors?


Phil

craig@haquarter.de wrote:

>Hello!
>I found your email adress at
>http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/busses/i2c-voodoo3
>when I was seeking information on the module.
>I am running Gentoo Linux and the module worked for me, which was very
>cool :)
>But 2 days ago I updated my Kernel, re-installed lm-sensors...and it didnt
>work any more, i2c-voodoo3 always segfaults.
>
>I also wrote a summery on the isse at:
>http://forums.gentoo.org/viewtopic.php?t9150&highlight>
>Do you have any idea what could be wrong? Any hint? I would be very cool
>if you could help me.
>
>Craig
>
>
>
>
>
>
>
>  
>
