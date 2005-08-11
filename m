From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 Aug 2005 13:46:55 +0000
Subject: [lm-sensors] Backport to 2.4 kernel of lm77 to use in wrap board
Message-Id: <NvhGd4Z6.1123760050.6311920.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42FA0A66.1050504@infovia.com.ar>
In-Reply-To: <42FA0A66.1050504@infovia.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Beat,

Please reply to the list rather than to me only.

> The problem is that if I to
>   modprobe scx200_acb in Linux 2.4
> the message
>   No such device
> comes
> If I try to use i2detect -a 1 etc. the messages
>   No such device
> comes also and i have created /dev/i2c-X
> Do I need other modules form the kernel than scx200_acb?
> I have a self compiled kernel
> This is in fact for SCX200 and not SC1100. Can I use it?

I really don't know. I never used such boards myself, and I probably
won't until someone decides to donate one.

Reading the original post from Andras Bali (who wrote the lm77 driver)
reveals that he was using the scx200_acb driver under Linux 2.6, but had
to change some values to get it to work:

http://lists.lm-sensors.org/pipermail/lm-sensors/2004-July/008163.html

Maybe you need to do the same changes to the 2.4 driver, and maybe even
more if the 2.6 driver is more up to date that the 2.4 driver.

Maybe Andras Bali would be able to help you as he seemed to know the
hardware very well.

--
Jean Delvare
