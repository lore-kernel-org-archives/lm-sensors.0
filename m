From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 25 Nov 2007 10:17:57 +0000
Subject: Re: [lm-sensors] hwmon: (fschmd) Discard non-ASCII characters
Message-Id: <20071125111757.141ecc45@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071013192245.1054a497@hyperion.delvare>
In-Reply-To: <20071013192245.1054a497@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 24 Nov 2007 20:53:26 -0500, Mark M. Hoffman wrote:
> Hi Jean:
> 
> * Jean Delvare <khali@linux-fr.org> [2007-10-13 19:22:45 +0200]:
> > Somehow non-ASCII characters managed to sneak into the fschmd driver.
> > Kick them out.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Hans de Goede <j.w.r.degoede@hhs.nl>
> > ---
> >  drivers/hwmon/fschmd.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Somewhere between this patch hitting my inbox and getting sucked into
> git, it got corrupted.  Weird.  Anyway, I re-created it locally and
> applied it to hwmon-2.6.git/testing, thanks.

I expected it... Inline patches only work well for pure ASCII. As soon
as the patch contains a non-ASCII character, mail clients and servers
try to be smart and encode and decode things arbitrarily. Thanks for
re-creating the patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
