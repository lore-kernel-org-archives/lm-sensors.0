From: i-c-q@chaos2.dtdns.net (Tom)
Date: Mon, 06 Mar 2006 22:07:41 +0000
Subject: [lm-sensors] Implementation of FSCSCY?
Message-Id: <440CB2AD.803@chaos2.dtdns.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F75216.9040309@hiereinwerfen.de>
In-Reply-To: <43F75216.9040309@hiereinwerfen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

> Your mail hit the list just few days before my final exams so I had no time to reply.

Thank you for your time, I hope your exams were successful?

>> I've got a FSC Dual-Mainboard (D1306) on which I'm trying to setup a
>> server-system based on the actual Ubuntu ("Breezy Badger"). So the
>> kernel must be a 2.6.
> 
> Is this a serverworks chipset?

Yes. The "data sheet" reads "Serverworks HE-SL"

>> The board contains a "Scylla"-chip, which is found by sensors-detect. As
>> far as I found within the docs, this must be ok, because the developer
>> of the required module "fscscy" notes, the driver is "beta" but
>> well-tested on exactly THIS board.
>> Where can I get it and why is it missing?
> 
> Nobody ever port it it seems. You can do it yourself with our help, pay/donate
> something to handle it for you.

Since I'd like to learn how to help myself, I'll try to do all
necessary. If this fails, I'm willing to donate, too. Well, maybe I
should do so anyway...

> Please write back what chipset it is
> (or lspci)

> lspci
0000:00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
0000:00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
0000:00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro
100] (rev 09)
0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller
(rev 04)
0000:01:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010
66MHz  Ultra3 SCSI Adapter (rev 01)

Thanks!

cu/2
Tom

