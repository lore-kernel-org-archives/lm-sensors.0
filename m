From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 May 2008 10:43:58 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080509124358.779c4bfb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 09 May 2008 07:03:19 +0200, Hans de Goede wrote:
> Perhaps it would be an idea to try to do an i2c (*) read transfer of more then 
> 1 byte, it would be interesting to see how this specific 1 register device 
> responds to this, maybe it will stop acking after the first byte is transfered 
> because it has only one byte to send.

In master-receiver, slave-transmitter mode, it's the master who sets
the ack bit, depending on whether it will ask for more bytes after that
one (ack) or not (nack). The slave doesn't have its say. All the slave
can do is send zero or maybe random bytes if it doesn't have data to
send. Slaves which know how to stretch the SCL pulses could hold SCL
low as a reprisal, too, temporarily or permanently, but that's about it.

> OTOH I have no idea how regular smbus devices which normally do write reg 
> address, then read transactions respond to larger then 1 byte reads.

I don't know either, but I fear that the answer is: it depends. And
the answer is probably the same for 1-register-only devices. Note for
example, that any SMBus device supporting PEC would be perfectly happy
to send a second byte, which would be the PEC byte. So, I don't think
that the method you proposed can be used to differentiate between the
two families of devices.

> * Calling it i2c here to make clear I mean an low level read, not an smbus read 
> transaction where first the register to read gets written.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
