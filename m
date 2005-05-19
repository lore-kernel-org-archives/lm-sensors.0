From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [eidtmann@informatik.uni-bremen.de: Kernel driver adm1021 locks]
Message-Id: <20031215110024.GB517@arda.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Jan Eidtmann <eidtmann@informatik.uni-bremen.de> -----

From: Jan Eidtmann <eidtmann@informatik.uni-bremen.de>
Reply-To: eidtmann@informatik.uni-bremen.de
To: Frodo Looijaard <frodol@dds.nl>
Subject: Kernel driver adm1021 locks
Cc: Philip Edelbrock <phil@netroedge.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hi,

when adm1021 loads (either by me with modprobe or by the kernel when built 
in), the computer locks. when i push the reset button my motherboard beeps 
like crazy and it does not boot. however, when i totally switch off the power 
supply and switch on again, i can boot again.

my motherboard is a gigabyte GA-8IPE1000 Pro with intel 865PE chipset (ICH5). 
linux is linux-2.6.0-test11.

could it be that the 2.6.0-test11 i2c drivers are behind the lm_sensors 2.8.2 
package?

if i got that right i need this driver to detect my ICH5 chipset!?

OT: btw, do i need i2c-isa support? that motherboard has no isa slots at all, 
but maybe theres still some kind of isa bus inside (needed for i2c)?

many thanks!
Jan

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
