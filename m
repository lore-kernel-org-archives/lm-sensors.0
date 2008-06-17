From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 17 Jun 2008 23:10:34 +0000
Subject: Re: [lm-sensors] Intel D101GGC - No sensors found
Message-Id: <191fb4ca0806171610s21a17e4exb721c470162a9e2e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2c91a67a0806171239i45dd2322k975256a6ca22461e@mail.gmail.com>
In-Reply-To: <2c91a67a0806171239i45dd2322k975256a6ca22461e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

0x78 is a DME1737. Upgrade lm-sensors to 3.x and your kernel to at
least 2.6.23 to get support for the chip.

...juerg


On Tue, Jun 17, 2008 at 3:06 PM, Rudolf Marek <r.marek@assembler.cz> wrote:
> Hi,
>
> SMSC SCH5017 I/O  is your chip. Juerg?
>
> Thanks,
> Rudolf
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
