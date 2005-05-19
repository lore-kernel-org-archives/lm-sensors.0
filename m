From: kw42@gmx.de (Klaus Woltereck)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: W83791 (was: How to activate the SMBus on P4B533E/ICH4?)
Message-Id: <Pine.LNX.4.31.0206221506270.11389-100000@klaus.dns2go.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 21 Jun 2002, Mark Studebaker wrote:

> I'll look into the 40004 messages.

It was my fault:

> > Jun 21 21:12:08 test kernel: i2c-proc.o version 2.6.1 (20010825)
Jun 24 11:14:00 test kernel: i2c-core.o: i2c core module version 2.6.4-CVS (2002xxx)

I forgot to run 'make install' in the CVS-i2c directory.


W83791:

I just added some rudimentary support for the W83791SD in the w83781d
module.

Before I go on, I would like to know if anyone already done this?

If so, please me know!

Bye,
Klaus





