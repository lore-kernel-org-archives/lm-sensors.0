From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 10 Nov 2009 13:31:15 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <20091110133115.GA14091@buzzloop.caiaq.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Nov 10, 2009 at 02:23:20PM +0100, =C9ric Piel wrote:
> Op 10-11-09 13:47, Daniel Mack schreef:
> > True, and I'm not against dropping legacy. However, if it affects every
> > user space application, we cannot simply change it. I happen to be
> > copied in this thread, so I can react on it, but all other users are
> > not.
> Yes in general I completely agree with you: if we define some interface
> that userspace is supposed to use, "we shall never change it". However,
> in this specific case I'm willing to accept the possibility of breakage.
> Because in the little chance that a program depends on this specific
> metric it is making too much assumption on the hardware anyway: so far,
> depending on the type of sensor (8b/12b, hdaps...) the values could be
> very different.

Does the change to the min/max parameters to input_set_abs_params()
also reflect the factor in which the multiplication factor alters?

In other words: If I scale the read value to the full range reported by
the input device - will I still get the same value before and after the
change? If that's the case, I guess the 'breakage' would be acceptable.

Daniel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
