From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Fri, 26 May 2006 10:46:18 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <4476DC7A.7080906@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Harald Dunkel wrote:
> 
> I have started working on this (but please don't expect too much).
> One question about the I2C_DRIVERID_* macros in i2c-id.h: Where
> could I get an ID for the f75387 driver?
> 

The datasheet of the F75387 doesn't say anything about Packet
Error Checking, but I am not sure whether this is a feature of
the bus. Is it?

Can something bad happen if I don't support PEC?


Regards

Harri



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060526/5a6e32db/signature.bin
