From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: new chip driver in 2.6, question
Message-Id: <20040214174711.GA5280@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040210215758.3c163465.khali@linux-fr.org>
In-Reply-To: <20040210215758.3c163465.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 10, 2004 at 09:57:58PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Is it OK to add new sensor chip drivers to 2.6 for old chipsets that
> haven't been requested yet?

Of course.

> (Mine would be: don't actively port unrequested drivers, but accept them
> if it happens that someone provides them.)

Sounds good to me, I will not turn down a driver someone has ported and
looks sane :)

thanks,

greg k-h
