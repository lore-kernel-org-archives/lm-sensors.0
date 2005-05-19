From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <1078135086.4043092eee0b9@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Charles Galpin <charles@defenderhosting.com>:

> I was trying not to bother everyone before emailing again. I have  
> requested more info from the vendor who has a close relationship
> with MSI and *should* be able to provide the info.

Great :)

> I did get to look at the hardware last night though. It turns out
> the motherboard is a MS-9145 - which I cannot find any info on.

Neither could I. OTOH, I could find more on a MS-9245, which is what I
think you have. See here:

http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UIDQ0&kind=3

This damn seems to match the output of "lspci" on your system, doesn't
it?

> The only winbond chip I see is a W986432DH-6 which is SDRAM.

Obviously unrelated with our problem.

> I'm honestly not exactly sure what I'm looking for so I wrote down
> the info for any chips i could see. I did find info on one marked
> 'ADM1027 51'.

Aha. That would be it :)

Good news: we do support the ADM1027 (lm85 driver).

> Which looks right on the money. Not sure it jives with your PC87366
> identification though?

Since the hardware monitoring part of the PC87366 (if that's what it is)
is disabled, this makes full sense that another hardware monitoring
chip is present and used.

> I'll let you know what I get from the vendor. Thanks again for  
> continuing to look into this!

OK.

One thing I'd like to add here is that on the above-mentioned MS-9245
page, there is a Windows "AMD 8111 SMBus Driver". So there *must* be a
way to activate it under Linux too. Most likely, the ADM1027 chipset is
connected to it. I believe that the only difficulty left is to enable
the 8111 smbus. Once we know how to do it, we already have all the
necessary drivers to driver your motherboard's monitoring system (if
I'm not mistaking).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
