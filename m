From: mross@rs-net.org (Ross Skaliotis)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: ADM1027 not detected on Tyan S5112
Message-Id: <Pine.LNX.4.44.0406192201110.20866-100000@mail.internal.brightstareng.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.0406171051020.30199-100000@mail.internal.brightstareng.com>
In-Reply-To: <Pine.LNX.4.44.0406171051020.30199-100000@mail.internal.brightstareng.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bingo. The newer kernel did indeed have support for my 6300ESB smbus.
2.6.6 I was using didn't. I upgraded and all is good. I can see my 
ADM1027 now.

Thanks!!

-Ross

>> 0000:00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
>>         Subsystem: Intel Corp.: Unknown device 25a9
>>         Flags: medium devsel, IRQ 17
>>         I/O ports at 0500 [size2]
>
>Here it is.
>
>Sensors-detect knows about this bus since 2.8.7. The version you are
>using (2.8.6) doesn't know it. That's not really a problem since you can
>still load the required driver manually.
>
>The driver for it is i2c-i801. It has support for your chip since
>2.6.7-rc1. Depending on your distribution, your kernel (2.6.6) may be a
>real 2.6.6 or a disguised 2.6.7-rcX, so you may take your chance and try
>to load i2c-i801 manually before running sensors-detect. If it doesn't
>help, then you'll definitely need a kernel upgrade before you can access
>the bus and then the ADM1027 chip on it.
>
>--
>Jean Delvare
>http://khali.linux-fr.org/
