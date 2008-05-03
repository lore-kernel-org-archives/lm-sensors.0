From: Ruzicka Pavel <pavouk@pavouk.org>
Date: Sat, 03 May 2008 11:02:05 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <200805031302.05982.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

It can be something other, because many boards have problem with this 
processor, because they have insufficient supply circuits.
This processor has 125W max power, and this is too much for many boards.
Yesterday my colleague bought this processor with board ASUS M3A-H/HDMI
and it still resets. When he put out one memory, it sometimes works.

Best regards,

Pavel Ruzicka

> I just ran sensors-detect on my phenom system (9850BE, Sapphire AM2RD790
> Board, 2x1GB Crucial Ballistix DDR2-6400). It froze during SMbus scan
> and now the cpu seems to be defect.
> The board stucks at C1 state during post, means it's a probem with the
> memory substytem.
> I tried the cpu in another board (M3A) and no post here also. The system
> works fine with an 9600BE so it's definately the cpu, whom died during
> the sensors-detect run.
>
> Greets
> achim~
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
