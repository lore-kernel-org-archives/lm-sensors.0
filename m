From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Sep 2005 21:39:56 +0000
Subject: [lm-sensors] [PATCH] (0/7) i2c-viapro driver update
Message-Id: <20050922213930.4b834f69.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

Here comes a 7-piece patchset updating the i2c-viapro driver. I have a
VT8237R on my new motherboard, which I could use to test my work. I had
a few testers for other VIA chips as well for some of the patches
already, but more testers would of course be welcome. The i2c-viapro
driver supports many VIA south bridges, not all of which behave the
same way.

I would like to thank VIA for releasing datasheets for some of their
south bridges recently. I couldn't have improved the i2c-viapro driver
the way I did without this technical information. Their position isn't
exactly clear yet, as the datasheets are no more available for download
from their web site. I hope they will restore them soon, as making
datasheets freely available to open-source developers is the only way
the support for their chips in Linux can improve.

The patches are against 2.6.14-rc2, and I would like them to spend some
time in -mm, as some of the changes definitely deserve wide testing. So
it's definitely not meant for inclusion into 2.6.14 (if it wasn't
obvious enough). I hope they'll make it into 2.6.15 though.

Thanks.

 Documentation/i2c/busses/i2c-viapro |   27 +++-
 MAINTAINERS                         |    6 +
 drivers/i2c/busses/i2c-viapro.c     |  272 +++++++++++++++++++-----------------
 3 files changed, 166 insertions(+), 139 deletions(-)

-- 
Jean Delvare
