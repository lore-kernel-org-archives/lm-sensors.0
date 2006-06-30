From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Fri, 30 Jun 2006 11:50:35 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060630115035.GF26375@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 30, 2006 at 01:37:25PM +0200, Jean Delvare wrote:
> Hi Axel,
> 
> > Mike sent me the plugin with instructions and it's installed
> > now. There is a menu button "Downloads" that links to
> > dl.lm-sensors.org. It works as advertized :=)
> 
> What I had in mind was rather a link to wiki/Download, then we remove
> that link from our own "Starting points" menu. There are a few hints we
> want people to read before they download.

Ah, OK.

> Can this be done? (And, for my own culture, where is it configured?)

Yes, it can (just did). If you can read german I'll forward you Mike's
instructions. Even if not, it's very intuitive and it's all within
trac.ini:

[components]
navadd.* = enabled

[navadd]
add_items = download
download.title = Download
download.url = /wiki/Download
download.target = mainnav

So it can easily be further extended if/when you wish so.

> Thanks Mike :)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060630/555eb548/attachment.bin 
