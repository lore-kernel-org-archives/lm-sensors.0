From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Dec 2013 09:17:56 +0000
Subject: Re: [lm-sensors] w83l786ng driver bug, questions, and 1st round patch
Message-Id: <20131202101756.1d4da957@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
In-Reply-To: <CABhEY3OZAkB=NxDj-QSjWATQAPG-Akhr2a0CHTB7wahLJVH6aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Brian,

On Sun, 1 Dec 2013 21:21:29 -0800, Brian Carnes wrote:
> > The "enable" and "mode" sysfs files are hooked up to the bitfields
> backward.
> >> No. There is a standard for sysfs attributes of hwmon drivers.
> 
> Gotcha.  Having now read and digested hwmon's sysfs doc, I agree completely.
> 
> My path to this was:
>  a) What chip do I have here?
>  b) Where's the datasheet?
>  c) Ooh, there's a kernel module for this already!
>  d) The names match the datasheet, but backwards... :(

I understand :)

> I'll view the world through hwmon-ABI-colored glasses for the rest of this
> discussion...
> 
> > switching from DC to PWM or the other way around is normally not needed
> > as both modes need different electronics on the board and the BIOS should
> > set the right mode.
> 
> Embedded.  pre-boot environment is just leaving things at power-on
> defaults...

Sysfs is not the proper interface to work around the lack of proper
BIOS-style initialization. Embedded systems should provide device
initialization data and the driver should initialize the chip based on
that. Leaving the responsibility to the user is insane. I would even
argue that, in the case of fans, leaving the responsibility to the OS
is quite dangerous already.

> > I see. This is caused by the mask error you have already found out.
> > Looks like this feature of the driver didn't receive much testing...
> 
> Kevin concurred on the fix.  The patch as an attachment is re-included w/
> this msg as patch #1.

Got it, thanks. For next time:
* Each patch should come with a subject and a description.
* Each patch should come with its own Signed-off-by line.
* It's much easier for me if the patches can be applied with patch -p1,
  i.e. the file paths in the patch header includes the directory where
  the source files live.
* No compressed tarballs please. Patches are preferred inline or as
  plain-text attachments.

I did it this time, the result is:
http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/hwmon-w83l786ng-01-fix-pwmX_enable.patch

> > Mode "FAN_SET" is problematic on its own, independent of the bug...
> > It's not really an automatic fan speed mode so it shouldn't have value >> > 2 The closest standard mode would be 0, except that 0 is supposed to mean
> > "100%", not "some arbitrary initial value".
> 
> I like keeping mode 0 as universal fail-safe "100% fan".  We can synthesize
> a mode 0 for this hardware even though it is lacking one.
> 
> See patch #3, attached.

It isn't necessary, we have a lot of drivers already which do not
implement mode 0, exactly because the hardware itself does not.
User-space already knows how to deal with this. In other words, I am
not interested in 03_pwmX_enable_synthetic_mode_0.diff.

> > Well, we could write 0xf to register 0x90 bits 3..0 (assuming they are
> > writable as the datasheet says) to force the 100% but then this would
> > prevent the user from returning to the initial state, plus I'm not sure
> > what would happen at suspend/resume or reboot.
> 
> They are writable.  But part of the current behavior is nice in that the
> driver doesn't change the state of the hardware at all upon loading.  It'd
> be nice to preserve the passive nature of the driver until someone actually
> writes to a sysfs file.

This is generally desirable indeed. However there are a few cases where
transparently reconfiguring the chip at driver load time allows for
run-time code simplification. This is allowed as long as there is no
side effect.

> > OTOH, if we stick to value 4 for this mode, then there's no reason to
> > not let the user switch back to it. Supporting it would be truly
> > trivial.
> 
> Yes, but your ABI seems to want to have enable modes >= 2 be
> smart/non-manual.  This is like another flavor of manual, with a separate
> pwm register for FAN_SET.

Yes, you are correct.

