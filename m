From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: documentation update for 2.6
Message-Id: <wbxnHvL2.1107873365.1108060.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0502051302190.7839@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0502051302190.7839@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ruik,

Here are my comments about the big documentation update you worked on for
Linux 2.6:

ALI bus drivers:
The datasheets are no longer available using a password. The site says
you have to sign a NDA:
http://www.ali.com.tw/eng/support/datasheet_request.php
And acerlabs.com doesn't exist anymore.
Don't include the "Module parameters" section when there is no module
parameters.

i2c-amd756 bus driver:
Kill the "Status" line.

i2c-i801 bus driver:
The 2.6 version of the driver does NOT support I2C block reads (which is
good because in 2.4 that feature is broken at the moment).

i2c-i810 bus driver:
The initial comment about i2c-algo-bit can be removed, will be handled
automatically by Kconfig dependencies.
Typo, i2c-i80 instead of i2c-i801.
The "issue" about debug mode can be killed, it is fixed.

i2c-nforce2 bus driver:
Supported chip list is incomplete, 4 different chips are now supported
(including nForce3 flavors).

i2c-parport bus driver:
Please do not duplicate everything in i2c-parport-light. If you want a
doc file for -light, make it very short and redirect the reader to
i2c-parport.

i2c-piix4 bus driver:
"cat /proc/pci" is deprecated, that would be "lspci -v".

Savage bus drivers:
Kill the comments on i2c-algo-bit dependency.

i2c-sis5595 bus driver:
The "force_addr=0x290" is very, very unlikely to produce any
interesting result. This address is typical for chip drivers, and this
is a bus driver. Or is this chip really that strange?
s/sis5595\.o driver/sis5595 driver/
Kill the modprobe example, people are supposed to know that.
Kill the feedback request line, it's not driver-specific.

i2c-sis630 bus driver:
Kill the comment on kernels 2.4.18+ not tested.
Also kill the next paragraph requesting feedback, it's not really
informative.

i2c-sis96x bus driver:
Kill the feedback request paragraph.

i2c-stub pseudo bus driver:
There is ALREADY a doc file in 2.6, so don't add one.

i2c-via bus driver:
Kill /proc/pci.
Kill modprobe example.
Kill i2c-algo-bit requirement hint.

i2c-viapro bus driver:
Kill /proc/pci.
Kill modprobe example.

i2c-voodoo3 bus driver:
The paragraph about i2c-piix4 is completely broken. This driver is
i2c-algo-bit-based so it DOES support all I2C commands. Correct the
"Features" paragraph accordingly.
Kill the i2c-algo-bit requirement hint.


That's all for bus drivers. Thanks a lot for the hard work. It would be
really nice if you could update the files in lm_sensors CVS for
everything that isn't 2.6-specific (almost everything but Kconfig
stuff, as far as I can see).

I'll comment on chip drivers later (not today).

Thanks,
--
Jean Delvare
