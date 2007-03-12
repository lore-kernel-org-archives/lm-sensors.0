From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Mon, 12 Mar 2007 11:21:43 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <20070312112143.GL6176@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 12, 2007 at 11:12:36AM +0100, Jean Delvare wrote:
> Hi Axel, Hans, all,
> 
> On Sun, 11 Mar 2007 21:28:46 +0100, Axel Thimm wrote:
> > On Sun, Mar 11, 2007 at 08:53:43PM +0100, Hans de Goede wrote:
> > > Agreed, thinking about this some more I'm not so sure that dropping 2.4 
> > > support is a good idea as there is still plenty of 2.4 usage out there. 
> > 
> > I would second keeping 2.4 support if it's not too much pain.

> Come on, I'm tired of all this whining each time we say that we want
> to drop 2.4 support.  [...] The drop of 2.4 support is a fact
> already. We are no longer writing new drivers for 2.4, and when 2.4
> drivers are backported by others (w83627ehf, smsc47m192) we don't
> have the time to review them anyway.

> > But if 2.4 support is slowing down things and developer resources
> > want to concentrate on 2.6 it will have to go sooner or later.
> 
> That's the case exactly. We hardly have time to keep up with the new
> drivers for 2.6 and all the infrastrcuture changes that are long
> overdue.

I'm instantly redrawing my just-nice-to-have-if-its-no-pain request. :)

Many thanks for keeping this project up and fresh! I agree that if
RHEL3 consumers are interested then they should be able to throw in
resources. But that's not going to happen.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070312/fdbf2e30/attachment.bin 
