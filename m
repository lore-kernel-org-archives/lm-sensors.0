From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <20050327111035.1b7ab9c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

[Mark D. Studebaker]
> from the lspci outputs it looks like Khali got it right,
> so  Khali please check in your change.

OK, done.

Michael, this means that you can pick the latest CVS version of
sensors-detect here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

and give it a try. That should be easier than patching an original
source tree (this script is in Perl so it doesn't need to be compiled
anyway).

That being said, it's quite clear that your hardware monitoring chip is
an IT8712F on the ISA bus, so I don't think sensors-detect will find
much on the SMBus - if the i2c-nforce2 module you have does support the
nforce4 at all.

The real problem in your case is that the it87 driver fails to control
your IT8712F chip. As I said in the support ticket, you should check in
/proc/ioports if someone else already requested that region.

Thanks,
-- 
Jean Delvare
