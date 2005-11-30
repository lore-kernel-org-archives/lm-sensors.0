From: gopher@singnet.com.sg (Terence Soh)
Date: Wed, 30 Nov 2005 03:34:55 +0000
Subject: [lm-sensors] RTC interface
Message-Id: <438D0F24.4050005@singnet.com.sg>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've some questions about RTC in I2C environment and I'm using rtc8564.c.

1) Do we update the linux date and time (not the RTC) in user space or 
kernel space?
2) If I update in the kernel, what are the appropriate functions for it?
3) If I update it in user space, which dev do I write/read to? 
Apparently /dev/rtc does not exist when I try to cat it.

Thanks,
Terence.
