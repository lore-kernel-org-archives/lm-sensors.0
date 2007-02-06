From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Feb 2007 14:45:39 +0000
Subject: [lm-sensors] DS75
Message-Id: <20070206154539.93aa1dc5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alan,

On Tue, 06 Feb 2007 10:19:21 +0000, Alan Clucas wrote:
> > Wow. I have to admit it's not exactly what I expected. The fact that
> > some (seemingly random) unused addresses work while others return an
> > error instead is rather puzzling. At least this gives us several ways
> > to detect the DS75.
> 
> I did run it several times and reboot just to check - those "random" 
> addresses are fixed and always the same.

OK, thanks for checking this, I was wondering. I'm also curious to know
whether other DS75 chips behave exactly the same or if it's
chip-specific.

> We could also check for the 0x00-0x0f mirror at 0x40-0x4f if we want to 
> be more sure.

Correct, but we also want to find the best reliability/speed tradeoff. I
expect my code will to be reliable enough so I'd rather avoid slowing
down detection unless this is really needed.

> Your sensors detect patch works fine:
> 
> Next adapter: CS5535 ACB0 (i2c-0)
> Do you want to scan it? (YES/no/selectively): yes
> Client found at address 0x48
> Probing for `National Semiconductor LM75'...                No
> Probing for `Dallas Semiconductor DS75'...                  Success!
>      (confidence 6, driver `lm75')
> Probing for `National Semiconductor LM77'...                No
> Probing for `Dallas Semiconductor DS1621'...                No
> Probing for `Maxim MAX6650/MAX6651'...                      No
> Probing for `National Semiconductor LM92'...                No
> Probing for `National Semiconductor LM76'...                No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

OK, great, thanks for testing. I'll apply the patch to SVN soon.

> I'm happy to do the kernel patch for this. Do we want it to continue to 
> return kind=lm75 as well as name="lm75"; I'm not sure of all the 
> implications of kind.

For now libsensors needs to know about all names, otherwise it doesn't
recognizes the chip features. If we decide to have a separate prefix
for the DS75, this means we must update libsensors as well (that's a
trivial change but it must be done.) Both approaches make sense, so
it's really up to you, whether you prefer a nice separate prefix or
compatibility with older versions of libsensors. Note that if you ever
want to take benefit of the additional resolution bits of the DS75,
having a separate prefix will be useful.

I'm waiting for your patch, if you're quick enough it can make it into
kernel 2.6.21.

Thanks,
-- 
Jean Delvare

