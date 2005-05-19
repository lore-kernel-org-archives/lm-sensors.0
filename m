From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: A question when test W83792D driver on another motherboard
Message-Id: <zdrsq3q0.1109842572.9108670.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190C6C@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> If you have more suggestion about this problem, please tell us, I'd like
> to try it here.

I don't, sorry. The information provided by Asus (write an arbitrary
value to an arbitrary port) isn't sufficient for us to understand what
happens. We would need detailed information on what chip we attept to
control at this port and how that chip works, and also details on how
the SMBus is wired. Without that information, I just cannot tell why the
SMBus works first and then suddenly fails.

> Btw, Is there any guys who are going to backport the i2c-ali1563.c from
> linux-2.6 to linux-2.4? We still can not run 792 driver on another
> motherboard with the Ali M1563 chipset. If there is some evolution on it,
> please tell us.

I was in the hope that Patrick Mochel could help you on this. I really
don't know much about SMBus master drivers, so I can't help myself,
sorry.

--
Jean Delvare
