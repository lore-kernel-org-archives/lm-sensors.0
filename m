From: Commander <commander.alchemy@gmail.com>
Date: Sun, 24 Nov 2013 19:24:00 +0000
Subject: Re: [lm-sensors] Asus Sabertooth AM3+ Rev 2.0 (PCIe 2.0)
Message-Id: <CA+evzr6W3vOm50v4M3yaNk5+bvYvtnNhcyg7A-xkY7CCraJEDg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+evzr7W9ViYuu82eFuNutRPLnde-+QBDAq0e82a6GHM8qNPbg@mail.gmail.com>
In-Reply-To: <CA+evzr7W9ViYuu82eFuNutRPLnde-+QBDAq0e82a6GHM8qNPbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kernel:
Stock 3.12 arch kernel and
3.12.1-2-ck x86_64


CPU:
AMD Piledriver 8350
procinfo : http://codepad.org/8pkr7VCf

Best Regards




On Tue, Nov 19, 2013 at 4:32 PM, Andreas Herrmann <
herrmann.der.user@googlemail.com> wrote:

> On Sun, Nov 17, 2013 at 08:50:25AM -0800, Guenter Roeck wrote:
> > On 11/17/2013 03:02 AM, Commander wrote:
> > >Seems like i get some wrong readings.
> > >output of sensors : http://codepad.org/KicD4Woq
> > >
> > >fam15h_power-pci-00c4:
> > >6.75W
> > >
> > Looks ok for the current condition (cpu idle). No idea what is going on
> > if it never changes. Maybe Andreas can help.
>
> If it is not changing (CPU under full load vs. idle) then something is
> wrong. Hard to say what.
>
> What kernel version is this (uname -a)?
> What CPU are you using (cat /proc/cpuinfo)?
>
>
> Andreas
>



-- 
//Commander
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
