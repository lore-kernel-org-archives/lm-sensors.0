From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 04 May 2011 20:34:33 +0000
Subject: Re: [lm-sensors] [RFC 1/5] platform-drivers-x86: add support for
Message-Id: <1304537667-sup-2171@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430110705.5ca3376b@lxorguk.ukuu.org.uk> <1304520382-sup-3361@sfl> <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
In-Reply-To: <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Excerpts from Alan Cox's message of 2011-05-04 11:29:54 -0400:
> > It is possible to make a BIOS call (Int 15h / Function B000h) to get
> > board information, like the manufacturer ("TS"). It should be a safer
> > way to check if we are on a Technologic Systems board. a intcall(0x15,
> > &ireg, &oreg) should do the trick to check the platform, before checking
> > the SBC ID. What do you think?
> 
> And that goes to 'How you do yo know it's safe to call INT 15 0xB000 -
> especially as we are in 32bit mode and the BIOS is 16bit so you have to
> call it very early meaning its a great way to make something else not
> boot.
> 
> Does the board not support anything sane like DMI ?
> 
> Alan

I've looked at that, and the board doesn't support DMI. Elements we have
are the processor (i.e. AMD ElanSC520), the BIOS, maybe the memory and
PCI bus layouts...

Have you got another idea how to get information in a safe way?

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
