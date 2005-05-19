From: linux@brodo.de (Dominik Brodowski)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] Sensors chip w83781d for linux-2.5.6[45] (follow up on PCI quirk for SMBus bridge on Asus P4
Message-Id: <20030323090152.GA1113@brodo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319211837.GA23651@brodo.de> <1048146514.12350.43.camel@workshop.saharact.lan> <20030320084148.GA2414@brodo.de> <20030322131503.254c2aa7.azarah@gentoo.org>
In-Reply-To: <20030322131503.254c2aa7.azarah@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk, sensors@stimpy.netroedge.com

On Sat, Mar 22, 2003 at 01:15:03PM +0200, Martin Schlemmer wrote:
> Hi
> 
> After I had this P4T533-C's SMBus enabled again on 2.5 kernel with
> Dominik's patch, I thought it will be a good time to try and get
> lm_sensors to work again.
> 
> I did not have much luck with a CVS snapshot of lm_sensors2 though,
> so I hacked 2.5.64bk12 to include the w83781d module.  Yes, it is
> rather hackish, but it seems to work just fine.

works fine over here, AFAICT. thanks!

	Dominik
