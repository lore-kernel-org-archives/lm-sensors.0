From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 May 2009 08:21:47 +0000
Subject: Re: [lm-sensors] [PATCH v2 5/7] sensord: Refactoring of loadConfig()
Message-Id: <20090513102147.70b77b7b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160411.GF17530@ubuntu>
In-Reply-To: <20090511160411.GF17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 May 2009 10:09:43 +0200, Andre Prendel wrote:
> On Tue, May 12, 2009 at 09:43:20PM +0200, Jean Delvare wrote:
> > On Mon, 11 May 2009 18:04:11 +0200, Andre Prendel wrote:
> > > This patch does some refactoring of the loadConfig()
> > > function.
> > > 
> > > * Simplifying the conditions makes code flow clearer and eliminates
> > > long lines (> 80 chars).
> > > * Removed useless stat() call.
> > > * Return -1 in error case, instead of several positive values (never defined).
> > > 
> > > Changes in v2:
> > > 
> > > Blank line before the first #include.
> > > Fix typo.
> > > Bring back logging (reload configuration).
> > > Consistent error messages.
> > > Drop reading configuration from stdin.
> > > Fix logging (if fopen() fails).
> > > Cleanup sensors before reloading configuration.
> > > Fix compile warning.
> > > Don't print error value if reloadLib() fails.
> > 
> > Looks almost OK, just one minor issue:
> > 
> > > ---
> > > 
> > >  lib.c     |   74 +++++++++++++++++++++++++++++++-------------------------------
> > >  sensord.c |    4 +--
> > >  2 files changed, 40 insertions(+), 38 deletions(-)
> > > 
> > > Index: quilt-sensors/prog/sensord/lib.c
> > > =================================> > > --- quilt-sensors.orig/prog/sensord/lib.c	2009-04-26 22:11:03.000000000 +0200
> > > +++ quilt-sensors/prog/sensord/lib.c	2009-04-26 22:13:09.000000000 +0200
> > > (...)
> > > + 	/* Load default configuration. */
> > > + 	if (!cfgPath) {
> > > + 		if (reload) {
> > >  			sensorLog(LOG_INFO, "configuration reloading");
> > > -			sensors_cleanup();
> > > +  			sensors_cleanup();
> > 
> > You're adding leading white spaces!
> 
> Hi Jean,
> 
> I really cannot see any whitespaces. What do you mean?

I mean:

<minus><tab><tab><tab>sensors_cleanup();
<plus><space><space><tab><tab><tab>sensors_cleanup();

The two spaces shouldn't be there. As a matter of fact, the effective
content of this line doesn't change, so it shouldn't show up in the
diff... unless there are invisible whitespace changes.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
