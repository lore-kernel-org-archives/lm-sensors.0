From: brandonh@tyan.com (Brandon Hammersley)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Tyan S4882 support complete
Message-Id: <003101c4cc11$40d1d420$a0a8a8c0@HammerMobile>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041115231910.2bd44311.khali@linux-fr.org>
In-Reply-To: <20041115231910.2bd44311.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tyan is willing to provide either S2850 or S2875 to support the LM-Sensors
project development and show our appreciation quick response to our requests
for custom drivers.
Let us know the final decision.

Best Regards,
Brandon Hammersley
Project Manager/Applications Engineer
Tyan Computer Corporation
+1 (510) 651-8868 X5117

-----Original Message-----
From: Maurice Hilarius [mailto:maurice@harddata.com] 
Sent: Tuesday, November 16, 2004 10:04 AM
To: Jean Delvare
Cc: Alex Buckingham; Mark Lane; LM Sensors; Brandon Hammersley
Subject: RE: Tyan S4882 support complete

With regards to your message at 04:31 AM 11/16/04, Jean Delvare. Where
you 
stated:

>Quoting Brandon Hammersley:
> > The S2850 is definitely possible. However, it may not work for what
Jean
> > needs to do. The S2850 is AMI BIOS & the S4882 is Phoenix based.
There may
> > be differences in the location of the DMI data. I need to check the
SMBIOS
> > spec to verify this.
>
>As long as dmidecode [1] finds the DMI table, the board should be
>suitable for the immediate job of adding DMI support to linux-x86_64
>2.6. The exact location of the DMI table can change according to the
>SMBIOS specs and both dmidecode and linux-i386 are fine with that, and
>whatever I do for x86_64 will handle it as well.
OK. I think that the 2850 supports this.. Right It is also valuable that
we 
may pursue compatibility with different BIOS and board types.

>Quoting Maurice Hilarius:
> > OK, well, other ideas are welcomed..
> > Let me know..
>
>I may add that the S2875S (or S2875 with a single CPU, for that matter)
>would probably be a more viable solution for me. The S2850 is strongly
>server-oriented with a weak GFX chip on-board and no AGP slot.

The 2850 is an ideal ( should I say the ONLY REMAINING socket940 board.
As you say, no AGP, perfect for clusters, single processor servers, etc.
If we wanted to look at workstation application, the 2875 is a lousy 
candidate. Expensive, history of bugginess, and with Socket939 now out, 
totally superfluous.
The S2850, with ECC memory checking is a board that has much wider
appeal.


>I could
>only use it as a test system. On the other hand, I could use an
S2875(S)
>as my main workstation by simply adding a decent AGP graphics card to
>it. This would ensure a much better testing in the long-run.
Right, but basically a platform of short future life span.

If we wanted to go the route of a WorkStation with AGP, we would be
smarter 
to go to some of the newer Socket939 offerings. In that space, however,
it 
is mainly dominated by VIA chipsets, and some of the nVidia variants.

Also, AMD is making rumblings about discontinuing the 14x line of single

socket 940 CPUs..

>Don't get me wrong though. The primary goal is obviously to setup a
test
>machine and an S2850-based would do IMHO. The possibility for me to use
>it on a regular basis would be valuable but isn't a requirement.


Understood. While I understand your desire for AGP, the other factors
lead 
me to belive the 2850 is a much more suitable Socket940 platform.
Remember the main reason we still see Socket940 in single CPU machines
is 
servers, and specifically the requirement for ECC memory functions.

If we want to got the AGP workstation route we should be looking to
other 
boards, probably from other vendors, like ASUS, MSI, etc.



With our best regards,

Maurice W. Hilarius       Telephone: 01-780-456-9771
Hard Data Ltd.               FAX:       01-780-456-9772
11060 - 166 Avenue        mailto:maurice@harddata.com
Edmonton, AB, Canada      http://www.harddata.com/
    T5X 1Y3



