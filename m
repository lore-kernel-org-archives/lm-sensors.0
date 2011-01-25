From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 25 Jan 2011 16:22:30 +0000
Subject: Re: [lm-sensors] [PATCH] lis33: turn down the no IRQ message
Message-Id: <20110125162230.GB8024@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110125150910.18731.92369.stgit@bob.linux.org.uk>
In-Reply-To: <20110125150910.18731.92369.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 25, 2011 at 11:19:20AM -0500, Alan Cox wrote:
> > > Basically though if dev->irq is not set it means there is no IRQ, and
> > > that isn't neccessarily an error.
> > > 
> > Difference is developer knowledge (no irq) vs. user understanding. Sure, no irq 
> > implies no freefall, and that is not an error. However, the user won't know that,
> > and thus might appreciate a note.
> 
> Unfortunately what happens is the user of the case it's not an error gets
> a big scary message and panics thinking the device is broken.
> 
Hmm ... ok, I'll accept that, and redirect any resulting support cases to you ;).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
