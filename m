From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-Id: <20040505221804.GE29885@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040403191023.08f60ff1.khali@linux-fr.org> <20040403202042.GA3898@sirius.home> <20040409173158.GC15820@kroah.com> <20040410165832.08e0c80d.khali@linux-fr.org> <20040417145309.4831f2b6.khali@linux-fr.org> <20040502220632.06cefb60.khali@linux-fr.org>
In-Reply-To: <20040502220632.06cefb60.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>

On Sun, May 02, 2004 at 10:06:32PM +0200, Jean Delvare wrote:
> 
> Greg, please apply if it looks good to you. Sorry for introducing the
> leak in the first place...

Looks a bit odd, but ok.

Applied, thanks.

greg k-h
