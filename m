From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: Issue getting sis630 i2c smbus driver to work
Message-Id: <20040708050111.GB2579@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <14164-38866@sneakemail.com>
In-Reply-To: <14164-38866@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

* Geoffrey Hausheer <c479wy002@sneakemail.com> [2004-07-06 10:49:36 -0500]:
> 
> On Tue, 6 Jul 2004 10:59:16 +0200, "Alexander Malysh amalysh-at-web.de
> |lm-sensors/1.0-Allow|" <ii2ui0fae60t@sneakemail.com> said:
> > Hi,
> > 
> > please try attached patch...

(attached patch added SiS 1039:0018 to PCI device list of sis630.c)

> > Thanks!
> Thanks, this did indeed work, though when running sensors-detect, i get:
> Next adapter: SMBus SIS630 adapter at 5080 (Algorithm unavailiable)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x10

<snip>

Well, that's interesting all by itself.  Until now, I thought that 1039:0018
were always just mis-identified SiS 96x south bridges.  I've seen a SiS735
(single-chip north/south) identify itself as 1039:0735 & 1039:0018.  For that
system, the sis96x driver works fine.

In your case, Geoffrey, the 2.6 kernel PCI quirks routine still does the right
thing (or at least, it doesn't break anything I guess).  Trouble is, it tries
to write a particular bit in the PCI device config space that is probably not
appropriate... one that for 96x chipsets would enable the SMBus device.  I'm
not sure what to do about this.

Furthermore, what happens when the guy with 1039:0735/1039:0018 loads sis630?
That could be very bad.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
