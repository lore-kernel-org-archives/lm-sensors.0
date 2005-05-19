From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: FORCING CHIP DRIVER it87
Message-Id: <20050219180726.31aa9c32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

> I wrote because in the documentation of lm_sensors version 
> 2.8.8 the Kernel driver `it87.o' is indicated untested with 
> chip IT8712F. Also the driver should scan ISA-bus only for 
> address 0x290.
> 
> Have a look at the doc:
> IT8712F (untested)
>     Addresses scanned: I2C 0x20 - 0x2f (inclusive), ISA 
> 0x290 (8 I/O ports)

You're right, the documentation was outdated. I just updated it. Thanks
for reporting.

-- 
Jean Delvare
