From: gimeshell@web.de (gimeshell at web.de)
Date: Sat, 17 Jun 2006 01:51:48 +0000
Subject: [lm-sensors] Intel 82801BA ICH2 worked some time ago
Message-Id: <20060617035148.028910a2.gimeshell@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

some time ago i used lm-sensors to monitor cpu temperature. That worked
so far. Now, perhaps one year later, i'm using Debian/sensors 2.9.1 but
i get totally shifted CPU temperature:

M/B Temp:    +33?C  (high =  +105?C, hyst =    +0?C)          
CPU Temp:   +5.2?C  (high =   +50?C, hyst =   +46?C) 

I have loaded modules i2c_i810 and w83781d.

Here is cut lspci output:

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 02)

Does anybody have an advice?

regards,
gimeshell

