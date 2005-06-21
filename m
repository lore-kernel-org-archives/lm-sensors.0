From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Jun 2005 15:27:40 +0000
Subject: [lm-sensors] temp1,temp2 calculation in w83781d.c
Message-Id: <2Aab4pK2.1119360186.1634200.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05062100266adaab51@mail.gmail.com>
In-Reply-To: <2ef564dc05062100266adaab51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sukhdeep,

On 2005-06-21, Sukhdeep Johar wrote:
> I see the temp1 being read as :
>           val*10
> where val is the value read from the register.
>
> While temp2 is read as :
>          (val/128) *5
> where val is a two byte value read from the registers.
> I understand the reason behind the division by 128.
>
> But am not able to understand the multiplication by 5 & 10.

The temp1 value is read from the chip with LSB = 1 degree C, and it
happens that the driver exports the value with a magnitude of 1 (LSB 0.1 degree C). The multiplication by 10 converts from LSB=1 to LSB=0.1.
We could as well have exported the value with a magnitude of 0, this
would have saved the multiplcation. I can't tell why it was done that
way.

The temp2 value is read from the chip with LSB = 0.5 degree C, and is
exported with a magnitude of 1, so again LSB = 0.1 degree C, thus the
multiplication by 5.

The magnitude is returned by the callback functions (e.g. w83781d_temp)
when called with operation = SENSORS_PROC_REAL_INFO, so you can check
them.

Note that all this was completely reworked in Linux 2.6. All temperatures
are now reported with a magnitude of 3 (resolution of 0.001 degree C),
so the conversions are different there. If you are trying to figure our
how hardware monitoring drivers work, I'd suggest that you don't waste
your time with 2.4 code and learn from 2.6 directly.

Hope that helps,
--
Jean Delvare
