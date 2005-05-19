From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c_smbus_write_* will never work
Message-Id: <200407121142.i6CBgXqY020839@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
In-Reply-To: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Peter, all,

>can you confirm that i2c_smbus_xfer_emulated is called and not smbus_xfer
>when you communicate (see i2c_smbus_xfer) to the chip.

To be honest, I didn't know much about all the internals of i2c-core,
i2c_smbux_xfer, i2c_smbus_xfer_emulated etc... so I just took a deeper
look at how things work. Things *look* rather clear to me now and I'm
quite confident that there is no bug in i2c_smbus_xfer_emulated.
However, remember that I am not the authority when it comes to the i2c
subsystem internals, and only really read that code carefully for the
first time, well, 10 minutes ago ;) but since I wrote a few chip drivers
and read quite a handful datasheets dealing with I2C, SMBus and the
like, I think that my understanding of the problem is correct.

First, to answer your question: yes, i2c_smbus_xfer_emulated was used in
my case. The i2c-algo-bit algorithm does define master_xfer but doesn't
define master_smbus. If you look at i2c_smbus_xfer (in i2c-core), which
is the real dispatcher function, you'll find this:

	if (adap->algo->smbus_xfer) {
		down(&adap->bus);
		res = adap->algo->smbus_xfer(adap,addr,flags,read_write,
		                                command,size,data);
		up(&adap->bus);
	} else
		res = i2c_smbus_xfer_emulated(adap,addr,flags,read_write,
	                                      command,size,data);

So i2c_smbus_xfer_emulated has to be called when smbus_xfer isn't
defined, which is the case for me.

Now, looking at the i2c_smbus_xfer_emulated function itself, you'll see
that it defines two i2c messages:

	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+2];
	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
	int num = read_write = I2C_SMBUS_READ?2:1;
	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 },
	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
	                        };

But you should also notice that both are not necessarily used. More
precisely, the number of messages used is defined by "num". For
"read" commands, two messages are used. For "write" commands, only
one.

The reason is pretty obvious if you know the SMBus protocol. When you
write to a chip, you send a single write message. But when you read from
a chip, you must first "write" a few control bytes to the chip (such
as the register you want to read from; here, "write" is to be
understood as "bytes are emitted by the master to the attention of a
slave chip", not necessarily something that will be written to a
register in the chip), and only then read the answer of the chip
(separated by a repeated-start if I remember correctly). So for read
commands you have a "write" message first and a "read" message then.
Two messages total.

This means that the first (and only, in the case of a write command)
message is always a "write" one, and the second, when used (i.e. in
the case of a read command), is always a "read" one. Thus the way
flags are initialized for msg. Note that the flags parameter as passed
to the function are not allowed to have the I2C_M_RD bit set (any flags
but I2C_M_TEN and I2C_CLIENT_PEC are filtered out by i2c_smbus_xfer), so
we are not "forcing" the second message to be a "read" one. We are
really setting both messages mode (although it happens to be invisible
for write mode, because 1 is read and 0 is write).

So all in all the code looks fine to me.

On the other hand, quoting your original post:

> In the driver at91_i2c.c the bit MREAD of the TWI Master Mode Register is
> always set according to the flags member of the second message and this
> member is always set to I2C_M_RD. MREAD is responsible for read/write, so
> it is never possible to do a write operation.

This doesn't sound good at all. Setting the MREAD bit from the second
message's flags is not correct. For one thing, in the case of a write,
this second message isn't even supposed to be there (num=1!). For
another, as I just explained, the bit is always set to 1 (read) because,
if the second message is used, it is always for a read message.

I don't know why you do need to set the MREAD bit in your at91_i2c
driver. It sounds a bit strange since if you're going to handle "read
commands" and "write commands" (as opposed to just messages) then you
place yourself at the SMBus level and then the driver should not rely on
our emulation code. If for some reason you really have to do that, a
quick fix would be to use the message count (num) to detect the mode.
num=1 means we are writing, num=2 means we are reading. It looks a big
ugly and I suspect that a cleaner fix must exist, but only someone used
to at91_i2c code can deal with this (so not me). At any rate, the
problem you reported isn't due to a bug in our code, but to at91_i2c
misusing it (IMVHO).

I'd appreciate if Mark (or anyone with more experience about this than I
have myself, Phil maybe?) could confirm my analysis.

Thanks,
Jean Delvare
