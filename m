From: covex@ahoj.fsik.cvut.cz (Adam Pribyl)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: 2.6 user space tools
Message-Id: <Pine.LNX.4.44.0312212204030.14510-100000@ahoj.fsik.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Besides I was very disappointed that 2.6.0 has only few lmsensors and i2c
modules inside (btw. from 2.8.x my chips detect as w83627hf istead w83781d
and w83781d is not working anymore) I was also not able to compile user
space tools from 2.8.2.

"make user" end's up like this:

make: *** No rule to make target `asm-generic/errno.h', needed by 
`prog/sensors/main.rd'.  Stop.

Adam Pribyl
