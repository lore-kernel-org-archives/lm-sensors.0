From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: i2c header installs
Message-Id: <3EEB8803.6020902@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(ticket 1289)
when 'make install' in i2c puts the headers in /usr/local/include,
i2c.h has "#include "i2c-id.h" instead of
"#include <linux/i2c-id.h>" so 
sensors compiles miss the new i2c-id.h in /usr/local/include
and pick up the old one in the kernel tree.

I'm going to copy the sed script conversion routine from mkpatch
and use it in 'make install'.
