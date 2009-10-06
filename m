From: "Cestonaro, Thilo" <thilo.cestonaro@ts.fujitsu.com>
Date: Tue, 06 Oct 2009 07:17:11 +0000
Subject: Re: [lm-sensors] PATCH: add sections for the new FTS chips
Message-Id: <1C27BF3FB8EE3A4D8F901C22ADE1DE07D779923A1D@ABGEX72E.FSC.NET>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
In-Reply-To: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>Hi Thilo,
Hey Andre,

>What about the D215x-S from your last email? I can't find it in the
>list below. Should we remove this one?
Yeah, you can remove this one, these system have the Heimdall Chip. So it was by accident anyway :(, and the config just changes
something for hades and syleus.

>Can we group similar systems? I'd propose D2312, that would make the
>webpage more readable.

The DXXXX part is one system and the AX are different Variants of it. So can't totally forget the AX stuff as it might exist
a system D2312 A1 which has the Hades Chip and another D2312 B1 which has none SM-Chip onboard.
But you can group it like this:

Hades:
D2312 (A1, A2, C1, C2)
D2314 (A1, A2)
D2317 (A1, A2)
D2344 (A1, A2)
D2348 (A1, A2)
D2364 (A1, A2)
D2438 (A1, A2)
D2584 (A1, A5)
D2587 (A1)
D2598 (A1)
D2608 (A1, K1)
D2679 (A1)

Syleus:
D2618 (A1, B1, C1)
D2628 (A1, B1, C1)
D2778 (A1, B1, C1, X1, Y1)
D2812 (A1, A2)
D2817 (A1)
D2828 (A1, A2)
D2831 (S1)
D2836 (S1)


Or:
D23XX -> and at the page it links to, a concrete list which systems are meant.

What do you think?

@Jean:
> These system names are soooo sexy :p
Yeah, lovely isn't it!!! :P ;)

Ciao Thilo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
