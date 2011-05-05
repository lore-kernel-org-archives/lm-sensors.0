From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 05 May 2011 13:38:37 +0000
Subject: Re: [lm-sensors] [RFC 1/5] platform-drivers-x86: add support for
Message-Id: <20110505143837.7790edd5@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
	<1304115712-5299-2-git-send-email-vivien.didelot@savoirfairelinux.com>
	<20110430110705.5ca3376b@lxorguk.ukuu.org.uk>
	<1304520382-sup-3361@sfl>
	<20110504162954.7ecf5b5e@lxorguk.ukuu.org.uk>
	<1304537667-sup-2171@sfl>
In-Reply-To: <1304537667-sup-2171@sfl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonas Fonseca <jonas.fonseca@savoirfairelinux.com>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

> I've looked at that, and the board doesn't support DMI. Elements we have
> are the processor (i.e. AMD ElanSC520), the BIOS, maybe the memory and
> PCI bus layouts...

Well the CPU is a big help that cuts it down a lot. PCI bridge
subvendor/dev can be a good way to identify boards as well if they
manufacturers have actually bothered to set them properly.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
