From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Feb 2007 17:21:44 +0000
Subject: [lm-sensors] M2NPV-VM ITE Super-I/O, IT8716F
Message-Id: <20070218182144.c9b7266c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <fc808e200702161328r54868ffdm3deed3aa26fc63dd@mail.gmail.com>
In-Reply-To: <fc808e200702161328r54868ffdm3deed3aa26fc63dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tom,

On Fri, 16 Feb 2007 15:28:55 -0600, Tom Bishop wrote:
> I have this motherboard and would like to get lm-sensors working.....I have
> read and see there are some kernel patches but what I am trying to find out
> what/how do I need to go about patching the kernel to get this working.  I
> am actually re-compiling my kernel (2.6.17) to change some settings so if
> someone could let me know how the best wat to proceed It would be
> appreciated.. Thanks.

You can fetch a patch adding support for the IT8716F and IT8718F to the
Linux 2.6.17 it87 driver from my home server:
  http://jdelvare.pck.nerim.net/sensors/hwmon-it8716f-it8718f-v4-2.6.17.patch

Apply it with the following command (from your kernel source tree's
root):
  patch -p1 --dry-run < /path/to/hwmon-it8716f-it8718f-v4-2.6.17.patch

If it looks OK, once again without --dry-run to actually apply the
patch.

-- 
Jean Delvare

