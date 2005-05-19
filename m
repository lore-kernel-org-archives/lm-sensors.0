From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU Fan on ASUS P4P800VM
Message-Id: <20050127224113.0c50dda7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501272214.14608.schopen@medienlabor.de>
In-Reply-To: <200501272214.14608.schopen@medienlabor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

> are there any known problems with the CPU Fan output and ASUS P4P800VM
> motherboards? I don't get any output (0 RPM). MB Temp and CPU Temp is
> fine.  I'm using kernel 2.6.2 on Debian/sarge. The following kernel
> modules are  loaded: i2c-i801, i2c-isa, eeprom, w83627hf init=0.

Have you tried "set fan2_div 8"?

-- 
Jean Delvare
http://khali.linux-fr.org/
