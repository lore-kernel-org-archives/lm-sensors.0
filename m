From: p.wautelet@fractalzone.be (Philippe Wautelet)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <3F2E9EBB.3040600@fractalzone.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

For the BIOS, I have is the latest version. Therefore, this is not the 
solution.

I also tried the new 2.6.0-test2 kernel and I got some improvements : 
now it detects the SMBus but it says it is disabled.

Here is the output of lspci -vv:

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin B routed to IRQ 10
    Region 4: I/O ports at 1000 [disabled] [size2]

The IRQ is 10 which is the same as the Firewire and the CardBus 
controllers. However, I didn't compile Firewire and CardBus in the 
kernel. Therefore, I don't think it is an IRQ conflict.

-- 
Philippe Wautelet
Research assistant,
Aerodynamics Group, University of Liege, Belgium, http://www.ulg.ac.be/aerodyn
Private website: http://www.fractalzone.be

