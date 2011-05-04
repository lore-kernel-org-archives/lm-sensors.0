From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 04 May 2011 15:15:50 +0000
Subject: Re: [lm-sensors] [RFC 1/5] platform-drivers-x86: add support for
Message-Id: <1304520382-sup-3361@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
In-Reply-To: <20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Excerpts from Alan Cox's message of 2011-04-30 06:07:05 -0400:
> > +
> > +/**
> > + * ts_sbcinfo_detect() - detect the TS board
> > + * @sbcinfo:        structure where to store the detected board's info.
> > + */
> > +static int ts_sbcinfo_detect(struct ts5xxx_sbcinfo *sbcinfo)
> > +{
> > +    u8 temp;
> > +    struct ts_sbc_config *sbc;
> > +    int ret = 0;
> > +
> > +    memset(sbcinfo, 0, sizeof(*sbcinfo));
> > +
> > +    if (!request_region(IOADDR_SBCID, 4, "TS-SBC"))
> > +        return -EBUSY;
> > +
> > +    temp = inb(IOADDR_SBCID);
> > +    /* If it is a 3x00 SBC only match against the first 3 bits */
> > +    if (temp & 0x07)
> > +        temp &= 0x07;
> 
> So if this is compiled into a kernel we blindly inb this address and some
> platform just crashed on boot. Is this board like other embedded ones in
> that there is some safe way to check if its such a board first ?
> 

It is possible to make a BIOS call (Int 15h / Function B000h) to get
board information, like the manufacturer ("TS"). It should be a safer
way to check if we are on a Technologic Systems board. a intcall(0x15,
&ireg, &oreg) should do the trick to check the platform, before checking
the SBC ID. What do you think?

Thanks,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
