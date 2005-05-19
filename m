From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU Fan on ASUS P4P800VM
Message-Id: <200501272327.25663.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501272214.14608.schopen@medienlabor.de>
In-Reply-To: <200501272214.14608.schopen@medienlabor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thursday 27 January 2005 22:41, Jean Delvare wrote:
> Hi Marcus,
>
> > are there any known problems with the CPU Fan output and ASUS P4P800VM
> > motherboards? I don't get any output (0 RPM). MB Temp and CPU Temp is
> > fine.  I'm using kernel 2.6.2 on Debian/sarge. The following kernel
> > modules are  loaded: i2c-i801, i2c-isa, eeprom, w83627hf init=0.
>
> Have you tried "set fan2_div 8"?

jiippppppppppiiii! Now the output is fine :) This line should be part of 
doc/chips/w83627hf.

Thanks,
Marcus
