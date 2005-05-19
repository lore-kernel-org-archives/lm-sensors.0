From: davej@redhat.com (Dave Jones)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-Id: <20040218041734.GK6242@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218031544.GB26304@redhat.com> <20040218040153.GB6729@kroah.com>
In-Reply-To: <20040218040153.GB6729@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com

On Tue, Feb 17, 2004 at 08:01:54PM -0800, Greg KH wrote:

 > Oh nevermind, that's just a dumb driver.  It's doing a release_region on
 > memory it didn't get.  Stupid, stupid, stupid...
 > 
 > Dave can you verify that this patch fixes the problem for you?

yep, 1 rmmod bug down, 16 billion to go.

thanks for fixing this up.

		Dave
