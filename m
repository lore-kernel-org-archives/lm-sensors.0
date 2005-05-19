From: p.koegler@el-me.de (=?iso-8859-1?Q?K=F6gler_Peter?=)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c_smbus_write_* will never work
Message-Id: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
i found a problem while using the driver at91_i2c.c from the arm linux
project: It is never possible to do a write operation. 

The following is a description of the error:
If you look at i2c_smbus_xfer_emulated() in i2c-core.c a message array
msg[2] with 2 messages is initialized. In the second message (msg[1]) the
flags member is always set to I2C_M_RD. 

So if you call any of the following methods
-i2c_smbus_read_byte     
-i2c_smbus_write_byte
-i2c_smbus_read_byte_data
-i2c_smbus_write_byte_data

the flag is set to I2C_M_RD. 

In the driver at91_i2c.c the bit MREAD of the TWI Master Mode Register is
always set according to the flags member of the second message and this
member is always set to I2C_M_RD. MREAD is responsible for read/write, so it
is never possible to do a write operation. 

This is the answer of the Atmel people who maintain the i2c driver for the
AT91RM9200:

Hi Peter.
Andrew forwarded me your e-mail concerning the
possible change of at91_i2c.c you proposed to
correct the explained I2C_M_RD bit which get set
incorrectly in the I2C emulating function
(i2c_smbus_xfer_emulated).

I have looked at the code, and saw that your founding
to be true ( well at least for the one I'm currently
working on now which is linux-2.4.25-vrs2 ),
that msg[1].flag is always READ. This however,
as far as I can tell, is incorrect.

What I do suggested to Andrew (and now to you)
is not to change the at91_i2c.c module to work around
the problem, but rather eliminate the source of the
problem, thus rather fix the i2c_smbus_xfer_emulated
function in i2c-core.c.

So my recommendation would be to fix-up the emulation
function by ensuring that msg[1].flags = msg[0].flags.
This *should* fix the problem.

By doing it this way, one also ensures that the at91_i2c
driver stays generic and compatible between devices on
the shared bus.
So I suggest you contact the i2c maintainer/developers,
and submitting a patch to the emulation function.
This is now an i2c issue, and not an arm specific one.


Hope this helps.

Kind regards,
Pieter Loubser

wbr
Peter

--------------------------------------------------------------
Peter K?gler
EL-ME AG
Gewerbering 1
D-84072 Au i. d. Hallertau

Tel.:     +49 / 8752 / 864 - 527
Fax.:     +49 / 8752 / 864 - 100
mailto.:  p.koegler@el-me.de         
Web:      www.el-me.de
 
