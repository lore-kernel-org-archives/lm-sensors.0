From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030814214732.GB4097@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 12, 2003 at 06:59:19PM +0200, Jean Delvare wrote:
> 
> Greg,
> 
> Can you send me your patch after applying it? I'd like to commit a patch
> that is as similar as possible to our repository (better keep both trees
> as close as possible).

Take Tom's original patch and then change the wording to what he just
said.  My patch will not apply to 2.4 due to the dev_info() change I
have made.

thanks,

greg k-h
