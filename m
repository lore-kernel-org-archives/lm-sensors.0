From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Feb 2009 16:08:02 +0000
Subject: [lm-sensors] [PATCH 0/6] Add support for multiple configuration
Message-Id: <20090211170802.59b3768f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is an updated proposal to enable support for multiple configuration files
to libsensors. I have hopefully addressed all the constructive comments
I received about the first proposal [1]. Thanks Luca and Matt!

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2009-February/025274.html

 doc/libsensors-API.txt  |    4 +
 lib/access.c            |   17 +++--
 lib/conf-lex.l          |   22 ++++---
 lib/conf-parse.y        |   18 ++---
 lib/conf.h              |    1 
 lib/data.c              |   27 ++++++--
 lib/data.h              |   29 +++++++--
 lib/error.c             |   23 +++++++
 lib/error.h             |   21 +++++-
 lib/init.c              |  150 +++++++++++++++++++++++++++++++++++++++---------
 lib/libsensors.3        |   16 ++++-
 lib/scanner.h           |    2 
 lib/sensors.conf.5      |   20 +++++-
 lib/test/test-scanner.c |    2 
 14 files changed, 276 insertions(+), 76 deletions(-)

Important changes:
* Reloading the configuration files works again (patch 3/6).
* Error handling when configuration files can't be read has been
  improved. Errors are reported instead of being silently ignored
  patch 4/6).
* Error reporting now includes the file name (patches 5/6 and 6/6).
  This makes it much easier to locate and fix mistakes in configuration
  files.

This last point was implemented by extending the libsensors API with a
3rd error reporting function. I made it backwards compatible, that is,
an application which defined a custom function to handle parse errors
using the old API will still have it called. The new default parse error
handling function is only called if the old handling function is the
default one as well. So we should be on the safe side, even though this
was probably not needed: I couldn't find any monitoring application
actually defining a cutom parse error function.

The patches apply on top of SVN. I would welcome testing and further
comments. You can fetch a combined patch at:
  http://jdelvare.pck.nerim.net/sensors/libsensors-support-for-multiple-config-files.patch
if it makes testing easier for you.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
