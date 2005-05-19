From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: ALI15X3_smb upgrade BIOS or use force_addr=0xaddr
Message-Id: <42002E72.5070808@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502020137.15626.lists@localguru.de>
In-Reply-To: <200502020137.15626.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

cat /proc/ioports
pick some unused address

Marcus Schopen wrote:
> Hi,
> 
> after going back from kernel 2.6.8 to 2.4.27 sensors-detect produces the 
> following output in my syslog:
> 
> Feb  2 01:22:09 vernon kernel: ALi Corporation M7101 PMU: ALI15X3_smb region 
> uninitialized - upgrade BIOS or use force_addr=0xaddr
> Feb  2 01:22:09 vernon kernel: ALi Corporation M7101 PMU: ALI15X3 not 
> detected, module not inserted.
> 
> I had no pronlems running kernel 2.6.8 with modules i2c-ali15x3 and lm75 on 
> the same machine (i568, 233 MMX). I have no idea how to figure out which 
> address range could be free.
> 
> Thanks
> Marcus
> 
> 
> 
> 
