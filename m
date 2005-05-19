From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40158E50.9080406@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>The problem is, that the voltage values still need to get devided by
>>10.
>>
>>Shall I scale the values by 1000 for kernel 2.6.1 and by 100 for
>>kernel 2.4.22 and remove the factor 1000 from sensors.conf?
> 
> Yes, that's the idea.

Well, looking at the conversion formula again, this idea is not 100 % perfect, 
because it doesn't care to scale the offset value. Currently, the offset is 0 
but there is no guarantee, that it will always be 0.

What do you think about some further RW files

	in_refvoltage	= 0x21
	in_offset0	= 0x00
	in_offset1	= 0x00
	in_offset2	= 0x00
	in_multiplier0	= 0x31
	in_multiplier1	= 0x14
	in_multiplier2	= 0x0a

that initally have the values of the first driver release, which were taken 
from dmidecode. The driver would then use those values and supply scaled 
values for in0, in1 and in2.

BTW: was the multiplier for temperatures changed from 100 to 1000 around 
2.6.0-test5, because gkrellm-2.1.25 uses 100 instead of 1000?

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
