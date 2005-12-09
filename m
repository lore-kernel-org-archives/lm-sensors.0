From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Fri, 09 Dec 2005 12:26:23 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051209122623.GD6659@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Do we already know whether the problem is the SMI interrupt itself, or in
the BIOS (it crashes because there are other users of the chip), or in the
chip (it heavily opposes being accessed by two threads at once at
innoportune times)?

IMHO we can work around the problem without that information (which means no
more crashing, that's good), but we need to pinpoint the culprit to provide
the proper *fix*.

If it is a SMI interrupt problem, the correct fix is to teach linux to
handle SMI interrupts and have that generic code always enabled. This is
probable desireable anyway, if it is possible to do so.

IMHO if it is a chip/BIOS issue, the fix either belongs into lm-sensors
(chip specific: disable all interrupt sources if during startup we detect
that SMI interrupt generation is enabled) or to the quirks layer (machine:
disable SMI interrupts on this motherboard).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

