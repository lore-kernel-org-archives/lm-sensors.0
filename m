From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: i want to help
Message-Id: <20030217180111.A1509@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.VMS.3.91-2 (vms).1030217122257.20709A-100000@cs.felk.cvut.cz>
In-Reply-To: <Pine.VMS.3.91-2 (vms).1030217122257.20709A-100000@cs.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Rudolf Marek <MAREKR2@cs.felk.cvut.cz> [2003-02-17 12:27:10 +0100]:
> 
> I got SiS 745, chipset and I want you to help you developing the SMBUS 
> (I2C) driver for it.
> 
> I can C, assembly and I'm ready to test it on my hardware.

Have a look at kernel/busses/i2c-sis645.c and/or .../i2c-sis630.c.  See
if you can get either of those to work.  Without a datasheet, it might
be impossible.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
