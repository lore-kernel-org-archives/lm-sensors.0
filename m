From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Mon, 29 May 2006 15:09:02 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060529150902.GA19225@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Mon, May 29, 2006 at 02:04:17PM +0200, Jean Delvare wrote:
> There seems to be some trashing with non-ASCII characters? :/

CVS has no metainformation about encoding of logs. It can be latin1 or
anything else. The grep I performed was on a utf-8 system.

> I'm fine with removing only amalysh, Frodo, khali, mds, mmh, phil and
> ruik (all case insensitive) and to exclude binary files. However, if
> you don't feel confident, just ignore my request. It's just not that
> important so if you think there is any risk, don't do it.

I made a conversion, please have a look. i2c and lm-sensors are
separated and could indeed have different commit rights as you once
suggested.

The "(author)" bits haven't been touched, I'll retry with the list you
gave. Also we need to discuss how to deal with svn and trac write
access. The idea is to use htdigest for both and not the ssh
accounts. This is because trac doesn't deal with ssh account data and
the account information could be shared between trac and svn (at least
partly). But it also depends on how you'd like to have authorization
handled in lm-sensors vs i2c.

Please don't commit any changes to the svn repo before we settle the
authorization/authentication issues.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060529/a33ad952/attachment.bin
