From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Fri, 19 May 2006 16:24:55 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <446DF157.80805@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Harald,
> 
> 
>> Creating a driver on my own sounds pretty cool. Probably it is
>> allowed to use an existing driver as a template?
> 
> Not allowed. Required ;)
> 
> I didn't look at the datasheet for your chip yet (no time for this
> sorry) so I can't tell you exactly which driver to start from. But this
> should be an i2c-only driver (no platform driver, and no i2c-isa
> trick.) Maybe lm90 will do, as it's both simple and up-to-date with
> regards to recent changes. And you can always peek at other drivers for
> the features your chip has and lm90 doesn't.
> 

I have started working on this (but please don't expect too much).
One question about the I2C_DRIVERID_* macros in i2c-id.h: Where
could I get an ID for the f75387 driver?


Regards

Harri

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060519/00085aa4/signature.bin
