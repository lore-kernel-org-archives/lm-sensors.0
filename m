From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: pwmconfig
Message-Id: <20030721150329.71cb4332.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721115123.11b859d1.khali@linux-fr.org>
In-Reply-To: <20030721115123.11b859d1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> thanks for testing and patching pwmconfig.

Patch commited to CVS btw.

> Regarding the tempsensor issue, does the same thing happen if you
> change PWM values manually?

I didn't try that. What values am I supposed to put there? I have two
pwm files and their default values are different:

hyperion:/proc/sys/dev/sensors/as99127f-i2c-3-2d> cat pwm1
0 1
hyperion:/proc/sys/dev/sensors/as99127f-i2c-3-2d> cat pwm2
143 1

I just don't know what the values mean, so please tell me what I'm
supposed to write to the files.

BTW, reading from the files did not break anything, at least :)

> > Additionally, pwmconfig does not work for me, but maybe that's just
> > my system not supporting it.
> 
> You mean your fans don't respond to PWM changes? There's a high chance
> your mainboard has no support, maybe this page has some info on it:
> http://www.almico.com/forumindex.php

Ah, that's the page I had been looking for. In your script, you suggest
to go there: http://www.almico.com/speedfan.php. Don't you think we
should change this URI in your script to
http://www.almico.com/forumindex.php? That's where the information
really is.

BTW, I think I'll give a try to FanSpeed. That way I'll know what my
hardware supports.

> If you're a bit crazy, you could add the fan control circuit yourself,
> then my homepage may be of use for you: http://www.hdev.de

I am crazy for sure, but probably not to that extent ;) Nice work you
did however.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
