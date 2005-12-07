From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 07 Dec 2005 11:08:28 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051207110828.GA9487@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 07 Dec 2005, Daniel Nilsson wrote:
> The BIOS logs the events and does fan controls based on the interrupts of
> w83792. But BIOS always enables interrupt of W83792 even when miniBMC is
> disabled because BIOS needs it for fan controls.

Maybe I am asking something too stupid, but what would happen if there is a
race condition between the linux kernel and the BIOS APM code and both try
to access the chip at the same time?  A Linux kernel spinlock won't protect
the chip against rogue hardware access by the BIOS, unless that GPIO
interrupt is disabled in the South Bridge.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

