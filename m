From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 17 Nov 2013 16:50:25 +0000
Subject: Re: [lm-sensors] Asus Sabertooth AM3+ Rev 2.0 (PCIe 2.0)
Message-Id: <5288F3D1.9000305@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+evzr7W9ViYuu82eFuNutRPLnde-+QBDAq0e82a6GHM8qNPbg@mail.gmail.com>
In-Reply-To: <CA+evzr7W9ViYuu82eFuNutRPLnde-+QBDAq0e82a6GHM8qNPbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/17/2013 03:02 AM, Commander wrote:
> Seems like i get some wrong readings.
> output of sensors : http://codepad.org/KicD4Woq
>
> fam15h_power-pci-00c4:
> 6.75W
>
Looks ok for the current condition (cpu idle). No idea what is going on
if it never changes. Maybe Andreas can help.

> temp3:
> -128c
>
> These are constant values no matter what, are these readings hardcoded or
> is there something wrong?

temp3 is not connected; -128c readings are typical for such cases.

>
> Other than no labels the rest seems to be reported correctly (Other than

labels would require configuration in /etc/sensors3.conf.

Guenter

> low cpu temp in idle, but that's related to the chip from my investigation)
>
> Best Regards
> Artur O.
> Justice @ Freenode
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
