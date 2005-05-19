From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: SiS 651 chipset
Message-Id: <20041204013252.GF7903@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101917532.31169.8.camel@localhost>
In-Reply-To: <1101917532.31169.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Patrik Kullman <patrik@yes.nu> [2004-12-01 17:12:12 +0100]:
> > I was browsing your "Supported chipsets"[1] page and saw that my SiS 651
> > computer should have the i2c-sis645 kernel-module, but my kernel-sources
> > (2.6.9) only have i2c-sis96x.

* Rudolf Marek <R.Marek@sh.cvut.cz> [2004-12-02 21:12:36 +0100]:
> yes i2c-sis645 is for 2.4 kernels. In 2.6 it is merged to i2c-sis96x

This is because the SMBus device lives on the 96x south bridge.  The original
name (i2c-sis645) was a mistake (because SiS does not release datasheets).
Patrik, if you have a SiS651 you must also have a 96x south bridge.

> Mark can you confirm please and fix the table ? (Tnx)

I can try (again) to make it more clear. :)

> > Final question would be:
> > Does my kernel lack the recommended module or is the "Supported
> > chipsets"-page out of sync?
> 
> Sync.

Actually, neither.  The web page was not exactly intuitive though.

Patrik: would you mind sending me the results of a recent version
of sensors-detect?  (BTW: in your case, it should give different
results depending on the version of the kernel you are presently
running - 2.4.x or 2.6.x.)  That should be the authoritative answer,
anyway.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
