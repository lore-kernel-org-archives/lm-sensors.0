From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: More on SMBus multiplexing
Message-Id: <20041109005015.GE25651@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
In-Reply-To: <20041023200215.38e375a1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 08, 2004 at 10:50:05PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > On second thought, don't. As I said on LKML this morning, my autoload
> > code doesn't work and we will have to stick to manual loading for now.
> > I'll provide a simplified patch that does this tomorrow.
> 
> We are not exactly tomorrow but here is the modified patch. Please note
> that this is only safe tp apply *after* my other patch that adds extra
> checks to i2c_del_adapter.
> 
> Please apply,

You sent this patch with the wrong -p level :(
I fixed it up...

Applied, thanks.

greg k-h