> > Another possibility would be to hide this mode, by transparently
> > switching to the equivalent speed in manual control mode when the
> > driver is loaded. Then only modes 1, 2 and 3 would be visible to the
> > user. To be honest I'm not sure why the chip maker didn't implement it
> > this way in the first place. I think this option has my preference.
> > Guenter, what do you think? Do we have any precedent?
> 
> This is my preference also.  Although I'd do the extra work to make this
> passive (FAN_SET appears as manual w/ pwmX sys returning the special
> FAN_INI duty cycle, until such time as someone writes to sysfs in a way to
> have us commit to switching from hardware mode 4 (fan_set) to hardware mode
> 1 (manual).
> 
> See patch #4, attached.

I would do the transition from FAN_SET to manual transparently at
driver initialization time, to make the run-time code as fast as
possible. But I understand and respect your views on this.

> > Indeed, Richard (Cc'd) noticed some problems with fan speed control
> > back then, but he did not provide enough details for investigation. The
> > bug you found could well explain these problems, and Richard would
> > probably be interested in testing your fix.
> 
> There's a 2nd bug, that almost certainly affected Richard also.

As a side note, since Lavabit is down *sigh*, I'm not sure if Richard
can actually read us.

> The current code sets "pwmX" as an 8-bit value.  This hardware has a 4-bit
> pwm field.  The driver is setting both pwmX (aka pwmX_auto_point1) and
> pwmX_auto_point2 when the user attempts to assign to pwmX.
> 
> It's especially noticeable when running pwmconfig, as the 2nd level
> attempted is "240", which has the low 4-bits cleared, so the fan speed
> drops to zero on step 2.  Example:
> 
> Would you like to generate a detailed correlation (y)?
>     PWM 255 FAN 3026
>     PWM 240 FAN 0
>     Fan Stopped at PWM = 240

Doh, this is very bad :(

> See attached patch #2.  After applying it, we get instead:
> 
> Would you like to generate a detailed correlation (y)?
>     PWM 255 FAN 3096
>     PWM 240 FAN 2909
>     PWM 225 FAN 2721
>     PWM 210 FAN 2500
>     PWM 195 FAN 2343
>     PWM 180 FAN 2327
>     PWM 165 FAN 2096
>     PWM 150 FAN 1885
>     PWM 135 FAN 1614
>     PWM 120 FAN 1424
>     PWM 105 FAN 0
>     Fan Stopped at PWM = 105

Much better... Unfortunately your patch is too large to qualify for
stable kernel series. We'll have to find a more simple fix which really
only addresses the immediate problem. The rest of the code can go in a
separate patch, to go in kernel 3.13+ but not older stable kernel
series.

If I'm not mistaken, the following minimal fix should work:

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (w83l768ng) Fix fan speed control range

The W83L786NG stores the fan speed on 4 bits while the sysfs interface
uses a 0-255 range. Thus the driver should scale the user input down
to map it to the device range, and scale up the value read from the
device before presenting it to the user.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/w83l786ng.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-3.13-rc2.orig/drivers/hwmon/w83l786ng.c	2013-12-02 09:14:56.247009803 +0100
+++ linux-3.13-rc2/drivers/hwmon/w83l786ng.c	2013-12-02 10:07:49.718037923 +0100
@@ -481,6 +481,7 @@ store_pwm(struct device *dev, struct dev
 	if (err)
 		return err;
 	val = clamp_val(val, 0, 255);
+	val = DIV_ROUND_CLOSEST(val, 0x11);
 
 	mutex_lock(&data->update_lock);
 	data->pwm[nr] = val;
@@ -777,8 +778,9 @@ static struct w83l786ng_data *w83l786ng_
 			    ? 0 : 1;
 			data->pwm_enable[i]  			    ((pwmcfg >> W83L786NG_PWM_ENABLE_SHIFT[i]) & 3) + 1;
-			data->pwm[i] = w83l786ng_read_value(client,
-			    W83L786NG_REG_PWM[i]);
+			data->pwm[i] +			    (w83l786ng_read_value(client, W83L786NG_REG_PWM[i])
+			     & 0x0f) * 0x11;
 		}
 
 
Please test and confirm.

> >Thanks for finding and fixing this bug. Please resend your
> >patch as explained above and I'll be happy to apply it, forward it to
> >the stable kernel maintainers, and make the updated driver available in
> >a stand-alone flavor.
> 
> First time submitter.  Sorry for the newbie submission mistake.

It's all OK, no worry. Be persistent and I'll be patient :)

> Between gmail and the mailing list software, don't know who's mangling.

That would be gmail, the mailing list software does not. It might be
configurable, I don't know, I don't use gmail.

> I'll just attach the patches as files to be safe.

This is OK with me.

> As for Guenter's comments on using pwmX_enable=0, it sounds like everyone
> prefers enable=0 to be 100% fan if we can present it that way.

Yes.

> After the patches below, we get the illusion of FAN_SET as manual mode,
> which then collapses into actual manual mode upon touching pwmX or
> pwmX_enable in a way that matters.

Fine with me.

> If anyone wanted to return to FAN_SET mode, they could save off the initial
> value returned by pwmX (which is the masquerading FAN_INI value)  and use
> that in manual mode to reach a state indistinguishable from FAN_SET mode.

Indeed... Same as for every other device BTW.

> I'm also open to exposing FAN_INI value directly in sysfs, if you had a
> preferred naming convention for that.

No, we don't have a standard file name for that and I don't think it
makes sense to craft one for just this rare device.

So, please confirm that my patch above is enough to fix the second bug.
Then rebase your second patch on top of it, drop your third patch,
rebase the 4th patch on top of the result, and resubmit the two rebased
patches for me to review (could be in a separate discussion thread.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
