From: mikpolniak@adelphia.net (mikepolniak)
Date: Wed, 05 Jul 2006 20:20:45 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <20060705202045.GA15892@debamd64>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just got a new AM2 motherboard (Gigabyte GA-M55plus-S3g) that has a
ITE8716 sensors chip. I am using kernel 2.6.16 and modified the source
it87.c by replacing all instances of 8712 with 8716. Then recompiled the
driver and ran modprobe it87. Surprise it works !! Apparently its a clone
of the ITE8712 because i get all the fan, temp and voltage readings. This
ITE8716 is also in the top end ASUS M2N32-SLI DELUXE motherboard and
probably more. So many will be looking for it.

