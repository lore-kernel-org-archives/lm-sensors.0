From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <MsdtvI4E.1109598738.7408370.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi James,

> The following patch adds 2.6 kernel support to the lm92 driver from
> sensors-2.9.0. Tested with linux-2.6.11-rc5 on ppc32.

Damn. I have done the exact same work one week ago... I have set a link
to my patch on our "Supported Devices" page, but maybe I should have
advertised more about it. I'm really sorry we duplicated the work.

> - fix endian bugs - use cpu_to_le16(), not swab16()

I do not think there actually is a bug. The SMBus specs say that word
values are transmitted LSB first (hint: SMBus was developed by Intel).
The LM92 (and every other hardware monitoring chip I know of, for that
matter) transmits MSB first. Rationale for this is that it allows people
not interested in decimals to only read the MSB, or so I read. So the
swab16() is there for this reason, which isn't related to the CPU of
the host system in any way.

If you really needed to do that change for the lm92 driver to work
properly, then I would suspect a bug in the i2c bus driver you are
using. Which is it, BTW?

> - if max6635 is detected, show a different device name in sysfs

I had done this in the first place too, but now I am not sure it is a
good idea. Doing this requires adding some code to libsensors, sensors
and about every program relying on libsensors. I don't think it's
worth the effort, especially since the LM92 doesn't seem to be found on
any PC motherboard. I suspect it is actually only found on homebrew
designs. Is it your case? The MAX6635 is really a clone of the LM92, so
I see little benefit in having a separate prefix.

My patch for the new lm92 driver is here:
http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc4-bk5-i2c-lm92.diff

It is known to be broken, in particular setting limits doesn't work. I
have fixed almost everything yesterday. I'll finish the job this
evening, then I'll publish the new version, and would be very happy if
you could test it.

Of course another possibility would be that we go with your patch.
However, since I have a great experience with hardware monitoring
drivers in Linux 2.6, it's likely that there will be less fixes
required if we start from my version. Also, for the lm92 I did not
really port the original driver but merely rewrote it, because the
original driver was very different from the other ones, making code
maintainance over time much harder.

Thanks,
--
Jean Delvare
