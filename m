From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix i2c busses warnings with DEBUG
Message-Id: <20040119210351.GC4407@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118124027.00622b74.khali@linux-fr.org>
In-Reply-To: <20040118124027.00622b74.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 18, 2004 at 12:40:27PM +0100, Jean Delvare wrote:
> Hi again Greg,
> 
> Two bus drivers (i2c-via and scx200_acb.c) generate warnings when the
> whole i2c subsystem is compiled with -DDEBUG. Suggested changes follow.


Applied, thanks.

greg k-h
