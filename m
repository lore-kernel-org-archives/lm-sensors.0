From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Wed, 30 Nov 2005 23:16:56 +0000
Subject: [lm-sensors] RTC interface
Message-Id: <20051130231656.7723b9d2@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <438D0F24.4050005@singnet.com.sg>
In-Reply-To: <438D0F24.4050005@singnet.com.sg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 30 Nov 2005 10:32:04 +0800
Terence Soh <gopher@singnet.com.sg> wrote:


> I've some questions about RTC in I2C environment and I'm using rtc8564.c.
> 
> 1) Do we update the linux date and time (not the RTC) in user space or 
> kernel space?
> 2) If I update in the kernel, what are the appropriate functions for it?
> 3) If I update it in user space, which dev do I write/read to? 
> Apparently /dev/rtc does not exist when I try to cat it.

 Hello,

  the kernel actually lacks a good support for i2c rtcs... which platform
 are you using it on?

 If it's ARM based , I can give you some hints.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

