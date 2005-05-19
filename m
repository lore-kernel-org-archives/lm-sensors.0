From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] Remove asb100 support from w83781d
Message-Id: <20040224002741.GG24225@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040223223028.5726f3c8.khali@linux-fr.org>
In-Reply-To: <20040223223028.5726f3c8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 23, 2004 at 10:30:28PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Now that we have a separate asb100 driver, we can remove the (bad)
> support of it from the w83781d driver. Following patch does this. I've
> already cleaned this up in our CVS repository.
> 
> Please apply,

Applied, thanks.

greg k-h
