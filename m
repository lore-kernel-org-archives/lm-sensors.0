From: khali@linux-fr.org (Khali)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: Compile problem when EISA support is removed from the .config file
Message-Id: <20021010085018.2E41240F0F@kraid.nerim.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200210100836.01d7@th00.opsion.fr>
In-Reply-To: <200210100836.01d7@th00.opsion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My motherboard does have any isa slot, so i had remove the support of
> the isa inside the make menuconfig program but without installing a new
> kernel.

You have no ISA slot, but it means in no way that you don't have an ISA *bus*. Indeed, all motherboards I know still have an ISA bus, and lm_sensors makes use of it.

> After doing a "make mrproper", the make of lm_sensors complain about the
> miss of the /usr/src/linux/.config file.

We need to know what is supported by your kernel and what isn't, and this information is found in this file. Note that this supposes that this config file matches the kernel you are running, which is not your case if I read you carefully.

-- 
Khali


___________________________________
Webmail Nerim, http://www.nerim.net/

