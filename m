From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: CPU temp does not update
Message-Id: <DsZ5PdIV.1106656106.6905960.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> Additionally, it may help you to know that if I put  my Mandrake 9.1
> installation into the same machine (I only have one computer - system hard
> drives are mounted in removable trays) sensors all work correctly within
> 9.1, this is using lm_sensors 2.7.0-2mdk and kernel 2.4.21-0.33mdk.

This is an extremely useful information, since it discards the
possibility of hardware failure or motherboard wiring oddity.

The w83627hf did not exist back then, so this means that you are using
the w83781d driver on your Mandrake 9.1. Can you please confirm?

The w83781d driver is still there in Linux 2.6 and should support your
W83697HF chipset just fine. On your Mandrake 10.1 system, please try
unloading the w83627hf driver and instead use the w83781d driver. Let us
know whether you observe the same problem with CPU temp or not. If
possible, restart your system so that the w83627hf is not even loaded,
in case it had a "permanent" (till next reboot) effect on the chip.

This test should let us know whether this is a driver issue (w83781d vs
w83627hf) or a version issue (lm_sensors 2.7.0 vs linux 2.6).

> > 4* Please provide a dump of the chip (isadump 0x295 0x296).
>
> # isadump 0x295 0x296

Ah, my bad. I should have asked for something slightly different:

isadump 0x295 0x296 1

(The "1" stands for Bank #1, where the CPU temp data resides.)

I would like you to run "sensors" right before isadump, so that I can
compare whether the temperature reported matches the register values or
not. If it matches, this is definitely a hardware configuration problem.
If not, the driver is obviously at fault.

In the meantime, I skimmed through the driver source code in search for
an obvious problem with temp2 on the W83697HF chip, but couldn't find
anything.

Thanks,
--
Jean Delvare
