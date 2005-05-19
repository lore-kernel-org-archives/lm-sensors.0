From: torvalds@osdl.org (Linus Torvalds)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
In-Reply-To: <20050419194728.GA24367@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> Ok, if you want some practice with "real" merges, feel free to merge from
> the following two trees whenever you are ready:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
> for 11 aoe bugfix patches, and:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> for 13 driver core, sysfs, and debugfs fixes.

Done, pushed out. Can you verify that the end result looks sane to you? I 
just cheched that the diffstat looks similar (mine claims just 108 lines 
changed in aoecmd.c - possibly due to different diff formats).

And yes, my new merge thing seems to have kept the index-cache much better 
up-to-date, allowing an optimized checkout-cache -f -a to work and only 
get the new files.

Pasky? Can you check my latest git stuff, notably read-tree.c and the 
changes to git-pull-script?

		Linus
