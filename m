From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 22 Feb 2011 22:20:09 +0000
Subject: Re: [lm-sensors] Add support for LM75A.
Message-Id: <20110222222009.GK343@caffeine.csclub.uwaterloo.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110219115159.2da19dfe@endymion.delvare>
In-Reply-To: <20110219115159.2da19dfe@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 22, 2011 at 11:10:44PM +0100, Jean Delvare wrote:
> This is generally true, so much that we did not bother including the
> vendor name in i2c device IDs (matching is done on the name string
> alone.) But apparently the LM75 is such a popular device that is has
> more clones than any other I2C device I know of, including, sadly, some
> with the exact same name, but not 100% compatible, from other vendors.

What a mess.

> I beg to disagree. I would say that both detections are comparable. The
> LM75-specific behavior of "registers" (or lack thereof) 0x04-0x07,
> coupled with their cycling, is an almost unique characteristic (which
> is why we decided to use it for detection purpose.) If you ask me, I
> would say that a random chip at an LM75-compatible address is less
> likely to implement this characteristic than to have value 0xA as the
> high nibble of register 0x07.

It isn't that unique, that's true.  But combined with address cycling
and the other checks?

> It has been problematic, and was improved over time. You can see the
> first version of the detection code here:
>   http://www.lm-sensors.org/browser/lm-sensors/trunk/kernel/chips/lm75.c?rev38

Certainly a bit simpler than the current one.

> OK, fine with me.

Done in the new version.

> Yes and no. 4 bits for the device ID is weak, especially when in a
> random register (which is why I insisted in using the whole 8 bits,
> including the revision.) "Good" devices have 8 bits of vendor ID + 8
> bits of device ID at semi-standard addresses, and even this is not
> bullet proof.

Given they support 16 bit register on the LM75 already, I must admit I
am amazed they didn't do an 8 bit ID and 8 bit revision using a 16bit
register.

-- 
Len Sorensen

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
