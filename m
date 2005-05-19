From: david-b@pacbell.net (David Brownell)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [patch 2.6.12-rc3+] i2c driver for TPS6501x
Message-Id: <200505051618.34980.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attached is a patch against a GIT snapshot from yesterday, adding
support for Texas Instruments TPS6501x power management chips(*).

These chips are used with a variety of OMAP boards including cell
phones, cameras, and more.  I don't think anyone's submitted drivers
for any similar chip yet; like the ones from FreeScale (for working
with Motorola based phones) or Dialog (for Intel PXA based ones).

This particular driver has been used in the Linux-OMAP tree for most
of the last year, accumulating updates as needed to support various
boards, and it seems now might be a good time to push it upstream.
(The current kernel already includes a header file with part of the
API exposed by this driver, FWIW.)

So -- please let me know about any problems you notice which you
think may need to be fixed before this merges.  (And I'm not on
the "sensors" list, so please CC me.)  I already know some boards
will need a hook to the report VBUS IRQ to non-OTG USB transceiver
drivers, but that can wait for a while.  :)

- Dave

(*) http://focus.ti.com/docs/prod/folders/print/tps65010.html
for more info.  Hmm, where did that tps65014 thing come from? 
It wasn't there last week, I swear!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: tps65010.patch
Type: text/x-diff
Size: 34681 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050505/53cba30d/tps65010.bin
