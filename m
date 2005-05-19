From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 driver
Message-Id: <20030704105109.77a0d0f5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I will, but I prefer to make sure the driver works OK before that.
> > And also, it is a minimalistic driver for now (doesn't handle
> > alarms, alarms mask and so on) so maybe it would be better to
> > enhance it on the 2.4 side and port it later to 2.5 than the
> > contrary.
> 
> Why?  2.5 can have minimal drivers :)

OK, I agree. I can port my driver to 2.5 before adding new features,
you're right.

> And it will get better coverage than the sensors cvs tree I bet...

Well, the CVS tree is to become release 2.8.0 soon, so the driver should
have a chance to get tested. Second, I don't have a working 2.5 kernel
here, so I wouldn't be able to make sure my driver even compiles (not to
say loads). I'll try to build a 2.5 kernel on one of my machines. Is
there anything special required (gcc, binutils, modutils?) Last time I
tried 2.5 I couldn't even compile it (I even wonder if I managed
configuring it at all.)

What I really would like right now is a preliminary test of my driver.
Zoleg, do you read us? After all, you're the one who asked for the
driver, so it would be only fair that you would test it now :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
