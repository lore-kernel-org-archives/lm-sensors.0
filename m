From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 11 May 2011 22:24:44 +0000
Subject: Re: [lm-sensors] [RFC 1/5] platform-drivers-x86: add support for
Message-Id: <1305150634-sup-4695@v0nbox>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com> <1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com> <20110430110705.5ca3376b@lxorguk.ukuu.org.uk> <1304520382-sup-3361@sfl> <20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk> <1304537667-sup-2171@sfl> <20110505143837.7790edd5@lxorguk.ukuu.org.uk>
In-Reply-To: <20110505143837.7790edd5@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Excerpts from Alan Cox's message of jeu mai 05 09:38:37 -0400 2011:
> > I've looked at that, and the board doesn't support DMI. Elements we have
> > are the processor (i.e. AMD ElanSC520), the BIOS, maybe the memory and
> > PCI bus layouts...
> 
> Well the CPU is a big help that cuts it down a lot. PCI bridge
> subvendor/dev can be a good way to identify boards as well if they
> manufacturers have actually bothered to set them properly.

In a first step, I now check the CPU and the Ethernet chip which are
relevant devices of TS-5xxx boards. The only problem comes from the
TS-5300 board which has a different Ethernet chip, using the ISA bus.
I can't find other relevant device information about this board. So, is
the CPU detection (AMD Elan SC520) enough? Or should I add a module
parameter to specify the board model and avoid this pre-detection?

Thanks,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
