From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <20030323084950.GL26145@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048295082521@kroah.com> <1048295084971@kroah.com> <20030322023351.GB2050@vana.vc.cvut.cz>
In-Reply-To: <20030322023351.GB2050@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Sat, Mar 22, 2003 at 03:33:51AM +0100, Petr Vandrovec wrote:
> 
> Although you'll not break matroxfb more than it is currently, can you
> also update drivers/video/matrox/{i2c-matroxfb,matroxfb_maven}.* in 
> your updates? Or I'll send you patch after this change hits Linus kernel... 

Yeah, that stuff doesn't compile at all :)

I added a patch for the i2c related stuff to my tree that I just sent
out.

thanks for pointing it out.

greg k-h
