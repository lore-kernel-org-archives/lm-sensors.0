From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 12:40:25 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm63) LM64 has a dedicated pin for tachometer
Message-Id: <20120113134025.48fb9400@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120113101321.366a6f35@endymion.delvare>
In-Reply-To: <20120113101321.366a6f35@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Jan 2012 03:55:04 -0800, Guenter Roeck wrote:
> On Fri, Jan 13, 2012 at 04:13:21AM -0500, Jean Delvare wrote:
> > On the LM64, the tachometer function has a dedicated pin and fan speed
> > monitoring is always enabled.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> > ---
> >  Documentation/hwmon/lm63 |    4 +++-
> >  drivers/hwmon/lm63.c     |    3 ++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> > 
> > --- linux-3.3-rc0.orig/Documentation/hwmon/lm63	2012-01-13 09:09:25.000000000 +0100
> > +++ linux-3.3-rc0/Documentation/hwmon/lm63	2012-01-13 09:54:38.000000000 +0100
> > @@ -54,7 +54,9 @@ value for measuring the speed of the fan
> >  Note that the pin used for fan monitoring is shared with an alert out
> >  function. Depending on how the board designer wanted to use the chip, fan
> >  speed monitoring will or will not be possible. The proper chip configuration
> > -is left to the BIOS, and the driver will blindly trust it.
> > +is left to the BIOS, and the driver will blindly trust it. Only the original
> > +LM63 suffers from this limitation, the LM64 and LM96163 have separate pins
> > +for fan monitoring and alert out.
> >  
> Maybe add a note here indicating that fan control is always enabled on LM64 only ?

You mean fan monitoring here, not fan control.

> Otherwise people may wonder why fans don't (always) show up on LM96163. 

Will clarify, thanks for the suggestion.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
