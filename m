From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: adm1024
Message-Id: <3D446B75.1E7FE233@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
In-Reply-To: <002a01c23476$84783190$0201d00a@hq.pc3.xstreamis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

so do you recommend that we add 1027 support to adm1024 or lm87, or make
a new driver?


> Roger Orchard wrote:
> 
> we have a card with an adm1027 (this is one of the first R&D broads,
> with the chip on)
> 
> the adm1024 driver thinks that the adm1027 is the adm1024.
> 
> talking to "Analog Devices" they say that you should check:-
> 
> I believe that you can look at the Revision Reg 0x3F
> 
> If it has a value of 0x10 - 0x1F, then it is a 1024
> If it has a value of 0x60 - 0x6F, then it is a 1027
> 
> Also, as further verification, there are registers in the 1024 that do
> not exist in the 1027 and visa versa.
> 
> we have also been looking at the LM87 witch is almost the same chip
> but from "National Semiconductor"
> 
> ------------------------------------------------------------------
> Roger
> Tut System (UK) Ltd
> +44 1865 78 45 60
