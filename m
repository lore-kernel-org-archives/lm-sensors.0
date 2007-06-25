From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 09:12:44 +0000
Subject: [lm-sensors] Separate package for i2c tools
Message-Id: <20070625111244.1ca5327a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As part of the libsensors rewrite that is ongoing, the lm-sensors
package is being reorganized. For example I already deleted all the
Linux 2.4 kernel drivers that were previously part of the package.
Another step which I'd like to take is moving the i2c tools to a
separate package.

Rationale:
* Many users of lm-sensors no longer need them, because their hardware
monitoring chip is on the LPC or PCI bus and not on the SMBus.
* Even for users of SMBus hardware monitoring chips, the i2c tools are
only needed for debugging, so most users don't need them.
* There are many other I2C devices out there (RTC, video...),
developers of drivers for these devices could make use of these tools,
but they may not even know they exist, or they know but they don't
want to bother installing the whole lm-sensors package.
* The future lm-sensors will only support 2.6 kernels, while the i2c
tools will still support older kernels.

We need to find a package name. I propose "i2c-tools". Objections?

We also need to agree on which files should be moved. Some parts of the
(current) lm-sensors package clearly belong to the new i2c tools
package: i2cdetect, i2cdump, i2cget, i2cset, ddcmon, decode-dimms.pl,
decode-edid.pl, decode-vaio.pl, decode-xeon.pl, eepromer/*, py-smbus/*,
i2c-dev.h. For some others it's not so clear.

* isadump, isaset: Not strictly sensors-specific, but not i2c-related
either. They share their command line syntax and a very small amount of
code with i2cdump. I'd rather leave them where they are.

* unhide_ICH_SMBus: Not strictly sensors-specific, but I don't think
people really need this unless they are trying to get their sensors to
work. No opinion.

* matorb/*: Last touched 8 years ago. Hmm, delete?

* mkdev.sh: Not strictly sensors-related, but the FAQ, INSTALL and
sensors-detect refer to it. It probably doesn't really matter as these
device nodes are created by udev nowadays. No opinion.

I plan to remove the dependency between sensors-detect and i2cdetect as
part of this change, otherwise we lose much of the benefit.
sensors-detect only uses i2cdetect to list the available i2c buses, it
should be easy to do the same in perl directly.

Axel, how can I create a brand new project in SVN? Do I need your help?
Is it possible to preserve the history while moving the files from one
project to another?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
