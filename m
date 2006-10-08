From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 19:47:37 +0000
Subject: [lm-sensors] [PATCH 0/6] More hwmon updates for 2.6.19
Message-Id: <20061008214737.b8dbfcd3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here are 6 more hwmon patches for 2.6.19. These are documentation
updates (4) and bug fixes (2). Please push them to Linus as time
permits.

Summary:

Grant Coady:
 o adm9240: Update Grant Coady's email address

Jean Delvare:
 o hwmon: Fix documentation typos
 o smsc47m1: List the SMSC LPC47M112 as supported

Jim Cromie:
 o w83971d: Fix unchecked return status

Rudolf Marek:
 o k8temp: Documentation update
 o w83627ehf: Fix the detection of fan5

Statistics:

 Documentation/hwmon/adm9240   |    2 
 Documentation/hwmon/f71805f   |    2 
 Documentation/hwmon/k8temp    |   13 ++++--
 Documentation/hwmon/smsc47m1  |    4 +-
 Documentation/hwmon/w83627ehf |    6 +-
 MAINTAINERS                   |    6 +++
 drivers/hwmon/Kconfig         |   10 +++--
 drivers/hwmon/adm9240.c       |    4 +-
 drivers/hwmon/smsc47m1.c      |   11 +++--
 drivers/hwmon/w83627ehf.c     |   11 ++++-
 drivers/hwmon/w83791d.c       |   85 +++++++++++++++++++++++++++--------------
 11 files changed, 101 insertions(+), 53 deletions(-)


-- 
Jean Delvare

