From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <1081870379.407c082b103fe@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > You can use the kernel function swab16() instead of your own
> > swap_bytes function. I'm going to fix the othe drivers in the
> > same way.

I see you used __swab16. I think you can (and should) use swab16
instead.

> Reading "manufacturer" register from MAX663x here shows "0x0014".
> I don't know if this value may change.

I think it shows either the same value as register 0x05 does, or the
value of the latest register that was read. It probably doesn't have a
value per se (since there is in fact no register).

That's something that can be used for detection purposes too (once you
will have confirmed which of the two behaviors it has) although I admit
it's kind of tricky.

> > (LM76, LM92, MAX6633, MAX6634 and MAX6635) have different address
> > ranges. That's something you can use to distinguish between the
> > four of
> 
> It doesn't help very much - all of them may have 0x48 address for
> example. But it is something...

I know that the addresses overlap, it's a hint at best.

That said, we don't really care which chip it really is, since they are
mostly compatible. It's more a convenience for the user (so that he
knows which chip he/she has).

Maybe we can also use the missing registers of the MAX6634 and MAX6633
(same as the missing manufacturer id register) to refine the
detection.

BTW, which chips do you have exactly?

> I can just copy max663x detection path into lm92.c and turn it on
> when manufacturer id doesn't correspond needed one for lm92.

Yes, that's what I mean. The condition to be detected as a supported
chip would be to either have the lm92 manufacturer's ID, or pass the
tests we have defined. BTW we can make similar tests on the lm92 to
prevent misdetection.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
