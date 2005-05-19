From: rentnerschreck@ecraft.org (Marius =?ISO-8859-1?Q?Dr=E4ger?=)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: 1283 ticket datasheet
Message-Id: <1055798868.13976.2.camel@rentnerschreck.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W86L785TS-S.pdf

some flaws i and somebody found out 
..
Don't worry about the different partnumber in the link, they made a
mistake in the document name. You'll see the correct partnumber in the
document itself. There are other mistakes too: 
Page 8 says "The 8-bit temperature data can be obtained by reading the
register." without telling you which one (it's CR27). 
In the tables on page 10,13 and 20 the values for R1 are wrong in the
row 85?C/30?C (should be 9.1K instead of 91K) and in the row 85?C/32?C
(should be 6.8K instead of 68K). Of course now that I understand the
purpose of those resistors I realize that they don't matter for a device
driver. 
Most important is the mistake on page 10 where the sentence reads: "When
monitoring CPUT1 (Pin 2) temperature exceeds temperature fault limit
(ex: 90 o C) in CR26, or CR27, pin6 TEMP_FAULT# will be asserted.". This
should really read: "When monitoring CPUT1 (Pin 2) temperature in CR27
exceeds the temperature fault limit in CR26 (ex: 90?C) pin6 TEMP_FAULT#
will be asserted.". 
On page 13 the document declares CR26 to be reserved, but I checked on
my board and it does indeed contain the temperature fault limit value. 

Another thing to note is that the 7-bit i?c address is 0101110. Normally
the lowest bit indicates reading from or writing to the chip. This would
make 0x5C the read and 0x5D the write address. However the chip is
clearly accessible at the address 0x2E on the A7N8X (same 7-bit address
just shifted to the right).
hope i can help
-- 
Marius Dr?ger <rentnerschreck@ecraft.org>
