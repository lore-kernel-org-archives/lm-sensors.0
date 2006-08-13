From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Sun, 13 Aug 2006 09:40:24 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060813094024.GA5540@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 13, 2006 at 10:18:49AM +0200, Jean Delvare wrote:
> > I've setup snapshots at
> > 
> > http://dl.lm-sensors.org/{lm-sensors,i2c}/snapshots/
> > 
> > They are checked daily, but only generated if there is an actual
> > change. I'm keeping the last 32 snapshots of both sub-projects.
> > 
> > I've manually initiated snapshots right now, and the scripts are
> > running at 06:00-06:10 CET
> > 
> > We can tune any parameter you like (cron frequency & time, URLs,
> > number of snapshots to keep etc).
> 
> It looks like the timestamps are not preserved by the snapshot
> operation. Can it be improved?

Hm, that was how it was written, and that's how it ends if invoked
manually. It looks like cron squashed my $HOME, where the subversion
config variables are set, so I hardwired it into the scripts. Can you
check on the next revision?
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060813/4d6e9b68/attachment.bin 
