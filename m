From: jbs@bandos.homelinux.com (Jose Bernardo Silva)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: Ticket #1351
Message-Id: <20030730164316.M47742@bandos.homelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since you ask in ticket 1350 if the user had enabled acpi in the kernel, and
referenced 1351 to 1350, I just wanted to inform I am using acpi (latest
patch), and have it enabled on the kernel. But that didn't change when I
switched from i2c/lm_sensors 2.7.0 to 2.8.0. Btw, expanding ticket 1351, in
2.7.0, adm1021 worked using the isa bus, now it doesn't seem to work even with
i2c-isa loaded.

---
Jose Bernardo B R Silva             | Source Mage GNU/Linux Section Guru
jbernardo@sourcemage.org            | http://www.sourcemage.org
http://counter.li.org #245602
http://cosmos.oninetspeed.pt/jose.bernardo
jbs@bandos.homelinux.com
