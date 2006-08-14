From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Mon, 14 Aug 2006 06:00:04 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060814060004.GA21873@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Mon, Aug 14, 2006 at 07:49:30AM +0200, Jean Delvare wrote:
> > On Sun, Aug 13, 2006 at 10:18:49AM +0200, Jean Delvare wrote:
> > > It looks like the timestamps are not preserved by the snapshot
> > > operation. Can it be improved?
> > 
> > Hm, that was how it was written, and that's how it ends if invoked
> > manually. It looks like cron squashed my $HOME, where the subversion
> > config variables are set, so I hardwired it into the scripts. Can you
> > check on the next revision?
> 
> Timestamps are now properly preserved for regular files, but still not
> for directories. Regular files are what I care mostly about anyway.

I'm not even sure svn stores folder timestamps at all.

Just FYI the flag to use to have svn co use the real timestamps of
files is use-commit-times under [miscellany] in ~/.subversion/config.

[You should think about switching it on on your own checkouts or not,
 as it may break your make building. See info automake cvs ("26.1.2
 Background: CVS and timestamps"). Though that's not an issue for
 creating tarballs, only for continuous updates/commits work cycles.]

But I didn't find any switch to manipulate folder timestamps on
checkouts/updates.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060814/2dd39899/attachment.bin 
