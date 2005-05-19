From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: [PATCH 2.6] bmcsensors
Message-Id: <25381867050327102675e49b3b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(I sent this without the PATCH in the subject first time, so I'm
reposting - sorry)

Hi,

As suggested after some cleanup of the code and waiting on responses
from testers I'm now submitting the latest patch against the 2.6.11.5
kernel for inclusion into the kernel/lm_sensors. Due to the size of
the uncompressed patch I'll have to link to the sourceforge download
page rather than inline it:

http://sourceforge.net/project/showfiles.php?group_id4509&package_id4011&release_id14376

The driver is a direct port over of the 2.4 bmcsensors and i2c-ipmi
drivers. I've merged all the patches that were applied to the 2.4
version since the original port a year ago, and applied a patch
supporting ipmi 0.9 (which was also back-ported to the 2.4 version),
as well as a patch moving initialization to a kernel thread. Finally I
cleaned up the code a bit to better meet the guidelines in
Documentation/CodingStyle.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

PS: I have a patch adding support for dynamic callbacks in device.h,
but I'm porting over the bmcsensors driver to make sure that all works
as expected before posting it here. I'll let post my results when I
have it working.
