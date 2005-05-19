From: fdavis@si.rr.com (Frank Davis)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: 2.5.24 : I2C-OLD --> I2C API status
Message-Id: <Pine.LNX.4.44.0207022250150.860-100000@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,
  The 2.5.24 kernel has a few drivers that are using the old i2c 
interface (located in drivers/media/video/*). Here is the list of 
drivers, their status, and patch contributor:

adv7175.c - In progress, Albert Cranford 
bt819.c - Completed (needs hardware testing), Frank Davis
bt856.c - In progress, Frank Davis
i2c-old.c - Removed from Makefile and directory, Albert Cranford
i2c-parport.c - Removed as a config option (should be removed from 
directory as well) Albert Cranford
saa7110.c - Completed (needs hardware testing), Frank Davis
saa7111.c - Completed - Pauline Middelink
saa7185.c - Completed - Pauline Middelink
zr36067.c - Completed Albert Cranford

These files, and affected files, such as include/linux/i2c-id.h , I would 
like to keep untouched, so that they can be merged into the next 2.5.x 
kernel release. Let me know of any problems or inaccuracies. Thanks.

Regards,
Frank
