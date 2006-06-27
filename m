From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 27 Jun 2006 10:20:55 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060627102055.GG4718@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 26, 2006 at 09:56:08PM +0200, Jean Delvare wrote:
> For releases, it would make more sense to have a "static" download
> area, like we had on the old site:
> http://secure.netroedge.com/~lm78/archive/
> So that we can also sign the archives. Can we have such a download area
> on the new site?

I created

http://dl.lm-sensors.org/{lm-sensors,i2c}/{release,snapshot}

and synced over the contents of
http://secure.netroedge.com/~lm78/archive/

Maybe you'd like to restructure a bit, it's all under
/srv/lm-sensors/dl and owned by yourself. I would maybe move some
older releases in an old folder or similar.

I'll return on the subject of snapshots in another mail.

> It would also be convenient if we could have a "Download" link it
> trac's top bar, as this is clearly one of the most popular page. Is it
> possible? I'm surprised there isn't one by default.

That seems to be a bit difficult and is currently advised against
since it may conflict with upgrades

http://projects.edgewall.com/trac/wiki/TracInterfaceCustomization#MainTemplates

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060627/930f5fa2/attachment.bin 
