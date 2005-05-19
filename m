From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH 2.6] asb100 bug
Message-Id: <20040412232338.GE26817@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040411040439.GA17920@earth.solarsys.private>
In-Reply-To: <20040411040439.GA17920@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Apr 11, 2004 at 12:04:39AM -0400, Mark M. Hoffman wrote:
> Hi nymisi, Greg:
> 
> * Nyeste Mih?ly <nymisi@freemail.hu> [2004-01-27 16:02:04 +0100]:
> > Hi!
> > 
> > I reported a bug of asb100 chip at: 
> > http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket39
> > 
> > The reply was the follow:
> > 
> > "Is there a BIOS option you can disable, e.g. Asus "COP",
> > "QFAN", or some such?  My guess is that the BIOS is
> > somehow interfering with the asb100 driver.  Otherwise
> > I don?t know how this could happen.
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Yeah, I wrote that.
> 
> "You do that, you go to the box, you know.  Two minutes by
> yourself, and you feel shame, you know." - Denis the goalie
> 
> Greg, please apply this fix (vs. 2.6.5):

Heh, applied, thanks.

greg k-h
