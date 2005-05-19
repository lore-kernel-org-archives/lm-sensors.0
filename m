From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: solved ticket 1344
Message-Id: <20030722155338.4e9c45da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F1C12F2.3080402@informatik.uni-erlangen.de>
In-Reply-To: <3F1C12F2.3080402@informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I switched module compilation of, since I already compiled them with
> the kernel.

I'm not sure I get you. If you followed my installation guide, the
modules you had in the kernel were the I2C ones only, not the LM Sensors
one. Or did you also applied a patch to include the LM Sensors module
into the kernel?

> Your Makefile is not creating sensors.h, since it is not
> included in the SRCDIRS variable.

You're right, that's the way it is.

> After switching on kernel module compilation, the header file is 
> created. This solution is not really nice, since it would overwrite
> the already created modules.

As said in the Makefile, you are not supposed to change that variable.
You should have been using "make user" and "make user_install" instead.
However, I agree that there is something to fix there. If we can't use
the var it should be removed. If we want to be able to use it, we have
to fix it. An opinion anyone?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
