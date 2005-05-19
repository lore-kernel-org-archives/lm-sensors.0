From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Add ported sensor chip driver: asb100
Message-Id: <20040114190802.GC6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040106051203.GK30841@earth.solarsys.private>
In-Reply-To: <20040106051203.GK30841@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 06, 2004 at 12:12:03AM -0500, Mark M. Hoffman wrote:
> Hi Greg,
> 
> Please queue this up, hopefully for 2.6.1.
> 
> OBTW: OK to *not* copy LKML when I send you patches?
> Since they're visible when you send them up to Linus
> it seems redundant...
> 
> * * * * *
> 
> This patch adds support for the ASB100 Bach sensor chip, which
> is found on some Asus mainboards.  The port corresponds to
> lm_sensors CVS revision 1.5.  The patch applies to and was tested
> against 2.6.1-rc1.

Applied, thanks.

greg k-h
