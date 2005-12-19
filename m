From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Mon, 19 Dec 2005 10:04:50 +0000
Subject: [lm-sensors] Backport of lm77.c for 2.4.x
Message-Id: <1134986690.4463.20.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <1134463317.4459.36.camel@gimli>
In-Reply-To: <1134463317.4459.36.camel@gimli>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Sat, 2005-12-17 at 18:53 +0100, Jean Delvare wrote:
> > Do you think this is an acceptable compromise?
> No, it's not. [...]

Good point, I'll remove that feature.

> > Well, it seems that the backport is done then. I'll test the driver a
> > bit more locally. If I don't find any further problems/bugs, I'll send
> > it to the list during the next days.
> OK, great.

The only issue that seems to be open now is to get changing the
different values right. Currently the result of a write to the /proc
files isn't exactly what one would expect :)

> As this driver is not part of our packages, there's not much we can do.
> You may try proposing your patch to Marcelo Tosatti for inclusion into
> 2.4 mainline, but changes are he will reject it. He is being very
> conservative now, he even didn't accept my latest documentation updates
> and typo fixes.

Hmm, ok.

> Other than that, all you can do is publish your fix as a patch
> somewhere on the web where people interested in it are likely to find
> it. I have no idea myself where such a place would be.

No problem, I'll offer the changes on my server.

Bye, Mike


