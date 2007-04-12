From: Mark Brown <broonie@sirena.org.uk>
Date: Thu, 12 Apr 2007 12:45:43 +0000
Subject: Re: [lm-sensors] w83627hf hardware sharing
Message-Id: <20070412124543.GB3132@sirena.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070412121527.GA3132@sirena.org.uk>
In-Reply-To: <20070412121527.GA3132@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Apr 12, 2007 at 01:26:55PM +0100, P=E1draig Brady wrote:
> Mark Brown wrote:

[ Currently we have multiplexing problems with multiple drivers trying
  to control SuperIO devices. ]

> > The most straightforward fix appears to be to provide a multiplexing
> > driver for the chip.  Does this sound like a reasonable approach to

> You're right.
> Some work has been done wrt this, but I've not tried it:
> http://marc.info/?l=3Dlinux-kernel&m=115821759424601&w=3D2

Adding Jim Cromie who wrote the SuperIO multiplexer referenced there -
what is the current status of that work?  It looks like exactly what I
was after.

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
