From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Temperatures on Gigabyte GA-8PE667
Message-Id: <Pine.LNX.4.58.0412231851340.18510@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <JA8AAAAAA4jS8QABYQABj6DB09hU@proteusworld.com>
In-Reply-To: <JA8AAAAAA4jS8QABYQABj6DB09hU@proteusworld.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I understand your needs, but we just can't do anything without
> additional data that only Gigabyte could provide - and this is if there
> *is* a way to get the readings. Maybe there isn't at all.

Oh there is way of bios dissassembly I did. It is not easy and sometimes
not possible. I had 2 hours of time so I did it:

First only temp3 is used and it is programmed as diode.

(REG51 & F6) | 8 confirms it

Second there is no formula, just the value is converted to dec. val.

So in chip "it87-*" "it8712-*"
config section ensure that you have:

ignore temp1
ignore temp2
set sensor3 3
and no compute statement for temp3

This will gain same temp as it is in bios.

I hope this will help a bit. Dont forget to CC to the list. If any more
questions. Thanks.

Regards

Rudolf

Reference:
8pe667u.f3    => 8pe667u.bin

seg000:8F0C                 call    inport
Iseg000:8F0F                 and     al, cs:[si+1]
Iseg000:8F13                 or      al, cs:[si+2]
Iseg000:8F17                 call    outport

seg000:92F5 temp3           proc far
Iseg000:92F5                 cmp     al, 0AAh ; '-'
Iseg000:92F7                 jz      locret_0_9303
Iseg000:92F9                 mov     ah, 2Bh ; '+'
Iseg000:92FB                 call    inport
Iseg000:92FE                 xor     ah, ah
Iseg000:9300                 call    temprint
Iseg000:9303
Iseg000:9303 locret_0_9303:                          ; CODE XREF:
Iseg000:9303                 retf
Iseg000:9303 temp3           endp
