From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 09:24:14 +0000
Subject: Re: [lm-sensors] Any idea to support Fintek F71808A
Message-Id: <20110406112414.0c094afd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
In-Reply-To: <BANLkTinFxPuMEuM-ZOandTcnAwxeWKgx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Apr 2011 01:54:56 -0700, D.B. Tsai wrote:
> Hi
> 
> Since Fintek F71808E seems to be quick closed to F71808A, I copy

How can you tell? Similar numbers are no guarantee of compatibility.

> everything related to 71808E into F71808A in the f71882fg.c. The code
> can be compiled, but when I try to modprobe, I got the error message
> "FATAL: Error inserting f71882fg
> (/lib/modules/2.6.38-8-server/kernel/drivers/hwmon/f71882fg.ko):
> Device or resource busy
> "
> 
> Anything I should notice?

Read the kernel logs (dmesg | tail). Most likely ACPI requested the I/O
ports in question for its own use.

http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
