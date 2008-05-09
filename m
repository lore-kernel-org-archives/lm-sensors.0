From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 09 May 2008 05:03:19 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <4823DB17.6010303@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
> 

<intro snipped>

> 
> This time, my idea is to let sensors-detect attempt to figure out when
> it is about to probe an I2C address where such a 1-register-only device
> lives, and skip that probe. It's not easy, but I have come up with a
> heuristic which I think should work in most cases, and should be
> reasonably safe.
> 
> The idea is to start with two SMBus receive byte transactions. This
> should give us the value of the single register - if what we have is a
> 1-register-only device. Then we'd send the same byte, and read again.
> In theory this should still return the same value. Then we write the
> same value with LSB inverted. Reading again should return the same
> value with LSB inverted. If all the tests pass, we write one last time
> the original register value, and leave the device alone. If at some
> point a test fails, then it means that the device is probably not a
> 1-register-only device and must instead be a regular device which
> understand SMBus read byte, so sensors-detect can keep probing it.
> 
> The trick is that the above can be implemented using only SMBus "read"
> transactions (receive byte and read byte.) We were already doing random
> SMBus read byte transactions so there is no change there. My hope is
> that adding SMBus receive byte transactions at the beginning should do
> no harm. But of course only testing will tell.
> 


Perhaps it would be an idea to try to do an i2c (*) read transfer of more then 
1 byte, it would be interesting to see how this specific 1 register device 
responds to this, maybe it will stop acking after the first byte is transfered 
because it has only one byte to send.

OTOH I have no idea how regular smbus devices which normally do write reg 
address, then read transactions respond to larger then 1 byte reads.

* Calling it i2c here to make clear I mean an low level read, not an smbus read 
transaction where first the register to read gets written.

---

About the potential for doing an i2c read of 1 byte from a device which expects 
a write reg address to read, then read 1 byte style transactions, causing 
problems, I don't think this will cause issues, normally these kind of devices 
are implemented using a read ptr, which tells the device where to start reading 
in its internal memory map when an i2c read transaction is done. With the write 
addr, then read cycle, the write sets that read ptr, so reading without the 
write would give one the contents of a random register address and should not 
be a problem otherwise.

Some devices may have additional checks build in though, and only accept a read 
if there was a write before it within the same transaction (so in i2c terms:
{ start, write register address, repeated-start, read register contents, stop }

I've seen devices which wouldn't work if the repeated-start above was a { stop, 
start } (dallas ds1621 temp sensor) Note: 1 this is not an smbus device, 2 I 
don't remember how it failed.

But given that some smbus devices may be like the ds1621 and demand an address 
write before a read in one transaction (so seperated by a repeated start), it 
could be that the initial read in this proposed patch fails in that case with 
an error because the sensor at 0x2e refuses the read and thus does not ack when 
it gets addressed for the read transfer.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
