From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Jul 2006 16:01:36 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon updates
Message-Id: <20060705180136.34f52941.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 5-piece hwmon update patchset. We have a fix to the new
abituguru driver, new features for the w83627ehf driver, and
documentation updates. The first 3 patches (marked with a star below)
are meant for 2.6.18, the rest (2 patches) should stage in Andrew's
tree until 2.6.19.

Here's the summary:

Charles Spirakis:
 o hwmon: New maintainer for w83791d (*)

Hans de Goede:
 o hwmon: Fix for first generation Abit uGuru chips (*)
 o hwmon: Documentation update for abituguru (*)

Rudolf Marek:
 o hwmon: Add fan speed control features to w83627ehf
 o hwmon: Documentation update for w83627ehf

Statistics:

 Documentation/hwmon/abituguru |   32 +++
 Documentation/hwmon/w83627ehf |   85 +++++++++
 MAINTAINERS                   |    6 +
 drivers/hwmon/abituguru.c     |   21 ++
 drivers/hwmon/w83627ehf.c     |  393 ++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 522 insertions(+), 15 deletions(-)


-- 
Jean Delvare

