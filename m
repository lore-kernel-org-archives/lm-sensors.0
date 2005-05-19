From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: SMBus device access
Message-Id: <1094810411.26391.757.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!
I am trying to access a SMBus device that is supposed to be connected to
SMBus.
The hardware uses a SiS96x chipset SMBus controller and the SiS SMBus
driver loads fine, SMBus is detected properly.

My SMBus device is supposed to listen to address 0x92 which is quite
obviously a 10-bit address. The device is a custom programmed PIC
controller that controls a small display. By writing byte values to the
PIC it will display something on the display.

All my tries failed so far. I have to admit that I only tried a
userspace approach, i.e. through i2c-dev.

Everything I get is "Operation not permitted".

My test application is attached if anyone wants to have a look at the
nonsense I am trying ;)

I have looked the kernel i2c drivers up and down and cannot find any
hint why the write call fails, especially with the above error.

Oh yes, I am using a vanilla 2.6.7 kernel, i.e. no additional patches
applied.

Any hint is greatly appreciated since I am quite desperate by now.

Many thanks in advance!

Regards
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pictest.c
Type: text/x-csrc
Size: 1467 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040910/435b7e91/pictest.bin
