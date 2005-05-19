From: aurelien@aurel32.net (=?ISO-8859-15?Q?Aur=E9lien_Jarno?=)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: Broken DS1621 detection / ds1621 module / A7V8X
Message-Id: <41EE8A89.9060300@aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501040208.12906.p.henning@fh-karlsruhe.de>
In-Reply-To: <200501040208.12906.p.henning@fh-karlsruhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Prof. Dr. Peter A. Henning wrote:
> Hi there,
> 
> Am Freitag, 7. Januar 2005 21:14 schrieb Aurelien Jarno:
> 
>>>111111111111111111111111111111111111111111111111111111111
>>>Detection of the DS1621 in sensors-detect is broken. According to the
>>>data sheet of the DS1621, one bit of the configuration register is always
>>>1 and another always 0. This is simply not true, if the chip is not
>>>properly initialized. I suggest the following replacement for sub
>>>ds1621_detect in sensors-detect
>>
>>That sounds me strange. I am using a ds1621 plugged onto my parallel
>>port I2C interface and the module is always loaded at boot. I am using
>>this for more than 4 years (the chip is dated 0022, ie year 2000 week
>>22).
> 
> 
> Well, may be strange - but that's fact. The data sheet does not have a single 
> line indicating that the two "fixed" bits may be overwritten - and yet, 
> something does this.

Ok, I have done some tests on my ds1621 chip, and I can't write to bits 
3 and 2, there are always respectively 1 and 0.

However, I have seen that Dallas has released a new datasheet for the 
DS1621 which now presents the two bits as 'X', and marks them as 
'reserved'. I suspect they have done some changes in there design, 
that's why you are having some problems.

I have looked to the datasheet to find a way to detect the DS1621 chip. 
Here is my proposal:

1) Verify that the 7 lowest bits of the TL register are 0. This is 
basically what you proposed. It is specified in the datasheet that's 
these bit are always 0, and I doubt it will change in the future 
(because in that case a lot of existing design won't work anymore).

2) Verify that bit 4 of the config register is 0. It means that the chip 
is not currently writing to its EEPROM, or that no EEPROM write has been 
requested in the last 10ms. I think we could safely say that it is 
always the case with the kernel driver.

3) Issue a "stop conversion T" (= sending 0x22 to the chip), and verify 
that the bit 7 of the config register is set to 1 (no conversion in 
progress).

Any comment on using such a detection? If everybody agrees, I'll send a 
patch for both the 2.4 and 2.6 modules.

Bye,
Aurelien

-- 
   .''`.  Aurelien Jarno               GPG: 1024D/F1BCDB73
  : :' :  Debian GNU/Linux developer | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
