From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Oct 2010 20:19:11 +0000
Subject: [lm-sensors] IT8721F/IT8758E support
Message-Id: <20101011221911.38c8a3d7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Patrick, Jae, Virgil,

I am done adding support for the IT8721F/IT8758E to the it87 Linux
driver. You can download a stand-alone version of the driver at:
  http://khali.linux-fr.org/devel/misc/it87/

Please test and report :) Beware the code is untested so far, as I
don't have this chip at hand.

Patrick, note that with an Asus board, it is entirely possible that the
it87 driver can't be loaded due to ACPI requesting the I/O ports
(you'll get a warning in the kernel log in that case) and you have to
use the asus_atk0110 driver instead.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
