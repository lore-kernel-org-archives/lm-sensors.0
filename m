From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 17 Feb 2006 02:29:13 +0000
Subject: [lm-sensors] clevo 470DW
Message-Id: <20060217022913.GA10369@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi James:

I've CC'ed the lm-sensors mailing list... please reply there (although
you may also continue to CC me).

* James <james at buffer.net> [2006-02-13 07:52:00 +0000]:
> Hello,
> 
> My laptop's lspci reveals:
> 
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] SiS645DX Host &
> Memory & AGP Controller (rev 01)
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI
> bridge (AGP)
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL
> Media IO] (rev 14)
> 00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
> 00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire
> Controller
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> 00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller
> (rev a0)
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
> Sound Controller (rev a0)
> 00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
> Controller (rev 0f)
> 00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
> Controller (rev 0f)
> 00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
> Controller (rev 0f)
> 00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
> 00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
> 00:0c.0 CardBus bridge: ENE Technology Inc CB1410 Cardbus Controller
> (rev 01)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
> [FireGL 9000] (rev 01)
> 
> 
> I'm running gentoo, 2.6.15.4 and having trouble getting lm_sensors to
> recognize
> chipsets that are know to be working. I'll be your tester, if you like?

What does sensors-detect say?  What "known to be working" chips do you have
that are not recognized?

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


