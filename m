From: Michael Riepe <michael.riepe@googlemail.com>
Date: Thu, 18 Jun 2009 21:05:05 +0000
Subject: Re: [lm-sensors] [PATCH] Enable coretemp driver on Intel Atom
Message-Id: <4A3AAC01.7050805@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49E7C34A.60007@googlemail.com> <20090618121326.42ab9c2f.akpm@linux-foundation.org>
In-Reply-To: <20090618121326.42ab9c2f.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org

Hi!

Andrew Morton wrote:

> I'm not 100% sure what to do about this patch.  I'm inclined to merge
> it, even though you think it might be giving the wrong numbers,
> because then someone might fix it.

That was the basic idea :-)

> otoh, if giving the wrong numbers leads to people's machines needlessly
> shutting down or something like that, then that's not so good.

I don't think that that will happen. Core temperatures on my 330 are
lower than those reported by the other sensors (core 0/1: 27/35 =B0C on an
idle system - hardly alarming in my opinion).

--=20
Michael "Tired" Riepe <michael.riepe@googlemail.com>
X-Tired: Each morning I get up I die a little

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
