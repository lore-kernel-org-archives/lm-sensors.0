From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Sep 2008 19:36:22 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (w83791d) add support for
Message-Id: <20080930213622.4ce030ba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.47083.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.47083.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Sep 2008 19:49:42 +0200, Marc Hulsman wrote:
> Hi Jean,
> 
> > I think you have a bug in your code. I also have minor stylistic
> > comments.
> 
> thanks for spotting this one. Somehow I missed it during testing. Hereby an 
> updated patch, which also fixes the minor style issues. 
> 
> > > +/* for thermal cruise target temp, 7-bits, LSB = 1 degree Celsius */
> > > +#define TARGET_TEMP_FROM_REG(val)    ((val) * 1000)
> >
> > This is the same as TEMP_FROM_REG so you could just use that.
> 
> Removed those. I added them to get symmetry.
> 
> > > +#define TOL_TEMP_TO_REG(val)         ((val) < 0 ? 0 : \
> > > +                                     (val) >= 15000 ? 15 : \
> > > +                                     ((val) + 500) / 1000)
> >
> > Note: if you want to spend some more time on the w83791d driver, one
> > thing that would be welcome is converting all these macros to inline
> > functions.
> 
> I am already planning to write some cleanup-patches later on, will add this to 
> the list. 
> 
> > I am not necessarily very happy with the file names you came up with.
> > pwm[1-3]_target is a bit ambiguous. Is it a temperature target or a fan
> > speed target? If you were to implement support for the Fan Speed Cruise
> > mode, how would you name the file?
> >
> > I did implement something like the Fan Speed Cruise mode in the f71085f
> > driver. I named the files fan[1-3]_target, to make it clear what the
> > target was. This is even part of Documentation/hwmon/sysfs-interface by
> > now, and a second driver is implementing it that way (max6650).
> > Following the same logic, the Thermal Cruise mode files should be named
> > temp[1-3]_target (and presumably temp[1-3]_tolerance for the tolerance).
> >
> > Unfortunately it seems that you got your file names from the w83627ehf
> > driver, so we already have one driver doing things that way (in fact 2:
> > the w83l786ng driver is doing the same.) To make things even worse, the
> > w83792d and w83793 drivers have a 3rd set of file names
> > (thermal_cruise[1-3] and tolerance[1-3]). It would be nice if we could
> > settle for one naming, document that in file sysfs-interface, and use
> > that for all devices which implement Thermal Cruise mode.
> 
> I indeed looked at the other drivers for those names, but I agree that the 
> temp_* is better. In the updated patch all occurences have been renamed.
> 
> Thanks for the review,
> 
> Marc
> 
> --
> Adds support to set target temperature and tolerance for thermal cruise mode.
> 
> Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl>
> ---
>  Documentation/hwmon/w83791d |   19 ++++-
>  drivers/hwmon/w83791d.c     |  148 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 162 insertions(+), 5 deletions(-)

Applied, thanks. All 4 patches are in my hwmon tree now:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
I will send them to Linus for 2.6.28.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
