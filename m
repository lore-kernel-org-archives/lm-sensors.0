From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Dec 2012 16:54:30 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121216165430.GA22021@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 16, 2012 at 11:15:06AM +0100, Jean Delvare wrote:
> Hi David,
> 
> On Thu, 13 Dec 2012 00:58:35 -0700, David Hubbard wrote:
> > On Wed, Dec 12, 2012 at 7:45 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > > We do not support any VID decoding since family 10h CPUs for AMD:
> > >
> > >         {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25},      /* NPT family 10h
> > > */
> > >
> > > Starting with family 11h CPUs, AMD has given up on parallel VID in
> > > favor of serial VID which uses only 2 pins. I know that the IT8720F has
> > > support for this, but I did not find any trace in other ITE datasheets.
> > >
> > > The serial VID uses 7-bit codes which are incompatible with the
> > > previous 6-bit parallel VID codes used by family 10h CPUs. BTW the
> > > family 10h CPUs already supported serial VID, and I have no idea how to
> > > support that properly as hwmon-vid has no idea whether the code came
> > > from the serial or parallel VID interface.
> > >
> > > The following should at least get rid of the warning in the kernel logs:
> > >
> > > * * * * *
> > >
> > > Since family 11h processors, AMD is exclusively using 7-bit VID codes
> > > transmitted using a serial protocol over two pins (clock and data.)
> > >
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > >  drivers/hwmon/hwmon-vid.c |   10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > --- linux-3.7-rc8.orig/drivers/hwmon/hwmon-vid.c        2012-10-20
> > > 21:11:32.000000000 +0200
> > > +++ linux-3.7-rc8/drivers/hwmon/hwmon-vid.c     2012-12-12
> > > 15:36:36.309882929 +0100
> > > @@ -115,6 +115,12 @@ int vid_from_reg(int val, u8 vrm)
> > >                 return (val < 32) ? 1550 - 25 * val
> > >                         : 775 - (25 * (val - 31)) / 2;
> > >
> > > +       case 26:                /* AMD family 10h to 15h, serial VID */
> > > +               val &= 0x7f;
> > > +               if (val >= 0x7c)
> > > +                       return 0;
> > > +               return DIV_ROUND_CLOSEST(15500 - 125 * val, 10);
> > > +
> > >         case 91:                /* VRM 9.1 */
> > >         case 90:                /* VRM 9.0 */
> > >                 val &= 0x1f;
> > > @@ -195,6 +201,10 @@ static struct vrm_model vrm_models[] = {
> > >         {X86_VENDOR_AMD, 0xF, 0x40, 0x7F, ANY, 24},     /* NPT family 0Fh
> > > */
> > >         {X86_VENDOR_AMD, 0xF, 0x80, ANY, ANY, 25},      /* future fam. 0Fh
> > > */
> > >         {X86_VENDOR_AMD, 0x10, 0x0, ANY, ANY, 25},      /* NPT family 10h
> > > */
> > > +       {X86_VENDOR_AMD, 0x11, 0x0, ANY, ANY, 26},      /* family 11h */
> > > +       {X86_VENDOR_AMD, 0x12, 0x0, ANY, ANY, 26},      /* family 12h */
> > > +       {X86_VENDOR_AMD, 0x14, 0x0, ANY, ANY, 26},      /* family 14h */
> > > +       {X86_VENDOR_AMD, 0x15, 0x0, ANY, ANY, 26},      /* family 15h */
> > >
> > >         {X86_VENDOR_INTEL, 0x6, 0x0, 0x6, ANY, 82},     /* Pentium Pro,
> > >                                                          * Pentium II,
> > > Xeon,
> > >
> > > Also available as a standalone driver at:
> > >   http://khali.linux-fr.org/devel/misc/hwmon-vid/
> > >
> > >
> > After applying the patch you sent cpu0_vid reads as 1550. Thanks much, that
> > was very helpful.
> 
> 1.550 V is the maximum value supported by the VID encoding on these
> processors. This corresponds to value 00h. This means that either the
> chip doesn't support VID, or not in this register, or it is supported
> but not wired on the board in question.
> 
> Either way, thanks for testing, I'll push this upstream for other AMD
> family 11h+ processor users.
> 
Feed free to add

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
