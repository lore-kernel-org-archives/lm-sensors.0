From: azarah@gentoo.org (Martin Schlemmer)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH 2.5] PCI quirk for SMBus bridge on Asus P4 boards
Message-Id: <1048146514.12350.43.camel@workshop.saharact.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319211837.GA23651@brodo.de>
In-Reply-To: <20030319211837.GA23651@brodo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dominik Brodowski <linux@brodo.de>
Cc: alan@lxorguk.ukuu.org.uk, KML <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com

On Wed, 2003-03-19 at 23:18, Dominik Brodowski wrote:
> Asus hides the SMBus PCI bridge within the ICH2 or ICH4 southbridge on
> Asus P4B/P4PE mainboards. The attached patch adds a quirk to re-enable the
> SMBus PCI bridge for P4B533 and P4PE mainboards.
> 

The ASUS P4T533-C J(850E Chipset) does that as well .... think you might
tweak the patch for this board ?  I can test if you can ....


Regards,

-- 
Martin Schlemmer

