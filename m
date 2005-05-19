From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] Fix SCx200 dependancies
Message-Id: <20031230200545.GB3163@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031224173043.4904eaf2.khali@linux-fr.org>
In-Reply-To: <20031224173043.4904eaf2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 24, 2003 at 05:30:43PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch fixes incorrect dependencies (as far as I can see)
> for the SCx200 modules. A similar patch (with even more fixes) is also
> needed for Linux 2.4, and will be part of my next wave to Marcelo. Note
> that I don't have the necessary hardware to actually test anything, but
> a quick look at the code doesn't leave much place for doubt IMHO.
> Comments welcome.

Applied, thanks.

greg k-h
