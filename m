From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 20 Nov 2014 19:08:51 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (nct6775) Documentation updates
Message-Id: <20141120190851.GA12748@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1416504072-10596-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1416504072-10596-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 20, 2014 at 06:46:22PM +0100, Jean Delvare wrote:
> On Thu, 20 Nov 2014 09:21:12 -0800, Guenter Roeck wrote:
> > Document support for NCT6102D/NCT6106D and NCT6791D.
> > Document that NCT5573D is compatible to NCT6775F with the same chip ID.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2: Added NCT6102D/NCT6106D.
> > 
> >  Documentation/hwmon/nct6775 | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/hwmon/nct6775 b/Documentation/hwmon/nct6775
> > index 4e9ef60..b1ad2d3 100644
> > --- a/Documentation/hwmon/nct6775
> > +++ b/Documentation/hwmon/nct6775
> > @@ -8,11 +8,15 @@ Kernel driver NCT6775
> >  ==========> >  
> >  Supported chips:
> > +  * Nuvoton NCT6102D/NCT6106D
> 
> And NCT6104D? Yeah of course I could have told you earlier but where
> would the fun be then? ;) Anyway:
> 
Interestingly, the datasheet doesn't mention it, which is why I forgot
about it, but it is available to buy, so I guess it must exist ;-).

https://www.nuvoton.com/resource-files/NCT6102D_NCT6106D_Datasheet_V1_0.pdf

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
Thanks!

Guenter

> > +    Prefix: 'nct6106'
> > +    Addresses scanned: ISA address retrieved from Super I/O registers
> > +    Datasheet: Available from the Nuvoton web site
> >    * Nuvoton NCT5572D/NCT6771F/NCT6772F/NCT6775F/W83677HG-I
> >      Prefix: 'nct6775'
> >      Addresses scanned: ISA address retrieved from Super I/O registers
> >      Datasheet: Available from Nuvoton upon request
> > -  * Nuvoton NCT5577D/NCT6776D/NCT6776F
> > +  * Nuvoton NCT5573D/NCT5577D/NCT6776D/NCT6776F
> >      Prefix: 'nct6776'
> >      Addresses scanned: ISA address retrieved from Super I/O registers
> >      Datasheet: Available from Nuvoton upon request
> > @@ -20,6 +24,10 @@ Supported chips:
> >      Prefix: 'nct6779'
> >      Addresses scanned: ISA address retrieved from Super I/O registers
> >      Datasheet: Available from Nuvoton upon request
> > +  * Nuvoton NCT6791D
> > +    Prefix: 'nct6791'
> > +    Addresses scanned: ISA address retrieved from Super I/O registers
> > +    Datasheet: Available from Nuvoton upon request
> >  
> >  Authors:
> >          Guenter Roeck <linux@roeck-us.net>
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
