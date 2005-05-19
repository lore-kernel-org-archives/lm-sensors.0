From: yswamy@iternalinc.com (yswamy)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: sensors -f gives always temperature  33.8F ??
Message-Id: <3CF4EB8D.50201@iternalinc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have Intel 82371AB PIIX4(E), 443MX, ServerWorks OSB4/CSB5, compatable 
i have addedd this one as built on to the kernel. And also lm75 as built 
in to the kernel. when i boot the m/c it recognizes the chip.

I am using linux-2.4.18 kernel using lm_sensors-2.6.3 patch.

But muy sensors -f

output is always like this:-

lm75-i2c-0-4e
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
temp:     +33.8?F   (limit = +34?F, hysteresis = +34?F)


Even though i increased the CPU temperature using some assembly 
programs. By doing this i burnt one of CPU still i could'nt get the 
temperature of the CPU different than above so can u please give me more 
info?

I try to compute values in sensors.conf but for lm75 it looks like it 
does'nt work properly,

with Best Regards
Yeri Swamy Lalgondar
