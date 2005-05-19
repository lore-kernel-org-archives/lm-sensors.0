From: greg@hogan.com (Greg Hogan)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: IBM PPC 405 and I2C
Message-Id: <006801c35927$0358be50$bd00a8c0@laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am working with a powerpc 405 chip, which supports both master and slave
in the hardware.  The linux distribution is Montavista Hardhat.

1)  The i2c files i2c-algo-ibm_ocp.h, i2c-algo-ibm_ocp.c, and
i2c-adap-ibm_ocp.c were written by Montavista.  Unfortunately, they do not
support slave mode.  Has anyone outside Montavista added functionality to
this code?  Does Montavista provide updates often (it appears the code with
the Montavista distribution has significant modifications over what is
distributed with i2c, unfortunately I do not have the code available to me
now)?

2)  Has anyone successfully insmoded the i2c-algo_ibm_ocp and
i2c-adap-ibm_ocp modules together?  Insmod complains about recursive
includes (which is true, the files call on functions in the other file) when
loading either module.

3)  There have been several inquiries about using a host/bus in slave mode.
Has anyone done work on this since the postings?  Are their plans to
implement this at some point?  What would be required to add slave
functionality to the core i2c files?

Thanks,
Greg Hogan

