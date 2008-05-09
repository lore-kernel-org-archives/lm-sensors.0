From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 09 May 2008 05:06:23 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <4823DBCF.4090902@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

<snip>

> 
> About the potential for doing an i2c read of 1 byte from a device which expects 
> a write reg address to read, then read 1 byte style transactions, causing 
> problems, I don't think this will cause issues, normally these kind of devices 
> are implemented using a read ptr, which tells the device where to start reading 
> in its internal memory map when an i2c read transaction is done. With the write 
> addr, then read cycle, the write sets that read ptr, so reading without the 
> write would give one the contents of a random register address and should not 
> be a problem otherwise.
> 
> Some devices may have additional checks build in though, and only accept a read 
> if there was a write before it within the same transaction (so in i2c terms:
> { start, write register address, repeated-start, read register contents, stop }
> 
> I've seen devices which wouldn't work if the repeated-start above was a { stop, 
> start } (dallas ds1621 temp sensor) Note: 1 this is not an smbus device, 2 I 
> don't remember how it failed.
> 
> But given that some smbus devices may be like the ds1621 and demand an address 
> write before a read in one transaction (so seperated by a repeated start), it 
> could be that the initial read in this proposed patch fails in that case with 
> an error because the sensor at 0x2e refuses the read and thus does not ack when 
> it gets addressed for the read transfer.
> 

And the point I was trying to make here but didn't is that I thus believe that 
the first 1 byte read in the new detection code should have error handling 
added, because it might fail (due to no ack) in which case we clearly do not 
have a 1 reg device.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
