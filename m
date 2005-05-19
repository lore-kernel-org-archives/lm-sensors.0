From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: SiS 651 chipset
Message-Id: <Pine.LNX.4.58.0412022102570.2569@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101917532.31169.8.camel@localhost>
In-Reply-To: <1101917532.31169.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

Sorry for late answer.

> I was browsing your "Supported chipsets"[1] page and saw that my SiS 651
> computer should have the i2c-sis645 kernel-module, but my kernel-sources
> (2.6.9) only have i2c-sis96x.

yes i2c-sis645 is for 2.4 kernels. In 2.6 it is merged to i2c-sis96x

Mark can you confirm please and fix the table ? (Tnx)

> Final question would be:
> Does my kernel lack the recommended module or is the "Supported
> chipsets"-page out of sync?

Sync.

> Also, what would the best way be to use the sensors on this kind of
> motherboard?
> Right now I'm using i2c-isa and it87 (it87-isa-0290).

Sorry I cant see any name/brand here.

On SMBus you will see perhaps only small EEPROMs located on RAM modules.
Nothing iterresting (from HW monitoring point of view)

If any more questions, feel free to write.

Regards

Rudolf
