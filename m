From: snake8mynewt@yahoo.com (Ben Ridenhour)
Date: Sun, 18 Jun 2006 00:52:10 +0000
Subject: [lm-sensors] Help controlling CPU fans on Supermicro X5DPA-TGM
Message-Id: <4494A3BA.9040304@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I've been trying to tame the deafening roar that comes from my CPU
fans.  My motherboard is a Supermicro X5DPA-TGM with dual Xeons.  The
X5DPA-TGM reportedly has the Winbond w83627hf chip.  Everything (the
sensors, etc...) seem to work fine.  When I try using pwmconfig to setup
fancontrol I get:

Testing pwm control 9191-0290/pwm1 ...
  9191-0290/fan1_input ... speed was 4655 now 4655
    no correlation
  9191-0290/fan2_input ... speed was 4787 now 4821
    no correlation

No correlations were detected.

When I try to manually change the values of pwm1 or pwm2 in /sys, I get
no results either.  I am running kernel 2.6.16 (Gentoo sources, r9).

Any suggestions on how to make fancontrol work for this chipset?

Thanks in advance,
Ben


