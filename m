From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: Bugzilla
Message-Id: <20050307172124.GA8726@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <3Xg1uAGB.1110214165.5308430.khali@localhost>
In-Reply-To: <3Xg1uAGB.1110214165.5308430.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Mon, Mar 07, 2005 at 05:49:25PM +0100, Jean Delvare wrote:
> Any news about the new bugzilla installation for lm_sensors support
> management? I'd like it to be in place as soon as possible. Ideally we
> would switch to it before the old system reaches ticket #2000.
> 
> Would it be possible to tell Bugzilla to start at ticket #2000? That way
> the new tickets wouldn't overlap with the older ones.

Yes, that's possible.

Is other than that the bugzilla instance OK?

> If possible, we could later import older tickets into the new base, but I
> admit I have no idea how to do that and it's not my priority at the
> moment.

Phil had made some thinking on that, as long as there is a semantic
mapping, this should be possible. It would become a problem if some
mandatory fields of the new system (like component) would have to be
derived from the bug's contents.

Let me know what to do. I'll be leaving for the CeBIT tomorrow, and
won't be able to do much until its end (mid next week).

> We will also need to prevent the creation of new tickets on the old base
> as soon as the switching is done.
> 
> Thanks.
> 
> PS: Any objection to me deleting doc/developers/readticket and editticket
> from lm_sensors CVS? Seems to be made obsolete by the new search page on
> the website, and will not work anymore once we have moved to Bugzilla
> anyway. (As a side question, does anyone really still use netscape??)
> 

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050307/ced182d0/attachment.bin
