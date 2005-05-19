From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: i2c_force_data
Message-Id: <uUFEOE76.1099991517.4024680.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041109005252.GA26855@kroah.com>
In-Reply-To: <20041109005252.GA26855@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

>Ick, does anyone still use i2c_force_data?

Yes, we do.

>Does the lm_sensors tools create force data that users use on the
>modprobe command line?

Exactly. Say you have a brand new ABC42 hardware monitoring chip, which
is not recognized by any driver, but happens to be somewhat compatible
with the ABC40, which is one of the devices supported by our xyz120
driver. You can use "modprobe xyz120 force_abc40=0,0xADDR" to get it
to work until better, dedicated support is added. This has proven to be
very useful in the past.

Another use is to workaround improperly identified chips (I have an LM83
eval board where the chip ID and manufacturer ID have not been set, for
example), or for some chips that are not detectable so forcing them is
the only (somewhat safe) way to go.

Now, I do not defend the current implementation of this functionality. If
you can come up with something more elegant, I'm all for that. But the
functionality is doubtlessly useful.

>I'd really like to get rid of that structure (hint, it's the last thing
>standing between the current code probe mess, and automatic chip driver
>loading when adapters are loaded, like the pci and usb and ieee1394 and
>pnp subsystems...)

Beware. Fully automatic detection of I2C clients is technically
impossible. If you are going to try ALL client drivers on all addresses,
this will mean a LOT of register probings and some I2C clients really
don't like this. This would basically mean running a
sensors-detect-like process on each boot. See how slow and I2c-bus
intensive it is? You'll also notice that some chips are supported by
more than just one driver (but with varying feature support levels), so
the driver order will matter much (and possibly no order will be
efficient enough for older chips). In most cases the sensors-detect
script knows about that (it uses confidence levels, not booleans) but we
don't want to move the whole sensors-detect code into kernel space, do
we?

BTW, I don't say that we shouldn't consider automating things at all.
Just that we better be very careful and go by small steps, and accept
the idea that it may not work all the time. In particular, if we go that
direction, I think we would start by listing which chips can safely be
automatically detected and which do not, and only attempt to autoload
safe drivers (or, more precisely, safe devices within a driver). As a
rule of thumb, most recent chips are safe (they have chip ID and
manufacturer ID at relatively standard locations), but older are not.

Thanks,
Jean
