From: Javier <javier@javispedro.com>
Date: Thu, 22 Mar 2012 14:17:55 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <CAJRRqzKHDBZPbe6W=tr_jBUj7cCckxJ_oXjeQQ2VLMfva4nAfw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2012/3/22 Luca Tettamanti <kronos.it@gmail.com>:
> Not really, I _suspect_ that there's a bug in the BIOS, but I wasn't
> able to confirm it; maybe it's something that the driver does.
> In the thread that you link Javier never replied with the results of the test.
> ...
> Furthermore the bug does not seem to affect all the users of that
> board, it may be BIOS and/or board revision dependent.

The interesting part is that a month or so after I reported my
experiences, the NVidia card on the machine failed and I replaced it
with a low end Radeon card. _The bug has not appeared  ever since._ So
I basically put the machine into service and forgot about the problem
(sorry!).

Due to the nature of the problem though, I wouldn't be sure to blame
NVidia -- but I guess the bug also depends on PCI configuration,
cards, etc.

I can try to get the machine back, figgle with PCIe cards and try to
reproduce the problem again, but this will be hard for me -- I need
the machine working ATM. Maybe during vacation.

Javier.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
