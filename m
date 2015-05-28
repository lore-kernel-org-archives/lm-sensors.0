From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 28 May 2015 15:45:19 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <20150528174519.4b7961be@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 May 2015 13:31:28 +0000 (UTC), Chris Godbout wrote:
> > Did you run i2cdump on I2C address 0x2c too? I'm going to blacklist
> > 0x4f on graphics cards by default, I need to know if I should do the
> > same for 0x2c too.
> 
> Yes, I did 0x2c as well and there were no problems at all. Only the 0x4f
> address did anythig. Here's the result of the dump:
> 
>  i2cdump 6 0x2c
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-6, address 0x2c, mode byte
> Continue? [Y/n] 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> a0: 01 06 03 01 01 00 ff ff ff ff ff ff ff ff ff ff    ?????...........
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00    ................

OK, I have no idea what chip that is, but it looks more standard than
the thing at 0x4f. So I won't blacklist I2C address 0x2c.

> > (...)
> > You're welcome, I'm glad if you managed to get the display to a usable
> > state again, to be honest I did not think we would succeed.
> 
> Yeah, I didn't think it would happen, either. Fortunately, it was still
> usuable, just rather unpleasant. I also set it to 0xbf like you mentioned in
> your followup and that seems to work just fine.  Again, thanks so much.

I'm surprised, as I actually expected 0xbf to lead to the broken state
the display was into after running sensors-detect (while value 0xff
would fix it, or at least make it better.) So there will be some
mystery left, which will last as long as we don't know which chip it is.

This is enough testing, I'll commit two safety fixes to sensors-detect.
Thanks for your cooperation.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
