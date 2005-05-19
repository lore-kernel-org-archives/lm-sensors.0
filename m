From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [rol@as2917.net: Need help for kernel 2.5.x ???]
Message-Id: <20030623025405.GA5913@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030622185659.GB2380@frodo.local>
In-Reply-To: <20030622185659.GB2380@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jun 22, 2003 at 08:56:59PM +0200, Frodo Looijaard wrote:
> ----- Forwarded message from Paul Rolland <rol@as2917.net> -----
> 
> From: Paul Rolland <rol@as2917.net>
> To: alla@lysator.liu.se, frodol@dds.nl, simon@tk.uni-linz.ac.at
> Cc: rol@as2917.net
> Subject: Need help for kernel 2.5.x ???
> Importance: Normal
> X-Spam-Status: No, hits=0.9 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK,SUBJ_HAS_Q_MARK version=2.20
> X-Spam-Level: 
> 
> Hello,
> 
> Homepage of lm-sensors states that you need help to migrate to kernel 2.5.x.
> I'm running 2.5.72, and i'd like to have lm-sensors running on my platform.
> 
> Thus, I'm ready to give a try helping you.
> 
> Problem is : it seems that no currently available version is to be used
> for kernel 2.5.

The version is already built into the 2.5 kernel.  So select the i2c
driver options in that kernel and see how well they work.

thanks,

greg k-h
