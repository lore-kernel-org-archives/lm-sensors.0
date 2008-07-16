From: "Simon Depiets" <sdepiets@gmail.com>
Date: Wed, 16 Jul 2008 12:53:20 +0000
Subject: [lm-sensors] Aspire One Intel Atom's Motherboard support
Message-Id: <f4897e880807160553h3d8dacdfy20efdddfc8c4b476@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
 I've been recently offered an Acer Aspire One netbook and I wish to
control the fanspeed manualy
 I installed the lastest version of lm-sensors (3.0.2), when typing
  $ sensors
     i get
  No sensors found!

This could be normal, so I did a
  $ sudo ./sensors-detect
      and the program wants to load the module
  `i2c-i801`
   I don't have such a module, but i have i2c-dev loaded, is i2c-i801
different, mandatory ? How do I add it (I'm not a kernel building
"fan"-boy yet sorry :p)

 My /proc/acpi/fan folder is empty, so it seems acpi support by my
kernel is just partial (acpi_listen detects battery status io)

Here are my
 - lsmod :  http://www.mmo-tools.com/acpi/lsmod.txt
 - lspci : http://www.mmo-tools.com/acpi/lspci.txt
 - modinfo i2c-dev : http://www.mmo-tools.com/acpi/modinfo_i2c-dev.txt
 - modprobe coretemp (is this a mandatory module ?) :
http://www.mmo-tools.com/acpi/modprobe_coretemp.txt
 - sudo ./sensors-detect-stat.pl
http://www.mmo-tools.com/acpi/sensors-detect-stat.txt

I'm looking forward for you help
Thanks a lot and sorry for my poor frenglish
-- 
Lliane aka Simon Depiets
Epita Promo 2011,42
Chip-Leader on http://www.lliane.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
