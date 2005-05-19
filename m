From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: ADM1030 Driver (+auto fan speed interface proposal)
Message-Id: <1081942629.407d22659307f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> So, if I get you, if it is easier to read to define more than one set
> macro or function, I can do it ?

I guess that this is mostly a matter of personal taste. Not everybody
would agree with me for sure. You are coding the driver, I am not, so
as long as what you do works and doesn't have visible drawbacks, I have
no objection.

That said, see my proposal for a common fan auto speed interface and
you'll understand that more "set" functions will need specific code
anyway.

> Yes, it is the TACH register. I have to implement the access to that
> register.

OK, so it was really missing.

> > More on automatic PWM after lunch ;)

Here we are. I just took a look at the IT8712 datasheet and their
SmartGuardian feature is in fact very similar to the ADM1030's
automatic fan speed mode (more similar than I expected actually).

The IT8712 defines the following values:
1* a temperature over which the fan starts spinning;
2* a temperature over which the fan goes full speed;
3* a temperature below which the fan stops completely (so this is an
hysteresis value for 1*);
4* a PWM value for 1*;
5* a slope (in PWM/degree) to define the PWM value between 1* and 2*.

Let's compare with the ADM030 which has:
1* a temperature over which the fan starts spinning;
2* a range of temperature after Tmin for which the fan has variable PWM
(this is another way to define Tmax);
4* a PWM value for 1*;

The hysteresis value (3*) is hardcoded to Tmin - 5 degrees.

The slope is automatically defined so that PWM = 100% at Tmax.

So all in all I think that we could define the following sysfs files to
represent them both:

fan1_auto_temp_off
fan1_auto_temp_min
fan1_auto_temp_max
fan1_auto_pwm_min
fan1_auto_pwm_max

(Or we can swap the last two members, I don't know what is best.)

Depending on the chip, not all values would be RW, and in some cases
you
would have to compute and possibly round values to be written to the
registers. As an example of this, for the ADM1030, writing to
fan1_auto_temp_max would actually write to the SLOPE register.

Still for the ADM1030, fan1_auto_temp_off would be read-only and report
5 degrees less than fan1_auto_temp_min. fan1_auto_pwm_max would be
read-only and report 255.

I hope you get my point now. I inisist on the fact that having a common
interface for all chips would be really great, the same way we did for
the temperatures, fans and voltage readings and limits. If we simply
exports the registers values, then all the "smartness" will belong to
the userspace and writing specific drivers is pointless. If on the
other hand drivers are made in such a way that they offer a common
interface to the user-space applications, regardless to the physical
implementation of the concepts, then the user-space apps (and mainly
libsensors) can be reduced to their simplest expression and freed of
any chip-specific code. This is what I do aim at.

Alexandre, please tell me if my knowledge of the ADM1030 is correct and
confirm that the proposed interface would be possible to implement for
this chip.

I yet have to check how Winbond's auto fan speed regulation works. I
think that some chips (including other IT87 chips) have more "trip
points" (I think that's how they call it) so we may have to add more
files later, which would only be implemented by chips which need it:

fan1_auto_temp_low
fan1_auto_temp_medium
fan1_auto_pwm_low
fan1_auto_pwm_medium

Or we can even ignore these extra features and automatically set them
according to min and max values (linearly). I'm not really sure that
non-linear control adds much value and is worth the complexity.

OK, this is just a draft at the moment, comments and objections are
welcome. I'm simply using this new driver as an experiment subject so
as to settle good guidelines for the other drivers to follow later.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
