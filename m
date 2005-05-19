From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH 2.6] No reset not limit init in via686a
Message-Id: <20040412232359.GG26817@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040412112515.4f6904ba.khali@linux-fr.org>
In-Reply-To: <20040412112515.4f6904ba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 12, 2004 at 11:25:15AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> The following patch removes limits initialization in the via686a driver.
> It was decided some times ago that this belongs to user-space, not
> kernel. See the thread here:
> http://archives.andrew.net.au/lm-sensors/msg06134.html
> 
> It also prevents the sensor chip from being savagely reset at load time.
> This too follows a decision taken long ago that drivers should do as
> little as possible in their init procedure. See the thread here:
> http://archives.andrew.net.au/lm-sensors/msg04593.html
> 
> This should make the driver smaller, safer and faster to load. The same
> was done to our 2.4/CVS version of the driver 5 months ago and it seems
> to work just fine.
> 
> This should apply cleanly on top of the previous patches (more
> importantly, it should be applied after the recent error path fix patch,
> although both patches shouldn't collide).

Applied, thanks.

greg k-h
