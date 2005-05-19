From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [PC87366] A bit different design for it's SuperIO.
Message-Id: <1092738781.12729.608.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <1092648290.12729.471.camel@uganda>
In-Reply-To: <1092648290.12729.471.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2004-08-16 at 22:25, Jean Delvare wrote:

> I haven't read the code (yet), just a few random comments on the general
> design:
> 
> 1* The final driver definitely should be placed in a "common" location.
> It isn't i2c- nor w1-specific. It would be in drivers/isa but this one
> doesn't seem to exist... Maybe Greg will have a suggestion when he comes
> back from vacations.
> 
> 2* If such a design is in place as I port the pc87360 driver to Linux
> 2.6, I'll of course use it. Note that this driver supports not only the
> PC87366 but also the PC87360, PC87363, PC87364 and PC87365 (although
> these are less frequently found, it seems) so your driver would have to
> support them all as well.

I do not have neither spec nor hardware for any SuperIO chips other than
PC87366, so I can not say if they will fill itself comfortably in the
new driver, but according to your driver they almost do not have any
differences.
If they are really the same, then all is ok, and I can easily extend
this driver to support different ID's and even registers. But I can not
test it, I have only Soekris board (PC87366 based) provided by
Alexander  Yurchenko (grange@openbsd.org) for a while, Thanks :)

> 3* The Super-I/O mechanics are not PC8736x-specific. It is a standard
> (established by Intel some years ago) used by all Super-I/O chips,
> including those made by National Semiconductor, ITE, Winbond, SMSC and
> VIA. This means that your driver should most likely be completely
> generic, and probably doesn't even need to know of any chip ID. It
> could, OTOH, export an ID test function (although I guess it wouldn't be
> any different from the register read function with register set to
> 0x20).

Probably we need to call the testers, I will extend driver to support
different ID's for now, but only for PC8736*.

Will send files soon.

Thank you.

-- 
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040817/ad14f396/attachment.bin
