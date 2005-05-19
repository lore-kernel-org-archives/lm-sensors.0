From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <20040623213614.2c1669de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well,  Appended to this message is the current version of the
> fancontrol script that I am happily using.  It uses POSIX::_exit()
> to avoid the double-call to the END block, plus it logs STDOUT and
> STDERR to different logfiles.
> (...)
> Also appended is an /etc/init.d/fancontrol init script that I'm
> using on a Fedora Core 1 based system.  It should work on most
> later-version (IE RedHat 9 through FC2) RedHat-based distros.  It
> doesn't handle start-when-the-daemon-is-already-running quite
> correctly but I haven't gotten around to fixing that yet.

OK, I updated our CVS repository with both files.

Please send patches against whatever we happen to have under CVS if you
have further changes to any script.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
