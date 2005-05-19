From: pasky@ucw.cz (Petr Baudis)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <20050419223945.GG9305@pasky.ji.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Dear diary, on Tue, Apr 19, 2005 at 10:20:47PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Pasky? Can you check my latest git stuff, notably read-tree.c and the 
> changes to git-pull-script?

I've made git merge to use read-tree -m, HTH.

I will probably not buy git-export, though. (That is, it is merged, but
I won't make git frontend for it.) My "git export" already does
something different, but more importantly, "git patch" of mine already
does effectively the same thing as you do, just for a single patch; so I
will probably just extend it to do it for an (a,b] range of patches.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
