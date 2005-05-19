From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <3FFB1D60.60309@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>I didn't find fscher on the supported devices web page. I'm you've
>>been just to busy to add it ;-)
> 
> That's because it is considered a new driver, so you'll find it under
> "New Drivers". There's always some delay between the moment support is
> added for a chipset and the moment we declare it "officially supported".
> (Which might be discussed, but that's the way it is for now.)

That's ok. A few seconds after sending the email, I found it myself in that 
section :-)

Now as kernel 2.6.0 is released, I feel the need to port fscher to 2.6.0. I've 
already started today, but didn't have success so far.

The biggest issue in porting is the change from procfs to sysfs. Looking at 
other drivers, I realized, that they define a lot of macros to deduce all the 
necessary callback functions.

Is there a coding convention for these macros?

Attached you'll find what I've done so far. Please send me your comments and 
hints.

Thanks in advance.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscher.c.gz
Type: application/x-gzip
Size: 6630 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040106/89cb6ad5/fscher.c.gz
