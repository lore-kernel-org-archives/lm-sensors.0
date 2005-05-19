From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: ---=== Lm_sensors Support DB Entry #1692 ===---
Message-Id: <200406090749.i597naQJ085544@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040609062212.GC448@skilta.cc.tut.fi>
In-Reply-To: <20040609062212.GC448@skilta.cc.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Timo,

>I hadn't noticed the instructions below the tables at new drivers page.
>
>I added to my modules.conf:
>options lm90 force_lm90=0,0x4c
>
>After that everything worked fine.
>
>lm90-i2c-0-4c
>Adapter: SMBus I801 adapter at 0c00
>M/B Temp:    +38 C  (low  =    +0 C, high =  +105 C)
>CPU Temp:  +50.4 C  (low  =  +0.0 C, high = +55.0 C)
>M/B Crit:   +105 C  (hyst =   +95 C)
>CPU Crit:   +105 C  (hyst =   +95 C)

Just one question: on which system did you find an LM86? We've never
heard of it being used in any PC hardware so far.

I'll add support for the LM86 to the 2.4 and 2.6 lm90 kernel drivers as
well as libsensors and sensors. This should be quite straightforward,
since the LM86 only differs from the LM90 by its increased accuracy (1
degree instead of 3) on remote temperature channel, as far as I can see.
I Don't have the datasheets here, so I'll verify this evening. Will
you please test my changes before I commit them?

Kiitos :)

Jean Delvare
