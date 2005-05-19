From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <20030924180512.GF10443@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 23, 2003 at 11:22:36PM +0200, Jean Delvare wrote:
> 
> 2* Should we provide a init=0 parameter? I think yes. Should it be the
> default? Not too sure. (But actually, some things *need* to be
> initialized, while some others do not need to. Especially, temperature
> and voltage limits belong to userspace, as it has already been
> discussed). Greg, what's your policy in 2.6 (if you have one)?

I don't have one, yet.  Haven't thought that much about it.  Any good
proposals for one?

thanks,

greg k-h
