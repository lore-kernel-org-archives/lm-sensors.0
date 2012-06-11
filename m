From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jun 2012 20:50:32 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
Message-Id: <1339447832.31822.42.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339443667-12377-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339443667-12377-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-06-11 at 16:17 -0400, Jean Delvare wrote:
> On Mon, 11 Jun 2012 12:41:07 -0700, Guenter Roeck wrote:
> > Atom CPUs don't have a register to retrieve TjMax. Detection so far was
> > incomplete. Use the X86 model ID to improve it.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v4: Rearranged code to check tjmax table entries first.
> > 
> > v3: Reverted PCI code to avoid possible regressions. Run PCI code first,
> >     then override resulting value with table entry if one exists.
> >     Dropped entries for N2000 and D2000 CPUs as those all have a Tjmax of 100 C
> >     which we can detect separately based on the CPU model number.
> >     Dropped table entries for E6xx series, since the E6xx can not be
> >     distinguished from E6xxT using the model ID string (nor by any other means).
> > 
> > v2: Dropped PCI dependencies
> >     Fixed 330 and 230 detection (2 spaces between CPU and 330/230)
> >     Added support for Cedar Creek CPUs
> >     Declared atom_tjmax as __cpuinitconst
> > 
> > 
> >  drivers/hwmon/coretemp.c |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > (...)
> 
> Applied, thanks.
> 
> I have also updated my standalone driver at:
> http://khali.linux-fr.org/devel/misc/coretemp/
> with a version with all your patches applied.
> 
Great, thanks!

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
