From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 27 Jun 2006 10:59:35 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060627105935.GJ4718@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 27, 2006 at 12:32:41PM +0200, Michael Renzmann wrote:
> > I'll return on the subject of snapshots in another mail.
> 
> If it helps I can provide a bash script that we use at madwifi.org for
> generating snapshots once a day (see [1]). Snapshot tarballs are only
> generated if there were changes since the last generated tarball. The
> script is kept as general as possible and makes use of "configuration
> files", so it's easy to reuse it for generating snapshots of more than one
> repository and/or several directory trees in one repository.

Thanks, again, I think we're done in this part.

But looking at [1] I think we should sync the snapshot naming to what
madwifi is using (rev before date), it makes more sense. OK, done. :)

> [1] http://snapshots.madwifi.org
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060627/094edb36/attachment.bin 
