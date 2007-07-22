From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 20:58:56 +0000
Subject: Re: [lm-sensors] [PATCh 4/4] Speed up sensors_get_ignored()
Message-Id: <20070722225856.03cff25b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070722165337.20c91514@hyperion.delvare>
In-Reply-To: <20070722165337.20c91514@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Jul 2007 17:09:28 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Now that sensors_get_ignored() is an internal function, we can change
> > its prototype to suit our needs better.
> > 
> > * Pass the chip name by address.
> > * Pass the feature directly rather than its number.
> > * Switch to a sane convention for the returned value.
> > * Don't check for errors that can't happen.
> > 
> > ---
> >  lib/access.c |   41 ++++++++++++++++++-----------------------
> >  1 file changed, 18 insertions(+), 23 deletions(-)
> 
> And once more the patch looks good.
> (...)
> Let me know when this all lands, then I'll run another round of tests.

I plan to merge all 4 patches on Tuesday (July 24th) morning, unless
someone has objections until then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
