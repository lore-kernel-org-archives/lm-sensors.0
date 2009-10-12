From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Oct 2009 20:52:05 +0000
Subject: Re: [lm-sensors] "Dummy" sensor driver?
Message-Id: <20091012225205.40921f1a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <hb011f$2p0$1@ger.gmane.org>
In-Reply-To: <hb011f$2p0$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ian,

On Mon, 12 Oct 2009 14:45:49 -0500, Ian Pilcher wrote:
> I'm currently working on a libsensors-based program, and I'd like to
> continue that work in my spare moments while I travel.  Unfortunately,
> my laptop is a Lenovo T61, which has no sensors recognized by
> lm_sensors (at least not on RHEL 5).
> 
> Is there any such thing as a "dummy" sensor driver that can give my
> program something to chew on?  I'm not at a state yet where I need
> meaningful data.

We have a dummy i2c adapter driver, named i2c-stub (written by Mark M.
Hoffman originally.) You can emulate up to 10 chips on it, supporting
the basic SMBus transactions most I2C-based hwmon devices use. So, if
you have a register dump from such a device, you can emulate it on any
machine. I do that all the times when working on hwmon drivers for
hardware I don't have.

For example this works very well with the lm90 driver. If you want
dumps from lm90-compatible chips, just let me know and I'll send them
to you. This should also works reasonably well with most National
Semiconductor and Analog Device chips. Just Winbond chips don't work
well because they use banks and i2c-stub doesn't have support for that.

I wrote a helper script, which is in recent versions of the i2c-tools
package, to load dumps to i2c-stub automatically (named
i2c-stub-from-dump).

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
