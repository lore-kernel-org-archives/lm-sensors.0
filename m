From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [PATCH 39/39] w1/w1_therm: replace schedule_timeout() with
Message-Id: <20050125062708.GA2361@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050122011746.55a3585b@zanzibar.2ka.mipt.ru>
In-Reply-To: <20050122011746.55a3585b@zanzibar.2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Sat, Jan 22, 2005 at 01:17:46AM +0300, Evgeniy Polyakov wrote:
> > Hi,
> 
> > Please consider applying.
> 
> > Description: Use msleep_interruptible() instead of schedule_timeout() to
> > guarantee the task delays as expected. Changed tm to an int, as it now is in
> > terms of msecs, not jiffies.
> 
> I've applied it to my tree, thank you.
> 
> Greg please push it upstream.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

Applied, thanks.

greg k-h
