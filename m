From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [tzseller@geomant.com: ICH5 sensor]
Message-Id: <20031105194958.GA1871@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Zseller Tamas <tzseller@geomant.com> -----

Subject: ICH5 sensor
From: Zseller Tamas <tzseller@geomant.com>
To: frodol@dds.nl
Importance: High
X-Geo-MailScanner: Found to be clean
X-Geo-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.383,
	required 5, BAYES_00 -4.90, PRIORITY_NO_NAME 1.21,
	X_PRIORITY_HIGH 1.30)
X-Spam-Status: No, hits=2.6 required=5.0 tests=X_PRIORITY_HIGH,URI_IS_POUND version=2.20
X-Spam-Level: **

hi!
I installed the sensorsd package on my debian box with an intel 865
motherboard.

it says:
nicNG:/etc# lspci
00:00.0 Host bridge: Intel Corp. 82865G/PE/P Processor to I/O Controller
(rev 02)
00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated Graphics
Device (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
(rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller
(rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
01:08.0 Ethernet controller: Intel Corp.: Unknown device 1050 (rev 01)

---------------
82801EB SMBus... that's not supported by your software.

nicNG:/usr/share/doc/lm-sensors/doc/busses# sensors -v
sensors version 2.6.5

can you tell me, how is the support for this SMBus device?

thanks alot

 Tamas

-- 
  Zseller Tamas
  IT Consultant
   Geomant CCS
T: +36-30-4368542

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
