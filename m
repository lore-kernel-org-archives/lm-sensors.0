From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: driver for mic184 chip
Message-Id: <41FAB35E.1050208@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please find attached the source file (gzip=4k, native.3k) for a 
mic184 sensor. We have an older driver for the 2.4.2x kernel but it 
doesn't completely match what your are asking for. I ported it to kernel 
2.6.9 using your guides, modified i/o to match what you have requested, 
and have tested to work on our hardware configuration. Please let me 
know of any changes that need to be made and when it might incorporated 
into the standard kernel distribution as we will be moving forward.

I am also working on drivers for ad5321, pca9540, adm1030, and x24165 
(all for kernel 2.6.9). We also use DS18B20 and DS2401 one wire devices 
that I am trying to get working on a ISA bus (through a CPLD). If you 
are interested in these let me know and I will forward them to you when 
they are working.

Thanks
Frank Beesley
frank.beesley@aeroflex.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: mic184.c.gz
Type: application/x-gzip
Size: 3964 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050128/08c6ca9e/mic184.c.gz
