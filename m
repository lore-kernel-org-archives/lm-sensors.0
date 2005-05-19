From: pasky@ucw.cz (Petr Baudis)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <20050419225830.GH9305@pasky.ji.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com> <20050419222609.GE9305@pasky.ji.cz> <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>
Cc: Steven Cole <elenstev@mesatop.com>, Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Dear diary, on Wed, Apr 20, 2005 at 12:45:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" = Petr Baudis <pasky@ucw.cz> writes:
> 
> PB> I'm wondering if doing
> 
> PB> if [ "$(show-diff)" ]; then
> PB> 	git diff | git apply
> PB> else
> PB> 	checkout-cache -f -a
> PB> fi
> 
> PB> would actually buy us some time; or, how common is it for people to have
> PB> no local changes whatsoever, and whether relative slowdown of additional
> PB> show-diff to git diff would actually matter.
> 
> "show-diff -s" perhaps.  Also wouldn't it be faster to pipe
> show-diff output (not git diff output) to patch (not git apply)?

Excellent idea, thanks. Changed git merge to do this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
