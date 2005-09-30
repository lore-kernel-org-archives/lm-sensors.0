From: laurent.riffard@free.fr (Laurent Riffard)
Date: Fri, 30 Sep 2005 16:51:46 +0000
Subject: [lm-sensors] [PATCH 2.6-mm 0/5] i2c: add link to module in
Message-Id: <433D50A9.2020803@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a series of patch to create symbolic links to the module in
/sys/bus/i2c/drivers. It's useful to see which module provides a given
driver.

~$ tree /sys/bus/i2c/drivers/
/sys/bus/i2c/drivers/
|-- i2c_adapter
|   |-- bind
|   `-- unbind
|-- via686a
|   |-- bind
|   |-- module -> ../../../../module/via686a
|   `-- unbind
|-- w83781d
|   |-- 0-002d -> ../../../../devices/pci0000:00/0000:00:04.4/i2c-0/0-002d
|   |-- 0-0048 -> ../../../../devices/pci0000:00/0000:00:04.4/i2c-0/0-0048
|   |-- 0-0049 -> ../../../../devices/pci0000:00/0000:00:04.4/i2c-0/0-0049
|   |-- bind
|   |-- module -> ../../../../module/w83781d
|   `-- unbind
`-- w83781d-isa
    |-- bind
    |-- module -> ../../../../module/w83781d
    `-- unbind

These patches mainly updates the .owner field of struct xxx_driver variables.
-- 
laurent




-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050930/ccace4e4/signature.bin
