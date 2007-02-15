From: alanc@pipstechnology.co.uk (Alan Clucas)
Date: Thu, 15 Feb 2007 11:01:17 +0000
Subject: [lm-sensors] DS75
Message-Id: <45D43D7D.4050402@pipstechnology.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <45BDE148.7020108@pipstechnology.co.uk>
In-Reply-To: <45BDE148.7020108@pipstechnology.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>> OK. Attached is a patch against sensors-detect from our SVN repository.
>>> Please give it a try, it should detect your DS75. Compared to the LM75
>>> detection, I removed the cycle-over-8 test as your kernel patch did,
>>> and additionally I'm checking that registers 0x08 to 0x0f behave the
>>> same as 0x04 to 0x07 (which isn't true of the LM75.) If it works OK for
>>> you, we can use the same approach in the lm75 kernel driver. Please
>>> report.
>> (...)
>> Your sensors detect patch works fine:
> 
> OK, patch applied to lm-sensors SVN.
> 
> I'm still waiting for updated kernel and libsensors/sensors patches.

It is on my todo list still - been side tracked by some other things so 
don't expect it until next week. Sorry.

I'm not going to try for >9 bit precision. An interesting side effect of 
running i2cdump is to change it from 9 bit precision (which it shows it 
is setup for the first time it is run after a reset) to the dump that 
you saw in my earlier mail. Odd. (Which is why the kernel patch I posted 
earlier did work for me).

Alan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: alanc.vcf
Type: text/x-vcard
Size: 562 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070215/49f271af/attachment.vcf 
