From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Chipset VIA686b and SYSFAN (PART 2)
Message-Id: <20030801091908.0239fc76.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2973E9.50304@gniinc.net>
In-Reply-To: <3F2973E9.50304@gniinc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I installed lm_sensor on a MSI MS-6368 board with the VIA686B
> chipset. LM_Sensors workk great (but he detected a via686a chipset.
> I don't know why).

This is a unified driver for both the VT82C686A and the VT82C686B.

> But, the P/S Fan doesn't work. I checked and I have the right value
> in my bios.  But, with lm_sensors... He display 9000RM the first
> time i type "sensors".  After, only 0.  I need to reboot the pc
> to get 9000 again.  So, do you have any idea (because the true
> value cannot be 9000 rpm and it's always at 0 anyway). The
> SYSFAN is in fact the fan of my power supply (enermax).

This could be a fan divisor issue. Read doc/chips/via868a and
doc/fan-divisors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
