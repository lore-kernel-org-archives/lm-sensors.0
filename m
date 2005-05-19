From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <41B5DE23.3070502@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Ian Campbell wrote:
> On Sun, 2004-12-05 at 13:53 +0100, Jean Delvare wrote:
> 
>>Also, I think that what you do with i2c_transfer is similar to
>>I2C_FUNC_SMBUS_READ_I2C_BLOCK, which is supported by some SMBus
>>(non-I2C) masters.
> 
> 
> I've checked it out and I don't think they are similar enough, however I
> would appreciate your input.
> 
> The ds1338 (same i2c interface as ds1307 and I just happen to have the
> data sheet in front of me) expects a write (slave receiving) to look
> like this (I hope my notation makes sense...)
> 
>   S <slave addr> W ACK <address(n)> A <data(n)> A <data(n+1)> A <....> A P
> 
> Where address(n) sets the register address to start writing at. There
> are then as many data bytes as you like, each acknowledged, followed by
> the stop bit.
> 
> SMBUS block write is
> 
>   S <slave_addr> W A <command> A <count> A <data(1)> A <....> <data(count)> A P
> 
> The SMBUS <command> could be considered to be the ds1338 <address(n)>
> but then there is an extra byte in the smbus for the count.
> 
> The read commands follow the same basic scheme in both cases.
> 
> I can't see another SMBUS transfer that would fit, unless there is some
> sort of 'repeated send byte' that I haven't spotted.
> 

The I2C_FUNC_SMBUS_{READ|WRITE}_I2C_BLOCK functionalities are "true" i2c block transfers,
not smbus transfers; don't let the name fool you.


> On a separate thread -- I had a thought that perhaps I2C_FUNC_I2C should
> include the SMBUS_EMUL definitions since (I think you said) that any i2c
> device can emulate smbus...

I2C_FUNC_I2C was defined at the very beginnning (and documented in doc/functionality in the i2c tree)
but never used by anything in the i2c or sensors tree; it looks pretty much forgotten.
So chip drivers looking for that functionality bit won't find it anywhere.

I think the best way to fix it is to add I2C_FUNC_I2C to the I2C_FUNC_SMBUS_EMUL bitmask in i2c.h.
Then everyone should be happy.
comments?

