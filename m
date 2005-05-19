From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <riBa2FRg.1102440984.8679050.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ian,

> > Also, I think that what you do with i2c_transfer is similar to
> > I2C_FUNC_SMBUS_READ_I2C_BLOCK, which is supported by some SMBus
> > (non-I2C) masters.
>
> I've checked it out and I don't think they are similar enough, however I
> would appreciate your input.
>
> The ds1338 (same i2c interface as ds1307 and I just happen to have the
> data sheet in front of me) expects a write (slave receiving) to look
> like this (I hope my notation makes sense...)
>
>  S <slave addr> W ACK <address(n)> A <data(n)> A <data(n+1)> A <....> A P
>
> Where address(n) sets the register address to start writing at. There
> are then as many data bytes as you like, each acknowledged, followed by
> the stop bit.
>
> SMBUS block write is
>
>  S <slave_addr> W A <command> A <count> A <data(1)> A <....> <data(count)>
>       A P
>
> The SMBUS <command> could be considered to be the ds1338 <address(n)>
> but then there is an extra byte in the smbus for the count.
>
> The read commands follow the same basic scheme in both cases.

Look at the I2C block reads and writes. Theses are similar to the SMBus
writes but without the count byte.

For some reason these are called i2c_smbus_read/write_i2c_block_data but
these are NOT SMBus transfers (as Mark Studebaker underlined elsewhere).

> On a separate thread -- I had a thought that perhaps I2C_FUNC_I2C should
> include the SMBUS_EMUL definitions since (I think you said) that any i2c
> device can emulate smbus...

We can't because FUNC_SMBUS_EMUL only makes sense for bus drivers while
FUNC_I2C makes sense for both bus and chip drivers. We could do it the
other way around though as Mark Studebaker suggested. Or we can leave
things the way they are. FUNC_SMBUS_EMUL is really a shortcut to help
chip drivers verify if a bus driver supports one given SMBus command
(and as such its definition is likely to change in the future). FUNC_I2C
means that any arbitrary I2C transfer can be achieved. Although a master
will support both or none (as far as I can see) they are separate
things. I think things are clearer if we keep them separate. It
shouldn't be hard to add I2C_FUNC_I2C to the busses which support it,
they aren't that many, really.

Thanks,
--
Jean
