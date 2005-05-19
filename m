From: pasky@ucw.cz (Petr Baudis)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <20050419230233.GI9305@pasky.ji.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com> <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Dear diary, on Wed, Apr 20, 2005 at 12:38:17AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Just say no to patches. 

FYI, I've - per Junio's suggestion - made git merge's fast-forward to
apply show-diff output as a patch instead. This is roughly equal to
doing the sanity check against local changes, except that it handles
them, while at it. (Tree merge refuses to work when there are local
changes.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
