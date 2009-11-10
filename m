From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 10 Nov 2009 12:47:44 +0000
Subject: Re: [lm-sensors] [RFC PATCH 09/10] lis3: Scale output values to mg
Message-Id: <20091110124744.GY14091@buzzloop.caiaq.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-10-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

sorry for the late catch-up on this.

On Tue, Nov 03, 2009 at 02:25:18PM +0100, =C9ric Piel wrote:
> >> Yes. That is one thing which need to agreed here. One possibility is to
> >> implement this as a configurable feature for example using platform da=
ta.
> >> In that kind of solution default value must be the old way.
> >=20
> > Yes please :)
> >=20
> Hello,
> Actually we had already briefly discussed this with Samu. And I had
> given my green light because:
>  * I don't know any userspace program which would be affected by this
> change (they only rely on the relative difference). Arguably, I know
> only few programs.

Hmm. Maybe I don't understand the change then. I thought the patch will
alter the _scale_ of the values to something more standard? If that's
the case, also applications that take relative changes will be affected,
right?

>  * Eventually, we should converge to a userspace API compatible with any
> accelerometer device and exposed by all the accelerometer drivers. So
> for now I consider the userspace interface of the lis3 driver quite
> "soft", and any move toward this goal good.
>  * Having platform data to select between old unit/new unit will add
> complexity to the driver, which should be avoided whenever possible.

True, and I'm not against dropping legacy. However, if it affects every
user space application, we cannot simply change it. I happen to be
copied in this thread, so I can react on it, but all other users are
not.

Anyway, mabye I just didn't fully understand the impact :)

Daniel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
