From: "Thierry Bothorel" <thierry.bothorel@gmail.com>
Date: Thu, 20 Nov 2008 23:39:14 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <c91b81610811201539j15729100i4349ca92693b899@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2008/11/20 Luca Tettamanti <kronos.it@gmail.com>:

> I totally missed the original thread, but this gives me a good excuse
> to jump on this issue again :)
> Asus boards have two different ACPI interfaces for hwmon:
> - an old one (based on RVLT/RFAN/RTMP)
> - a new one (GGRP/GITM)
> Both may be present but there a few cases (my board, sigh) where the
> new interface is just an empty stub.
> I've rewritten my old ATK driver for the third time so that it works
> with both interfaces (and this time I _really_ intend to push it
> upstream); currently I'm not 100% sure of the output of the new
> interface (the user that originally contacted me is not responsive...)
> but the code is almost complete.
> Thierry are you willing to test this _experimental_ driver?
>
> Luca
>
Yes but you will have to tell me how, i'm not an "expert".

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
