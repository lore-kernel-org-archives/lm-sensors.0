From: garman@raw-sewage.net (Matt Garman)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket 1564 (Can't access /proc file for writing);
Message-Id: <20040206053931.GA15729@raw-sewage.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040205141827.GA3115@raw-sewage.net>
In-Reply-To: <20040205141827.GA3115@raw-sewage.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 05, 2004 at 07:14:13PM +0100, Jean Delvare wrote:
> Could you compile a kernel by yourself (vanilla sources + i2c patch
> from http://delvare.nerim.net/i2c/) and see if the problem disappears?
> I suspect that the Gentoo kernel includes additional security checks
> in the kernel code, which would explain why the error only shows
> there.

Yup, it was as you suspected.  I built a kernel as suggested above, and
ran sensors -s without any error.  After doing that, the values reported
by sensors were consistent with the BIOS readings.

> If a non-gentoo kernel on the same system make "sensors -s" work, I'll
> start checking which patch Gentoo does include that could reveal the
> problem. Maybe it'll give us an idea of where to look at.

You might want to look at what patches both Gentoo and Debian use (since
you said that both distros tend to have this problem).  That might help
you narrow down the search a little bit.

For what it's worth, I was having the problem with the gentoo kernel
version "2.4.22-gentoo-r5".  (Gentoo has several kernels available.)  I
have another system running "2.4.20-gentoo-r7" that does NOT have this
problem (although it is a different motherboard, and uses a different
sensor chip).

> Thanks for your assistance, sorry that I can't help you much at the
> moment.

No problem!  Please let me know if I can be of any more assistance or do
anything else to help.

Thank you!
Matt

-- 
Matt Garman
email at: http://raw-sewage.net/index.php?file=email
