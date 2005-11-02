From: roger@planbit.co.uk (Roger Lucas)
Date: Wed, 02 Nov 2005 10:51:54 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051102095120.22EEB12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I have done some digging on my motherboard (a Via Epia 5000).

http://www.viaembedded.com/product/epia_mini_itx_spec.jsp?motherboardId!

The processor is a Via EDEN ESP 5000.  This has a 533 MHz clock and 1.2v
supply.  You can find the datasheet for the chip on the link below (see
section 1.3 on page 7 for the speed/voltage model information).

http://www.viaembedded.com/product/6/14/Eden20v115.pdf

Fortunately, I am running Debian, so the "apt-get install cupid" worked
smoothly and returned the results below.  I have absolutely no idea what
they mean :-)

edensnake:~# cpuid
 eax in    eax      ebx      ecx      edx
00000000 00000001 746e6543 736c7561 48727561
00000001 00000673 00000000 00000000 00803135
80000000 80000006 00000000 00000000 00000000
80000001 00000673 00000000 00000000 80803135
80000002 20414956 756d6153 32206c65 00000000
80000003 00000000 00000000 00000000 00000000
80000004 00000000 00000000 00000000 00000000
80000005 00000000 08800880 40040120 40040120
80000006 00000000 00000000 40040120 00000000

Vendor ID: "CentaurHauls"; CPUID level 1

Unknown vendor
edensnake:~#

Thanks for you help, and let me know if you need anything else.

- Roger


-----Original Message-----
From: Rudolf Marek [mailto:r.marek@sh.cvut.cz] 
Sent: 02 November 2005 09:25
To: Roger Lucas
Cc: 'LM Sensors'
Subject: Re: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE
2.6

> Can you confirm that this cpu has that strange 4bit VID?

Hmm if you know it has 1.2V so my table is not correct.
PLease can you give me output of CPUID utillity?

(if you have debian just apt-get install cpuid)

I need family/model/stepping

Regards
Rudolf

