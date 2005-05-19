From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH 2.6] Prevent i2c-dev oops with debug
Message-Id: <20040311011045.GA11828@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040302224909.444663af.khali@linux-fr.org>
In-Reply-To: <20040302224909.444663af.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2004 at 09:27:02AM +0100, Jean Delvare wrote:
> 
> (BTW, why do these modules accept to load if no hardware matches? Just
> in case the hardware is hot-plugged later?)

Because that is how drivers now work.  We don't fail to load if there is
no hardware present at this point in time, as it could be added at any
point in the future.

thanks,

greg k-h
