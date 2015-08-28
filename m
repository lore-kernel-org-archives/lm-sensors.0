From: Christian Fetzer <fetzer.ch@gmail.com>
Date: Fri, 28 Aug 2015 08:31:21 +0000
Subject: [lm-sensors] [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Message-Id: <1440750685-19172-1-git-send-email-fetzer.ch@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I've sent this patchset first to the linux-i2c mailing list, but I was told
to better send it to the lm-sensors list as more interested people
might find it here.

--

This is an attempt to upstream the patches created by Thomas Brandon and
Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757.h=
tml)

I have mainly rebased the latest patch version and tested the driver on a
HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor d=
ata
from a w83795adg).

The patched driver is running stable on the machine, given that ic2_piix4 is
loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
sensors triggers some errors:
    ERROR: Can't get value of subfeature temp1_min_alarm: Can't read

While the kernel log shows:
    i2c i2c-1: Transaction (pre): CNT=0C, CMD=05, ADD1, DAT0=03, DAT1=C0
    i2c i2c-1: Error: no response!
    i2c i2c-1: Transaction (post): CNT=0C, CMD=05, ADD1, DAT0=FF, DAT1=FF
Unfortunately I don't know how to tackle this specific issue.

Please review and let me know required changes in order to get this upstream
finally.

Eddi, Thomas, it would be great if you could verify the changes on your
machines.

Regards,
Christian

Christian Fetzer (4):
  i2c-piix4: Optionally release smba in piix4_adap_remove
  i2c-piix4: Convert piix4_main_adapter to array
  i2c-piix4: Add support for multiplexed main adapter in SB800
  i2c-piix4: Add adapter port name support for SB800 chipset

 drivers/i2c/busses/i2c-piix4.c | 151 ++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 134 insertions(+), 17 deletions(-)

--=20
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
