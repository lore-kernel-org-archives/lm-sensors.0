From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 30 Nov 2007 21:36:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] HWMON: coretemp, suspend fix
Message-Id: <20071130133632.e1781b57.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <661416096128474967.slaby@pripojeni.net>
	<200711301746.19447.rjw@sisk.pl>
In-Reply-To: <200711301746.19447.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jirislaby@gmail.com, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, r.marek@assembler.cz, lm-sensors@lm-sensors.org

On Fri, 30 Nov 2007 17:46:18 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Friday, 30 of November 2007, Jiri Slaby wrote:
> > Ok, I don't see it merged in the latest -mm (mmotm). Could you, Mark, Rafael,
> > sign off this version of the patch (Mark's + Rafael's fix)?
> > 
> > --
> > 
> > From: Mark M. Hoffman <mhoffman@lightlink.com>
> > 
> > coretemp, suspend fix
> > 
> > It's not permitted to unregister device/cpu if frozen and going to sleep.
> > It causes deadlock on systems, where coretemp hwmon is loaded. Do it only
> > in non-freezed states instead.
> > 
> > Cc: Rafael J. Wysocki <rjw@sisk.pl> (frozen fix)
> > Cc: Mark M. Hoffman <mhoffman@lightlink.com>

Should that have been signed-off-by:Mark?

> > Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

So I'll assume this is for-2.6.24, to-be-merged-by-me.  If it turns up in
Mark's tree (or anyone else's) then I'll drop it and forget all about it.
Which is OK, as long as whoever-merged-it remembers to get it into 2.6.24.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
