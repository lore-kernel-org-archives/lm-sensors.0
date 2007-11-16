From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Fri, 16 Nov 2007 00:59:37 +0000
Subject: Re: [lm-sensors] PWMconfig problem with Asus P5B Deluxe / Winbond
Message-Id: <4dfa50520711151659v3c2ab50keb41caf63dd8d6a6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
In-Reply-To: <4dfa50520711142226r2e6d1c3fy229e05d4ca43d032@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

> Oh. That's fine. This reminds me for the ASUS Q-Fan (BIOS setting)
> modes. There you have Performance, Optimal and Silent.
>
> It would be good if pwmconfig could tell one that ones chip have such a
> automatic. Than I don't see any need for a software controller ala
> fancontrol. In such a case pwmconfig should write a startup script which
> sets the right enable mode and that's it.

That is actually the default (BIOS supplied) setting for your
w83627dhg. Therefore, all you need to do is never load the w83627ehf
module. Or, if you do load the module, use sensors to read the values
but do not run pwmconfig. I suppose pwmconfig sort of assumes you know
about the modes on your chip and therefore, you're running the script
to configure it in depth, manually, etc.

Anyway, thanks for the feedback! I'll work on that patch at some point....

Cheers,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
