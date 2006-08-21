From: RaphaelD@tyan.com (Raphael Deng)
Date: Mon, 21 Aug 2006 17:24:32 +0000
Subject: [lm-sensors] =?utf-8?b?562U5aSNOiAgVHlhbiBTMjcyMCBSZXZzaW9uIDIu?=
Message-Id: <3174569B9743D511922F00A0C943142310DBD8AD@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf

Which CPU he use? FSB400 or FSB533? If using FSB400, the CPU temp cannot be
got from hardware monitor chip. You must use sensor in Intel Xeon CPU
itself.

Best Regards
Raphael Deng

-----????-----
???: Rudolf Marek [mailto:r.marek at sh.cvut.cz] 
????: 2006?8?19? 3:40
???: Marcus Sobchak
??: LM Sensors; Raphael Deng
??: Re: [lm-sensors] Tyan S2720 Revsion 2.01 again

Hello all,

Raphael have you please idea why he has still -1 temp? Tyan sensors.conf
suggest
to upgrade the bios, but it did not help in his case.

Please can you help?

Regards
Rudolf

> adm1021-i2c-0-19
> Adapter: SMBus I801 adapter at 0540
> CPU 2 temp:
>               -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)
> 
> adm1021-i2c-0-18
> Adapter: SMBus I801 adapter at 0540
> CPU 1 temp:
>               -1?C  (low  =    -1?C, high =    -1?C)  ALARM (N/A,LOW)
> 

