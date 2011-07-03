From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 11:59:17 +0000
Subject: Re: [lm-sensors] [PATCH] Don't point the user to the ipmisensors
Message-Id: <20110703135917.35a3bfad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110608151843.357fa29c@endymion.delvare>
In-Reply-To: <20110608151843.357fa29c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 8 Jun 2011 16:29:06 +0200, Aurelien Jarno wrote:
> On Wed, Jun 08, 2011 at 03:18:43PM +0200, Jean Delvare wrote:
> > The development of the ipmisensors driver stalled 5 years ago, the
> > driver isn't usable, so stop pointing the users to it, it only confuses
> > them. See https://bugzilla.novell.com/show_bug.cgi?idU8756 for
> > example.
> 
> I think I never tried this driver, but I trust you on this analysis.
> 
> > ---
> > I have this patch in openSUSE for 1.5 year, any objection to me
> > getting it upstream for everyone's benefit?
> 
> Given the above, I think it's a good idea.

Applied.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
