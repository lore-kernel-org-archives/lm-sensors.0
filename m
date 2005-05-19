From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix w83781d temp
Message-Id: <20040114192738.GK6107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040110140700.5b5ab705.khali@linux-fr.org>
In-Reply-To: <20040110140700.5b5ab705.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 10, 2004 at 02:07:00PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> This patch fixes the temperature handling in the w83781d driver:
> 1* Fix bad magnitude.
> 2* Use MMH's lm75.h.
> 3* Allow negative temperatures.
> 
> This applies on top of the patches stack. In particular, the asb100
> patch needs to be applied before this one so that lm75.h is present.

Applied, thanks.

greg k-h
