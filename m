From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 13 Jul 2005 11:19:22 +0000
Subject: [lm-sensors] at24c i2c EEPROM driver
Message-Id: <rOum1mvP.1121246050.5151030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

> For the AT24C04, it was misdetected as two chips (by "eeprom"), and
> there was no write support.

"Misdetected as two chips" is a view of the mind. The driver just
doesn't care whether there are two physical 24C02 EEPROMs or one
physical 24C04 EEPROM. It will export the EEPROM space as chucks of 256
bytes, regardless of the physical reality. If might not be convenient,
but that's the way it was designed (for the sake of simplicity).

Keep in mind that the eeprom driver was a test/debug thing in the first
place. But it happens to be used by almost everyone now, due to a lack
of alternative or sufficient publicizing thereof.

That being said, it is still not clear to me whether we really need to
use a kernel driver for writing to EEPROMs. EEPROMs programming doesn't
sound like something you need to do very frequently, which is why
user-space would make sense (and was used so far as a matter of fact).
More on that below.

> > So far we have been able to work around them, typically
> > by using user-space tools to program the eeproms. The question is
> > whether your case is different or not. Is eeprog not sufficient for
> > your needs?
>
> Interesting, it might be worth mentioning that in the Kconfig helptext
> for the "eeprom" driver.  I did some googling, and that never came up.
> (Mention that along with the fact that "eeprom" only handles chips of up
> to about 16 Kbits, and misdetects many of those as multiple chips ... )

Good idea. Care to propose a patch?

> I've got a few applications in mind.  If I stay un-demanding, "eeprog"
> could suffice -- though clearly it'd be slower.  The moment I want
> other kernel drivers to use that state, it wouldn't be enough.

That's right, this is something the current i2c chip drivers (and the
i2c subsystem as a whole, I fear) are not good at. They are meant as
individual drivers, only interacting with user-space. They do not
integrate with the rest of the kernel, as would sometimes be needed.
That being said, the video i2c chip drivers are working differently and
seem to succeed here, it might be worth taking a look.

> It's unrealistic to expect the kernel to defend against user error,
> but it's highly appropriate to expect it not to misconfigure.

When an error can prevent a machine from ever booting, we better add some
serious checks that the user did not misconfigure. It's not unusual for
users to try random module parameters to see if it helps. This is the
reason why I insist that the writability should be handles through an
explicit feature (module parameter, sysfs file, whatever) rather than
associated with a size parameter.

> The main thing I'd put on the agenda if anyone were were to pursue
> that route would be how to provide a decent static declaration of
> boards' I2C configuration, to prevent needing to probe things that
> don't probe well.

Agreed, this would be helpful. Note however that this won't cover all
cases. Some EEPROMs may or may not be present on a given system (think
SPD), and you can't list all motherboard models for x86 anyway. So some
probing or at least manual setting will still be needed.

> Such a thing might be done as part of updating the I2C stack for
> better driver model support, whenever time for such a thing becomes
> available.
> 
> For example, the "platform_bus" is often prepared, in board-specific
> setup code, with a platform_device for each device that's present,
> plus platform_data with information needed by the driver (like what
> GPIOs it uses on this board).  That'd be a useful model for this
> case:  "at address N on this bus there is/may-be a B Kilobit EEPROM
> to expose as read-only".

Agreed as well. That's beyong my own knowledge at least at the moment,
but I'd always comment on patches if they were available.

Thanks,
--
Jean Delvare
