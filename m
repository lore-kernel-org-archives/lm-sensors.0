From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <ScOAEvzl.1097851023.7402210.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Richard,

>Below is the output of the CVS version of sensors-detect, as requested.
>Error: First argument not a number!
>Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0       smbus           SMBus I801 adapter at 18a0
>  Non-I2C SMBus adapter

Your lm_sensors installation is incomplete or broken. The sensors-detect
script needs the i2cdetect binary and appears to find an outdated
version of it. Please review your installation and make sure that no
sensors, i2cdetect or other binaries from lm_sensors nor libsensors
files are in the way. A common error is to have older files under
/usr/bin and /usr/lib, and newer files in /usr/local/bin and
/usr/local/lib (or the other way around). This could explain a number of
problems you have. If you remove old libraries, don't forget to run
ldconfig afterwards. You may also need to clear your shell's binary
history using "hash -r" or "rehash".

Once you have fixed the problem, please run sensors-detect again. It
should be able to scan your SMBus adapter.

Thanks,
Jean Delvare
