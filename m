From: "Bart van Kuik" <lmsensors@vankuik.nl>
Date: Fri, 06 Jul 2007 07:38:31 +0000
Subject: [lm-sensors] Sensors working on DL360?
Message-Id: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi list,

I'm trying to get sensor readouts on a Compaq DL360 (not the later HP
branded ones, but the series with a Pentium 3). sensors-detect didn't
return any possible chipsets, but if you're interested, here's the output:

 http://www.vankuik.nl/download/Compaq_sensors-detect_readout

Output of lspci -v -v gives:

 00:04.0 System peripheral: Compaq Computer Corporation Advanced System
         Management Controller
         Subsystem: Compaq Computer Corporation Unknown device b0f3
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
                  ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
                 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 255
         Region 0: I/O ports at 1800 [disabled] [size%6]
         Region 1: Memory at c3ffef00 (32-bit, non-prefetchable) [size%6]

Output of ls-pci -n gives for this peripheral:
 00:04.0 0880: 0e11:a0f0

I've found references to a "Compaq health & Welness driver" but it's
binary and very old (pre 2.6). I'm running CentOS 5 (i.e. a RedHat AS
clone), kernel version 2.6.18 and lm_sensors 2.10.

Has anyone gotten this working?

Thanks,
Bart


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
