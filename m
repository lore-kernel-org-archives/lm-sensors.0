From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40143666.8000205@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Now as kernel 2.6.0 is released, I feel the need to port fscher to
>>2.6.0. I've already started today, but didn't have success so far.

[snip]

> I'd suggest you first read Documentation/i2c/porting-clients as found in
> Linux 2.6.1-rc1 and later. That's a document I wrote about porting chip
> drivers from linux 2.4 to linux 2.6. I believe that almost all questions
> you'd ask are answered there. If you don't mind, I'll take a look at
> your code after you read that document and applied its contents to
> your driver.

Attached you'll find the 2.6.x module and configuration.

Is there a guide for writing chip documentation, as I don't know what to do 
with "Chip Features" in doc/chips/fscher?

Is there a guide, how to port the sensors program?

Without changes, sensors just gives me the following:

fscher-i2c-0-73
Adapter: SMBus I801 adapter at 2000
+12V:           +11.86 V
+5V:             +5.05 V
Battery:         +3.05 V

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscher.c.gz
Type: application/x-gzip
Size: 4890 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040125/8f15d791/fscher.c.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf.eg.patch.gz
Type: application/x-gzip
Size: 493 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040125/8f15d791/sensors.conf.eg.patch.gz
