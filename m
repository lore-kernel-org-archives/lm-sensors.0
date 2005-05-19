From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: i2c/kernel i2c-core.c
Message-Id: <20030604070130.GA1763@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 03, 2003 at 10:27:38PM -0700, author@mordac.netroedge.com wrote:
> Update of /home/cvs/i2c/kernel
> In directory mordac.netroedge.com:/tmp/cvs-serv6861/kernel
> 
> Modified Files:
>       Tag: lk2-4
> 	i2c-core.c 
> Log Message:
> (mmh) Fixed a deadlock in i2c_check_addr().
> (mmh) The fix is harmonized to similar code in kernel 2.5.70.

So the 2.5 code is correct and doesn't need any changes?

Just trying to keep up :)

thanks,

greg k-h
