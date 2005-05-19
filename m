From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: LM90 compatibles
Message-Id: <20030830225934.352b8b94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F50D95D.3050507@paradyne.com>
In-Reply-To: <3F50D95D.3050507@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > as we've noted on our new drivers page there are Maxim and
> > > Analog Devices chips that appear to be compatible with the
> > > LM90. Do you plan to add support for those to your lm90
> > > driver?
> > 
> > I plan to do so on request. I don't want to add support for chipsets
> > that nobody has or that even don't exist on any computer
> > motherboard, that's why I'm waiting for requests before adding
> > support.
> > 
> > Maybe I should change the new drivers page to reflect that?
> > 
> > Also, I could add detection for these chips to sensors-detect (the
> > same way we have detection for the LM82, LM86 and LM89 although we
> > don't have driver support for those either). Do you want me do to
> > so?
>
> IIRC these chips were almost identical, if so, then they are equally
> likely to be on boards. One way to get testers is to claim support :)
> So I'd add support to both sensors-detect and the driver but up to
> you.

Being likely to be there does not them be actually there. I simply don't
want to add support "just in case" and make the driver bigger and
possibly more complex for nothing. (What's more doing this cleanly would
require me to read the data sheets for the four/five other chipsets, and
I don't have time for that at the moment.)

I added detection for the ADM1032, MAX6657 and MAX6658 in
sensors-detect. That way, if anyone has one and wants support for it, I
believe we should be told about it. I also made the message clearer so
that people understand they have to ask.

BTW, these three chips have no known die revision codes, which makes
their detection possibly unreliable. I've sent a support request on
Maxim's website but admit not to expect too much from it. I also mailed
Mary Burke at Analog Devices, maybe she'll be able to provide the
revision code values for the ADM1032.

I am now updating the new drivers page.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
