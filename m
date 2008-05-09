From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 May 2008 17:05:41 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080509190541.408024c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 09 May 2008 18:56:30 +0200, achim wrote:
> Am Freitag, den 09.05.2008, 17:24 +0200 schrieb Jean Delvare:
> > Hi Achim,
> 
> > I see this, and I think I understand why. The address exclusion logic
> > assumes that the original list contains _all_ addresses. This is no
> > longer the case. When I restricted sensors-detect to only probe
> > addresses where are least one hardware monitoring chip is known, I
> > forgot about this optimization which turned into a bug. Thanks for
> > reporting. This patch should fix it:
> > 
> > Can you please test it?
> > 
> > Thanks,
> 
> Yeah, the patch works. I tested sensors-detect with all known adresses
> of the board excluded and it did not messup the smbus chip.

OK, good. I'll commit this patch later today then.

> Afterward i tried it with only 0x4c excluded and the smbus chip still
> works. With no exclusions lm75 detection hangs at 0x4c and afterwards i
> only get XX's from dumps.

By "hangs" you mean it takes several seconds, or does it really stop?
Are you certain that it's the LM75 detection causing problem? We check
for no less than 33 different devices at address 0x4c...

Anyway, most certainly the problem is with word transactions on this
device you have at 0x4c. That won't be easy to work around, but I'll
take a look anyway, maybe I'll have an idea. If I do, I'll ask you -
again - to help with testing. Thanks *a lot* for all the help you are
providing in this respect.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
