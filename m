From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 14 Aug 2006 05:49:30 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060814074930.455d84cf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> On Sun, Aug 13, 2006 at 10:18:49AM +0200, Jean Delvare wrote:
> > It looks like the timestamps are not preserved by the snapshot
> > operation. Can it be improved?
> 
> Hm, that was how it was written, and that's how it ends if invoked
> manually. It looks like cron squashed my $HOME, where the subversion
> config variables are set, so I hardwired it into the scripts. Can you
> check on the next revision?

Timestamps are now properly preserved for regular files, but still not
for directories. Regular files are what I care mostly about anyway.

-- 
Jean Delvare

