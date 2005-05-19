From: rmk@arm.linux.org.uk (Russell King)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] i2c driver changes for 2.5.66
Message-Id: <20030325085821.B16443@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <10485563141404@kroah.com> <10485563161165@kroah.com> <20030325085505.A16443@flint.arm.linux.org.uk>
In-Reply-To: <20030325085505.A16443@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Mar 25, 2003 at 08:55:05AM +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Mar 25, 2003 at 08:55:05AM +0000, Russell King wrote:
> Are you sure that "IOC/IOMD" is a good name to stick in sysfs?
> s|/|,| would probably be a good idea.

Gah, ignore that comment.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
