From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: stub for driver testing (was Re: lm87 ported to Linux 2.6)
Message-Id: <20040825074706.M79409@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040824034244.GA23169@jupiter.solarsys.private>
In-Reply-To: <20040824034244.GA23169@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Stuff like this probably isn't appropriate for kernel.org (Greg?)
> 
> Why not?  It looks useful to me.  Care to send me a patch adding 
> this to the main kernel tree?

I agree it sounds very useful for testing, and the driver isn't that big. Just
make in clear in the help text that the regular guy doesn't need this.

I think that this driver would be even more useful if it was possible to
"load" a register map into it. I guess it should be possible to have a sysfs
interface, much like we have for the eeprom driver, but writable. That way we
could test almost anything in the driver, including the
detection/identification step, and possibly even simulate temperature changes
and the like. Testing would look like:
1* Load i2c-stub.
2* Write (binary) register map.
3* Load chip driver.
4* Test the driver and possibly change registers values on the fly (dd or some
perl should do).

An alternative interface file could be one to which we'd write "address value"
pairs. I don't know which is easier to implement or more convenient. Thoughts?

Note that I've not been able to test the driver yet, will do as time permits.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
