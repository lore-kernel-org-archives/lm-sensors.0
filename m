From: grimm@nickellson.com (Nick Ellson)
Date: Fri, 30 Jun 2006 21:36:24 +0000
Subject: [lm-sensors] What DOES work on SE7525GP2 with a PC87431 mBMC
Message-Id: <Pine.LNX.4.64.0606301425370.2698@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I said I would post what I get working...


uname -a

Linux gubbie 2.6.17-gentoo #6 SMP PREEMPT Fri Jun 30 09:51:47 PDT 2006 
i686 Intel(R) Xeon(TM) CPU 3.00GHz GNU/Linux


I used the OpenIPMI and patches for 2.6.17 from:

http://sourceforge.net/project/showfiles.php?group_id6127

and with the sensor command from OpenIPMI I finally get:

sensor: version 1.29
-- mBMC version 2.40, IPMI version 1.5
_ID_ SDR_Type_xx Sz Own Typ S_Num Sens_Description   Hex & Interp Reading
0001 SDR EvtO 03 15 20 01 snum 01 LAN Scrty        = 00 00 00 00 OK
0002 SDR EvtO 03 14 20 01 snum 02 Password         = 00 00 00 00 OK
0003 SDR EvtO 03 14 20 01 snum 03 PWRGOOD#         = 00 00 00 00 OK
0004 SDR EvtO 03 12 20 01 snum 04 Button           = 00 00 00 00 OK
0005 SDR EvtO 03 15 20 01 snum 05 Watchdog2        = 00 00 00 00 OK
0006 SDR EvtO 03 19 20 01 snum 06 SyS Boot Init    = 00 00 00 00 OK
0007 SDR EvtO 03 14 20 01 snum 07 Sys Evnt         = 00 00 00 00 OK
0008 SDR EvtO 03 17 20 01 snum 08 Pltfrm Evnt      = 00 00 00 00 OK
0009 SDR IPMB 12 17 dev: 20 00 07 01 PC87431 mBMC
000a SDR Full 01 33 20 02 snum 0a CPU1 12V         = c5 OK   12.31 Volts
000b SDR Full 01 39 20 02 snum 0c Baseboard 1.5V   = c1 OK   1.51 Volts
000c SDR Full 01 39 20 02 snum 0d Baseboard 2.5V   = bf OK   2.50 Volts
000d SDR Full 01 39 20 02 snum 0e Baseboard 3.3V   = c3 OK   3.35 Volts
000e SDR Full 01 39 20 02 snum 0f Baseboard 5.0V   = c3 OK   5.08 Volts
000f SDR Full 01 38 20 02 snum 10 Baseboard 12V    = c6 OK   12.37 Volts
0010 SDR Full 01 39 20 02 snum 11 Baseboard -12V   = 4c OK   -12.00 Volts
0011 SDR Full 01 32 20 02 snum 12 FSB Vtt          = c0 OK   1.20 Volts
0012 SDR Full 01 32 20 02 snum 13 MCH Vtt          = 00 OK   0.01 Volts
0013 SDR Full 01 36 20 01 snum 2a System Temp      = 1e OK   30.00 degrees 
C
0014 SDR Comp 02 2b 20 13 snum 23 Interrupt Button = 00 c0 00 00 OK
0015 SDR Comp 02 24 20 14 snum 24 ID Button        = 00 c0 00 00 OK
0016 SDR Comp 02 2b 20 07 snum 29 CPU Config Error = 00 c0 00 00 OK
0017 SDR FRU  11 13 dev: 01 00 07 01 HOST FRU
0018 SDR OEM  c0 13 manuf=Intel: SDR Package 1.30

and I have these modules loaded (I just crammed as many that would lod 
in... )

Module                  Size  Used by
ipmi_watchdog          20548  0
ipmi_devintf            9992  0
eeprom                  8080  0
ipmi_smb               17796  0
i2c_algo_pcf            7684  0
i2c_algo_pca            7044  0
i2c_dev                10244  0
i2c_isa                 5888  0
ipmi_msghandler        39360  3 ipmi_watchdog,ipmi_devintf,ipmi_smb
i2c_i801               10672  0


And I guess lm-sensors can't use this? When I do a i2cdetect 0 now, the 
0x42 location shows up as UU instead of XX and sensor-detect says to 
unload any clients using it.

Hope this helps folks :)

Nick


-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


