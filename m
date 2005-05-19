From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm_sensors/i2c for Red Hat Linux flavours
Message-Id: <20040107224757.GB11093@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

the rebuilds due to the mremap security fix are finally ready :)

The kernels for RH 7.3, 8.0, 9 and FC1 under

    http://atrpms.physik.fu-berlin.de/name/kernel/

are lm_sensors/i2c 2.8.2 patched and enabled. Useland tools, as well
as lm_sensors 2.8.2 built as external kernel modules (so including
some of the experimental tagged drivers) are under:

    http://atrpms.physik.fu-berlin.de/name/lm_sensors/

lm_sensors-2.8.2-0_18.<disttag>.at.i386.rpm
	contains userland tools.
sensord-2.8.2-0_18.<disttag>.at.i386.rpm
	contains the sensord daemon.
lm_sensors-kmdl-[<flavour>-][<kernelversion>]-2.8.2-0_18.<disttag>.at.<arch>.rpm
	contains kernel modules.
lm_sensors-2.8.2-0_18.<disttag>.at.i386.rpm
	contains static lib & header files.

There are also some compatibility shared lib rpms for satisfying
dependencies to vendor shipped packages.

Enjoy! :)
-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040107/bb789d97/attachment.bin
