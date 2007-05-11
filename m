From: "Jan van Tiggelen" <den_tichel@zonnet.nl>
Date: Fri, 11 May 2007 18:49:17 +0000
Subject: Re: [lm-sensors] Fintek F71882FG Driver -> Problems with non EPoX
Message-Id: <000f01c793fd$142c8760$f401020a@223jvt>
List-Id: <lm-sensors.vger.kernel.org>
References: <000301c793d8$678c3790$20140a0a@EA002>
In-Reply-To: <000301c793d8$678c3790$20140a0a@EA002>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> It seems that the region is reserved for pnp, which cannot 
> be disabled in the bios. This seems to be the case on the
> 3 MSI mobo's. I don't know how to deal with this problem..

Do you have more details on the MSI mobo's? Type? BIOS version? And the
memory configuration (how many MB's / GB's)

Maybe the PAE - Physical Address Extension is messing up the memory-mapped
I/O on these mobo's. If that's the case, it's very likely that the only data
your driver gets is rubbish data.

PAE could reserve certain regions for PCI/pnp addressing. But normally that
only happens on 4Gb systems where the top 512Mb is reserved for PCI/pnp
addressing.

Looking forward to your reply

Kind regards,

Jan van Tiggelen


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
