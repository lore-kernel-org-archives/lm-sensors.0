From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: 2.6.3-mm4
Message-Id: <20040227004602.GB15075@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225185536.57b56716.akpm@osdl.org> <403E82D8.3030209@gmx.de> <20040225185536.57b56716.akpm@osdl.org> <20040227001115.GA2627@werewolf.able.es>
In-Reply-To: <403E82D8.3030209@gmx.de> <20040227001115.GA2627@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>, "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, sensors@stimpy.netroedge.com

On Fri, Feb 27, 2004 at 01:11:15AM +0100, J.A. Magallon wrote:
> 
> As somebody also stated, there are problems with sensors:
> 

On Fri, Feb 27, 2004 at 12:35:52AM +0100, Prakash K. Cheemplavam wrote:
> Hi,
> 
> this release made my sensors broken. With mm3 it worked nicely.

Yup, we changed all of the sensors sysfs names :)

Hey, we did warn everyone here on lkml we were going to do this, and no
one complained...

Anyway, I think all you need to do is get the cvs tree of the lmsensors
package.  Sensors people, the needed changes are commited into the tree,
right?

thanks,

greg k-h
