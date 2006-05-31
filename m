From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 31 May 2006 12:26:20 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060531142620.681c1d62.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark, Hans,

> > > * Hans de Goede <j.w.r.degoede at hhs.nl> [2006-05-30 12:36:22 +0200]:
> > > > They will, one cannot assume a internet connection and even if one
> > > > assumes an internet connection, phoning home applications are evil!
> 
> * Jean Delvare <khali at linux-fr.org> [2006-05-30 14:32:33 +0200]:
> > One could argue that a 4 MB database on my hard disk drive, when I need
> > a single 3 kB file out of it, is evil. I have no problem with
> > applications phoning home as long as they ask me before. For systems
> > with no internet connection, people can download the file from the web
> > and copy it manually.
> 
> A 4MB database is well into the noise for most distributions.  For any
> that actually care, it should be easy to package the data separately.

Another advantage of the online approach is that data for new boards
can be added on a daily basis. I don't expect distributions to update
the database after the initial installation. So it might still make
sense to either integrate a database update mechanism in the user-space
tool, or at least to fallback on querying the online database directly
if the local database doesn't know anything about the motherboard.

-- 
Jean Delvare

