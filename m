From: michael@mmc-startup.com (Michael Weber)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: i2c-pcf-epp, i2c-algo-pcf, ticket 1622
Message-Id: <Pine.LNX.4.58.0403190505590.23358@unimatrix.mmc-startup.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear developers,

let me give you a short note about my project. I want to make an old
stage light equipment (24x dimmed lights) programmable. It's a highschool
theatre group, so the budget is very low. I don't want to use DMX.

I've built up a i2c controller with a PCF8584 wired to the printerport,
but mixed up the clock capabilities with another chip, so have to add an
oszillator.

The kernel patching compilation of the cvs i2c under debian with some
patches was trike and took me some compile time. So i've hacked
kernel/Module.mk to build and install i2c-pcf-epp.o, as usual. Now I can
mod the sources and the compilation of the modules takes 5 seconds.

I've found some problems and critical circumstances in i2c-pcf-epp and
fixed the irq freeing in case of  failed modprobe. Another point is a
wrong adress in a debug output (see ticket).

Can I contribute this and following improvements (i hope so) to your
code/cvs? I'm not used to cvs, so give me an hint.

thanks for your time

   Michael Weber

---

Michael Weber
MMC StartUP GbR

email: michael@mmc-startup.com
mobil: +49 171 5235201
