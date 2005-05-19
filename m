From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: [PATCH 2.6] More verbose debug in w83781d detection
Message-Id: <20040914175413.GC27024@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040912115802.3c6dc0c7.khali@linux-fr.org>
In-Reply-To: <20040912115802.3c6dc0c7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 12, 2004 at 11:58:02AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> Quoting myself:
> 
> > As for me, I will propose my extra-debug patch (slightly cleaned up)
> > for inclusion into the 2.6 kernel. It helped us once, so it could
> > prove to be valuable in the future as well.
> 
> Here is the patch. It makes the w83781d (mis)detection more verbose so
> as to help debugging problems. The extra messages of course only show
> when I2C chip debugging is enabled. It additionally features some code
> refactoring, some CodingStyle cleanups and adds a missing white space in
> one debug message.
> 
> Please apply,

Applied, thanks.

greg k-h
