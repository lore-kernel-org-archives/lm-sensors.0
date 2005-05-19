From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <20030813015611.5906ecf8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(Message received 12 times, what happened?)

> Thanks Jean I grabbed your CVS snapshot and compiled it. Worked fine!

Great.

> # prog/sensors/sensors -A lm83-i2c-0-19
> lm83-i2c-0-19
> temp1:       +36?C  (limit = +100?C, critical = +120?C)   
> temp2:       +35?C  (limit = +100?C, critical = +120?C)   
> temp3:       +42?C  (limit = +100?C, critical = +120?C)   
> temp4:       +44?C  (limit = +100?C, critical = +120?C)   

Could you try setting some limits (through the config file or manually,
using "echo 110 > /proc/sys/dev/sensors/lm83-i2c-0-19/tcrit" for
example)? I'd like to know if changing limits works OK. Also, please try
setting limits (both high and critical) below the actual readings. It
should trigger various alarms, that show in the alarms file, and when
running sensors too (even more readable).

WARNING: according to the LM83 datasheet, a critical alarm could result
in a system shutdown. It's not as explicitely said for high limits, but
there could be some hardware triggering there too (I'd simply expect
beeping and/or fans starting or speeding up). Playing with high limits
is probably less dangerous than playing with tcrit. Anyway, if you can't
take the risk, don't try setting limits to stupid values. I can't guess
how your motherboard is wired.

If you still want to help, there is a safe way to do the tests. The
possible effects of alarms can be disabled. The driver doesn't allow
that yet (not sure it should anyway) but there's another way.

1* Disable the alarms effects:
i2cset 0 0x19 0x09 0xbc b

2* Play with limits and see how sensors react.

3* Reset limits to correct values.

4* Enable the alarms effects again:
i2cset 0 0x19 0x09 0x00 b

I think this solution is safe. However, if you don't feel like playing
with fire, just don't.

> Here is the output from dmidecode:
> # dmidecode   
> # dmidecode 1.8
> BIOS32 Service Directory present.
>         Calling Interface Address: 0x000F0010
> PCI Interrupt Routing 1.0 present.
>         Table Size: 288 bytes
>         Router ID: 00:0f.0
>         Exclusive IRQs: None
>         Compatible Router: 1166:0201
> PNP 1.0 present.
>         Event Notification: Not Supported
>         Real Mode Code Address: F000:4932
>         Real Mode Data Address: F000:0000
>         Protected Mode Code Address: 0x000F495A
>         Protected Mode Data Address: 0x000F0000

Old version of dmidecode. No DMI table anyway, so it doesn't really
matter. We won't learn about this motherboard that way.

Thanks!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
