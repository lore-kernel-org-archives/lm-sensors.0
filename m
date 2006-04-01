From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Sat, 01 Apr 2006 05:44:52 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <442E1354.8010108@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> 
> You'll have to search the available technical documentation for your
> system and/or ask Aopen for information. There's nothing we can do as
> long as we don't know what chip we are dealing with.
> 
:
> 
> I was about to say "No idea about this one", as it has very few
> registers and no noticeable patterns, but that "19 34" at 0x5d reminds
> me of the Fintek signature in my F71805F Super-I/O chip. Can you please
> search your motherboard for a Fintek chip, presumably small?
> 

I found a small chip close to the socket for an additional fan.
16 pins. AFAICS it says F75387SG, but it was very hard to read
even with a looking glass. Esp. the "S" looks suspicious.

Using "fintek F75387SG" I found this on Google:

http://www.fintek.com.tw/files/productfiles/F75387_025P%20datasheet.pdf

BTW, my PC is an Aopen MZ915-M .


Hope this helps. Regards

Harri


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 254 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060401/41d5029f/signature.bin
