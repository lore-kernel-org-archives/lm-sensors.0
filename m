From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: DevFS and i2c
Message-Id: <20030601174511.GA25876@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054477965.3646.5.camel@MAIN.hypernation.net>
In-Reply-To: <1054477965.3646.5.camel@MAIN.hypernation.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 01, 2003 at 04:32:45PM +0200, Sander@hypernation.net wrote:
> Hi,
> 
> Im trying to build the cvs checkout of 01-06-2003 of the i2c project.
> This build is supposed to be for 2.5.x kernel series. Im trying to build
> in on 2.5.70-mm2 kernel release.

No, please use the in-kernel version of the i2c code, not the cvs tree.
The cvs tree will not work in 2.5.

Hope this helps,

greg k-h
