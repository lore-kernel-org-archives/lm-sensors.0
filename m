From: sesshoumaru@altern.org (Sesshoumaru)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: SMbus problem ?
Message-Id: <20030604002007.30058e3e.sesshoumaru@altern.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030602222815.14c7b37f.sesshoumaru@altern.org>
In-Reply-To: <20030602222815.14c7b37f.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 3 Jun 2003 08:41:38 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> This is a known problem. Pick the fixed Makefile there:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/Makefile
> That should do it. If not, please checkout both i2c CVS (branch lk2-4)
> and lm_sensors2 CVS, that should work too.

Ok thanks, the Makefile works well but the script for the devices
files didn't work.

All the modules failed to load with sensors-detect same the PCI bus
adapters.
However my motherboard is recognized :
 BIOS vendor (ACPI): Nvidia
 System vendor (DMI): ASUSTeK Computer INC.
 BIOS version (DMI): ASUS A7N8X-X ACPI BIOS Rev 1004

(chipset: nvidi nforce2).

Regards
 Sesshoumaru
-- 
La modestie est au m?rite ce que les ombres 
sont aux figures dans un tableau: elle lui 
donne de la force et du relief.
