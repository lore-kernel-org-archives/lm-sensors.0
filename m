From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Fri, 09 Dec 2005 06:06:21 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051209060620.GA9957@dnil.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Dec 08, 2005 at 10:22:40PM +0100, Jean Delvare wrote:
> 
> > The picture attached is a very simple drawing showing the south bridge in one
> > box and the w83792d in another box. There is one arrow from the south 
> > bridge to
> > the w83792d labelled "SMI bus" and the there is one arrow from the w83792d to
> > the south bridge labelled interrupt.
> > 
> > Does this provide any more insight? Could this be more of an issue with the
> > interrupt coming into the south bridge causing a hang since no code is
> > servicing that interrupt? I don't know the kernel that well to guess any
> > further though...
> 
> I don't know much either, but the schematics would need to mention pin
> numbers or names so that we know *which* GPIOs of the i801 are
> involved. Is that the case? Without that information, it probably
> doesn't help us much.

The simple drawings didn't have either pin names or numbers so I wrote
back to GBT support asking for this additional piece of information.

Now, assuming that we have this piece of information, how would we use
it? I guess we could disable that GPIO somehow, but that fix is very
specific to this motherboard... Isn't it likely that other motherboard
would need some similar patch to prevent this kind of issue?

I guess what I'm wondering is, is it hard to support the SMI
functionality and would that be a more generic solution that would
make the kernel survive the SMI? Or is the issue rather with a GPIO
setup as an interrupt triggering an interrupt for which there is no
handler installed?

Regards
Daniel Nilsson

