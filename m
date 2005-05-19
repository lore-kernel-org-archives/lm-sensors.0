From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-Id: <20040507223412.GH14660@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040505221804.GE29885@kroah.com> <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
In-Reply-To: <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>

On Fri, May 07, 2004 at 02:42:17PM +0200, Jean Delvare wrote:
> 
> >> Greg, please apply if it looks good to you. Sorry for introducing the
> >> leak in the first place...
> >
> >Looks a bit odd, but ok.
> 
> Odd? Why that? If you can think of something better, just tell me.

No, I couldn't, it's just strange looking code :)

thanks,

greg k-h
