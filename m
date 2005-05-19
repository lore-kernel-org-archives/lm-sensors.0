From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Bugzilla
Message-Id: <20050515193411.GI4435@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <3Xg1uAGB.1110214165.5308430.khali@localhost>
In-Reply-To: <3Xg1uAGB.1110214165.5308430.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 15, 2005 at 09:26:47PM +0200, Jean Delvare wrote:
> Hi Axel,
> 
> > it's lm-sensors day for me ;)
> 
> Who would complain :)
> 
> > I made it start at #1900, so you can still play a bit with it. When
> > you give the go, I'll bump it up to 2000.
> 
> We're already at #1987 in the old base. Make it 2200 to be sure.
> 
> > bugzilla supports "products" and "components" (per product). The
> > "version" filed is attached to the products.
> > 
> > We could have one product (lm_sensors) and have the current products
> > become "components". Currently components were going to be assigned to
> > drivers etc.
> 
> Sounds better, but what about the drivers? Can there be subcomponents?

No there are only two levels. If you have a singleton product, you are
left with one only.

> The Linux kernel bugzilla has categories and components.

That's the same as products and components. They only replaced
"products" in the html pages with "categories" in thir customized
bugzilla, but if you query for a "category" you will see
http://bugzilla.kernel.org/buglist.cgi?...&product=...

> No other comments, rest is fine with me.

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050515/1efc6b6e/attachment.bin
