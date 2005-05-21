From: sensors@xanthein.net (Jon Still)
Date: Sat, 21 May 2005 10:13:27 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <Pine.LNX.4.56.0505210909270.19367@io.tertial.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
In-Reply-To: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 21 May 2005, Rudolf Marek wrote:

> Hmm that I strange. Please can you reboot without loading the module and
> do: cat /proc/ioports Thanks.

OK.  After rebooting I found that i2c_i801 and i2c_core were still being 
loaded, but that was all:

i2c_i801                8716  0
i2c_core               19200  1 i2c_i801

and ioports looks like:

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-0403 : PM1a_EVT_BLK
0404-0405 : PM1a_CNT_BLK
0408-040b : PM_TMR
0428-042f : GPE0_BLK
0500-051f : 0000:00:1f.3
  0500-0507 : i801-smbus
d000-dfff : PCI Bus #01
  d000-dfff : PCI Bus #02
    d000-d00f : 0000:02:01.0
      d000-d00f : 3w-xxxx
e000-e007 : 0000:00:02.0
e100-e11f : 0000:00:1d.0
  e100-e11f : uhci_hcd
e200-e21f : 0000:00:1d.1
  e200-e21f : uhci_hcd
e300-e31f : 0000:00:1d.2
  e300-e31f : uhci_hcd
e400-e41f : 0000:00:1d.3
  e400-e41f : uhci_hcd
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1

> Please can you try sensors-detect from CVS or from 2.9.1 version? We are thinking you have Winbond W83792D that is used for HW monitoring.
> You can find the driver in lm_sensors 2.9.1. The driver is currently ported to 2.6 so it is only avaiable for 2.4 kernels
> now.

Will do - I'll let you know.

Thanks once again!

Cheers,
Jon.

-- 
Jon Still                               E-mail: jon@tertial.org
tertial.org                             Web:    http://www.tertial.org/
GPG Key: http://xanthein.net/key.asc    Key ID: 0x00493D2B
