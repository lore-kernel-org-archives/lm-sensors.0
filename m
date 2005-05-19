From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041103222935.GA30988@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 03, 2004 at 11:07:47PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > Greg, please apply the patch then, unless you have personal
> > objections.(I may resend it with a Signed-off-by line if you want, or
> > just add it yourself.)
> 
> On second thought, don't. As I said on LKML this morning, my autoload
> code doesn't work and we will have to stick to manual loading for now.
> I'll provide a simplified patch that does this tomorrow.
> 
> Thanks and sorry for the trouble.

Heh, glad I've been putting i2c patches off for a while, it payed off
here :)

thanks,

greg k-h
