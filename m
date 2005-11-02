From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 02 Nov 2005 12:17:04 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <4368A02C.80903@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Roger Lucas wrote:
> Hi Rudolf,
> 
> I have done some digging on my motherboard (a Via Epia 5000).
> 
> http://www.viaembedded.com/product/epia_mini_itx_spec.jsp?motherboardId!
> 
> The processor is a Via EDEN ESP 5000.  This has a 533 MHz clock and 1.2v
> supply.  You can find the datasheet for the chip on the link below (see
> section 1.3 on page 7 for the speed/voltage model information).
> 
> http://www.viaembedded.com/product/6/14/Eden20v115.pdf

Yes I have read that yesterday.

> Fortunately, I am running Debian, so the "apt-get install cupid" worked
> smoothly and returned the results below.  I have absolutely no idea what
> they mean :-)
> 
> edensnake:~# cpuid
>  eax in    eax      ebx      ecx      edx
> 00000000 00000001 746e6543 736c7561 48727561
> 00000001 00000673 00000000 00000000 00803135

Family is 6 model 7 stepping 3


0       6       7       0+   something special EDEN ESP samuel 2

This could be also this processor which seems to follow VRM 8.4 instead of VRM8.5. Dig around the datsheets I have and it seems some contradict
the other. I think correct would be VRM 8.5 for this case.

Regards
Rudolf
