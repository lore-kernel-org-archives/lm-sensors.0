From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Sep 2005 09:22:16 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <20050918092253.1b199195.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4e191e7050915035768c521ef@mail.gmail.com>
In-Reply-To: <b4e191e7050915035768c521ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> We've now implemented simple SMBus on our microcontrollers, and it is
> mostly working. block writes work perfectly, but we are having a small
> problem with block reads on the PC side. It seems from the register
> dumps in the kernel logs that the first byte is going to the DAT0
> register instead of into the BLK, so in userspace, it appears like the
> first byte is lost. (DAT1 remains 00, though). As far as we can tell,
> the data on the bus is correct, but our oscilloscope is nice and old,
> making it impossible to see the whole transaction.

There are two kinds of block reads defined in the SMBus specification,
regular Block Read and I2C Block Read. In the former, the first byte
received is an information of how many bytes follow. This first byte
typically goes in DAT0 rather than the BLK buffer. In the latter, data
is send directly and all bytes are stored in BLK. I guess that you
currently use the former when what you need is actually the latter.

Note that a client chip can only support one of the two kinds of block
reads at any register address ("command byte" in the SMBus
specification), as there is no way to distinguish between both commands
from the client's point of view. It's up to the master (PC) to use the
correct one depending on what the client implements.

> The EPERMs reappeared as we were working, but disappeared when we
> started doing things correctly on the bus. They were probably actually
> a Good Thing, better than getting garbage or something more fatal, so
> I don't think you should worry about it.

OK, thanks for lettng me know.

-- 
Jean Delvare
