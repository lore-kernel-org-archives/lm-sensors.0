From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 13 Mar 2009 10:02:07 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <49BA2F1F.5080401@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jason,

We have some problem with c7temp driver in the linux. This was done by Juerg.
The driver can be downloaded from the lm-sensors.org website in devices section.

It seems some version of fam6 model D does not have any temperature register in

>    0xc0000002: eax=0x00000000 ebx=0x08000810 ecx=0x08100f13 edx=0x42040000

Jason, Please can you look to some more recent version of C7 data book, where 
the values for temperature are stored? (normally they are for cpuid EAX = 
0xc0000002 in EAX. Here are zeros.

I dont know what CPU revision it is exactly. I guess we will need to read some 
other MSR to get current version. Juerg do you know this? Its should be MSR 1154h.

All I know that the cpu is also at HP Mini-note 2133.

Thanks,
Rudolf




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
