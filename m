From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2007 16:05:23 +0000
Subject: Re: [lm-sensors] [patch 1/1] de-macro w83627hf
Message-Id: <20071012180523.5f44ddee@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
In-Reply-To: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Thu, 11 Oct 2007 17:37:31 -0600, Jim Cromie wrote:
> Im attaching an incremental patch (on top of Mark's),
> assuming that this is easiest.

Either way is fine, Mark and myself can deal with patch iterations just
fine.

> If you want it against hwmon-testing (with change-entry, diffstat, signoff)
> or you want the extraneous 'if(' fix removed, let me know.

Indeed the extraneous 'if(' fix doesn't really belong there. I
mentioned the other one only because you were already touching that
line, so it was "free", but in general cleanups shouldn't be mixed with
real changes.

I'll prepare a merged patch with this one change reverted for Mark.
Thanks for your contribution!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
