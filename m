From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 12 Apr 2014 06:38:44 +0000
Subject: Re: [lm-sensors] MCP68 SE not listed
Message-Id: <20140412083844.26677a89@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <14733-1396967453-397931@sneakemail.com>
In-Reply-To: <14733-1396967453-397931@sneakemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Again: please don't drop the list in the middle of the discussion.

On Wed, 9 Apr 2014 20:43:12 +0200, Lucas Malor wrote:
> On 9 April 2014 09:15, Jean Delvare wrote:
> > Actually I can't find any reference to an MCP68 in the PCI IDs
> > database. What makes you think this chip exists in the first place and
> > that your board doesn't just have an MCP61?
> 
> In its manual, page 17, or 1-7:
> http://dlcdnet.asus.com/pub/ASUS/mb/socketAM3/M4N68T-M_LE_V2/E5971_M4N68t-m_Series_manual.zip

OK, I've added a mention to the MCP68 SE in the wiki.

> (...)
> Ok, so it's all functioning. I thought there was some problem with the
> drivers, but they are two really different sensors. I think that
> anyway is good to monitor k10temp values too. Thank you very much for
> the help :)

You're welcome.

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
