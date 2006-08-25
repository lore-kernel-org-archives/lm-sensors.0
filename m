From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 09:12:49 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <20060825111249.10c745bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Prakash,

> Hi, I chekced with my bios and the temps reading seems OK, but fans are off:
> 
> CPU: 780
> POWER: 777
> 
> wheres sensors reports too high values
> fan1:     1323 RPM  (min = 6490 RPM)                   ALARM
> fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> fan3:     1564 RPM  (min =    0 RPM)

So you are affected by the problem too...

What do you think are the correct values for your fans, the BIOS' ones,
or sensors' ones?

> Sometimes the reading goes totally crazy. I had times, where fan1 showed 
> values over 32000.
> 
> fan1:     46551 RPM  (min = 6490 RPM)                   ALARM
> fan2:        0 RPM  (min = 6490 RPM)                   ALARM
> fan3:     1551 RPM  (min =    0 RPM)

Very strange. Are you using fan speed control? This could induce some
noise in the speed sensing. Do you have similar effects when looking at
the values in the BIOS?

-- 
Jean Delvare

