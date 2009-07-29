From: Nuzhna Pomoshch <nuzhna_pomoshch@yahoo.com>
Date: Wed, 29 Jul 2009 01:05:54 +0000
Subject: Re: [lm-sensors] Same problem, different form factor.
Message-Id: <60054.38187.qm@web111501.mail.gq1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
In-Reply-To: <537754.36624.qm@web111504.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

--- On Tue, 7/28/09, Jean Delvare <khali@linux-fr.org> wrote:

> > I expected (though it is obviously not guaranteed) to find the
> > sensors covered by the lm85 chip (as in the other Evo D510s).
> 
> But apparently this isn't the case. What form factor is the USDT?
> If it is a small thing, then maybe they had to cut on extra
> features to make it fit.

USDT stands for "Ultra Small DeskTop" (about the size of two fifteen
inch laptops stacked on top of each other). It does have limited
upgrade capabilities (no pci slots, for example), but I hoped that
it would still include hardware monitoring capabilities. :( Nice to
finally have an answer, though.

> Sorry but this looks like a dead end. I can push the patch
> upstream for SPD EEPROM access, but that's about it.

Thanks for that. Glad I could contribute something (however small).

Nuzhna


      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
