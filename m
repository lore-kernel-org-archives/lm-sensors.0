From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 13 May 2011 21:33:52 +0000
Subject: Re: [lm-sensors] [RFC 2/5] gpio: add support for Technologic
Message-Id: <1305322106-sup-3383@v0nbox>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-3-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430111536.5cb49d59@lxorguk.ukuu.org.uk>
In-Reply-To: <20110430111536.5cb49d59@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jerome Oufella <jerome.oufella@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Excerpts from Alan Cox's message of sam avr 30 06:15:36 -0400 2011:
> > +    /* Enable IRQ generation */
> > +    mutex_lock(&drvdata->gpio_lock);
> > +    PORT_BIT_SET(0x7A, 7); /* DIO1_13 on IRQ7 */
> > +    PORT_BIT_SET(0x7D, 7); /* DIO2_13 on IRQ6 */
> > +    if (use_lcdio) {
> > +        PORT_BIT_CLEAR(0x7D, 4); /* Enable LCD header usage as DIO */
> > +        PORT_BIT_SET(0x7D, 6);   /* LCD_RS on IRQ1 */
> > +    }
> 
> What happens if an IRQ occurs at this point, you have no handler for it ?

The IRQ is just not handled. What would be the proper way to handle
that? Would it be possible to write those registers when the IRQ is
requested?

Thanks,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
