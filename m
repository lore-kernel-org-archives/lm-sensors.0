From: meo@rru.com (Miles O'Neal)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: old Dell support
Message-Id: <200310110353.h9B3r6815801@hostname.rru.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a Dell PE2200 server at home I'd like lmsensor
support for.

I'm including output from "lspci" and "cat /proc/pci".
My PC hardware experience is limited, esp. at the
lower levels. 8^(

I'm guessing the host bridge is the only thing you
might support.  Any chance of such support?  Obviously
I can test. 8^)  We have just started using lmsensors
at work (~250 linnux systems, at least a dozen MBs);
we will be happy to pass along any results there as well.

Thanks,
Miles

-------------------------------------------------------------
foo:meo[174]>/sbin/lspci
00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:0f.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 05)
00:11.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:12.0 SCSI storage controller: Adaptec AIC-7880U
00:13.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 02)
00:14.0 VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev 40)
foo:meo[175]>cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 2).
      Master Capable.  Latency2.  
  Bus  0, device  15, function  0:
    Non-VGA unclassified device: Intel Corp. 82375EB (rev 5).
      Master Capable.  Latency$8.  
  Bus  0, device  17, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 9.
      Master Capable.  Latencyf.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfcffffff].
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 32 bit memory at 0xfdffe000 [0xfdffefff].
  Bus  0, device  18, function  0:
    SCSI storage controller: Adaptec AIC-7880U (rev 0).
      IRQ 15.
      Master Capable.  Latencyd.  Min Gnt=8.Max Lat=8.
      I/O at 0xf800 [0xf8ff].
      Non-prefetchable 32 bit memory at 0xfdfff000 [0xfdffffff].
  Bus  0, device  19, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 2).
      IRQ 11.
      Master Capable.  Latencyf.  Min Gnt=8.Max LatV.
      Prefetchable 32 bit memory at 0xfdffd000 [0xfdffdfff].
      I/O at 0xf0e0 [0xf0ff].
      Non-prefetchable 32 bit memory at 0xfde00000 [0xfdefffff].
  Bus  0, device  20, function  0:
    VGA compatible controller: ATI Technologies Inc 264VT [Mach64 VT] (rev 64).
      Prefetchable 32 bit memory at 0xf9000000 [0xf9ffffff].
      I/O at 0xf400 [0xf4ff].
