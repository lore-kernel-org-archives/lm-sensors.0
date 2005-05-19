From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: [PATCH] i2c-isa functionality
Message-Id: <20030827222030.GL8422@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F47BE35.3030208@paradyne.com>
In-Reply-To: <3F47BE35.3030208@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Aug 23, 2003 at 03:19:17PM -0400, Mark D. Studebaker  wrote:
> Greg, please apply. thanks.
> mds
> 
> 
> 
> The "functionality" return was incorrectly removed for i2c-isa.c when 
> porting to 2.5.
> A driver that does nothing must return a 0 or else i2c-core assumes
> 0xffffffff (all functionality).

Applied, thanks.

Next time try to CC: me, I almost missed this one :)

greg k-h
