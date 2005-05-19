From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: [patch] it87: /proc/ioports fix
Message-Id: <20041215194329.GA10457@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041210142715.GA16622@nd47.coderock.org>
In-Reply-To: <20041210142715.GA16622@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 10, 2004 at 03:27:15PM +0100, Domen Puncer wrote:
> Hi.
> 
> Trivial patch against 2.6.10-rc3-bk2.
> When request_region is called name is set to "", use module name.
> 
> Signed-off-by: Domen Puncer <domen@coderock.org>

Applied, thanks.

Next time try to CC: me so I see these kinds of changes.

thanks,

greg k-h
