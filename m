From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 19 Oct 2005 22:17:36 +0000
Subject: [lm-sensors] problem with ASUS P4S800
Message-Id: <4356A9D8.60009@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051008225453.GB11732@mathematik.uni-stuttgart.de>
In-Reply-To: <20051008225453.GB11732@mathematik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> recently I upgraded a machine with ASUS P4S800 board to kernel 2.6.12
> (from kernel 2.4.27). Before the upgrade lm-sensors detected and used
> the w83781d driver and works perfectly. After the upgrade
> lm-sensors-sensors suggested the w83627hf driver, but it does not work
> (No sensors found!). I also tried w83781d, but it didn't help. I am
> using the debian package 2.9.2-3 and a vanilla kernel from kernel.org.
> Who can help me?

What about ACPI PNP have you switched that ON? If so you must switch it off.
Try adding "pnpacpi=off" to the kernel command line, or switch in off when recompiling.
(this will be resolved in 2.4.14 or 15)

I hope this helps.

regards
Rudolf

