From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Feb 2007 16:18:31 +0000
Subject: [lm-sensors] VT8237S - someone?
Message-Id: <20070204171831.2bc9bb45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Wed, 31 Jan 2007 00:21:06 +0100, Rudolf Marek wrote:
> I just spotted new PCI ID for VT8237 bridge. This version is called S.
> 
> 1106:3372: VT8237S PCI to ISA Bridge
> http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/via-ide-update.patch

This file no longer exists... but I guess the code is in the kernel
tree by now.

I've found this document on the VIA site, which mentions the VT8237S:
http://www.via.com.tw/en/downloads/presentations/events/vtf2006/VTF2006_HDP-VIA-WeberChuang.pdf

It looks to me like it's similar to the VT8237A but with SATA 2 support
(instead of SATA 1.) I guess it's safe to assume that the SMBus part
will be compatible with the VT8237R and VT8237A. Feel free to add the
ID to the i2c-viapro driver right away.

> Someone has it?

I don't, sorry.

-- 
Jean Delvare

