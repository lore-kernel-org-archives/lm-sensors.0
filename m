From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Linux SMBus support
Message-Id: <3C1FD650.37F77B29@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFF2EB205B84D011ADB200805FFE6E010BE14EAD@txexmta2.amd.com>
In-Reply-To: <AFF2EB205B84D011ADB200805FFE6E010BE14EAD@txexmta2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

1) we had a query recently which caused me to think about it a little.
   We need to add support for ARP and PEC. ARP would probably be
   a separate module providing support to all SMBus 2.0 adapters.
   PEC would have to be added in the appropriate places in i2c-core.
   So I don't think either would touch the adapter drivers too much.
   Until an SMBus 2.0 sensor chip appears we won't make much progress.
   Any idea when one will appear on a motherboard or PCI board?

2) Somebody sends a patch to the LKML. I'd say 2-4 times a year.


leo.duran@amd.com wrote:
> 
> Hello,
> 
> I have a few questions to which I'd appreciate some answers.
> I am a system software developer at AMD, looking to support future
> chipsets (south bridges) with SMBus functionality.
> 
> 1) Are there any plans for supporting SMBus v2.0 features such as ARP?
> If so, Would that be done in an "adapter driver", or a separate "generic"
> driver (assuming functionality is avaliable from "adapter" device).?
> 
> 2) How those the code in your repository makes its way into future
> Linux ditributions?  Hwo often dows this happen?
> 
> Thanks,
> Leo.
> leo.duran@amd.com
