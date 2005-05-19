From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Resolve resource conflict between i2c-viapro and
Message-Id: <20050119232332.GC5909@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050115122555.087f9a7a.khali@linux-fr.org>
In-Reply-To: <20050115122555.087f9a7a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 15, 2005 at 12:25:55PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here comes the finalized version of our patch solving the PCI device
> resource conflict between the i2c-viapro bus driver and and the via686a
> chip driver. It is based on your original work and the IRC conversation
> we had yesterday.
> 
> The retained solution is to not permanently register the PCI device in
> either driver. This is legitimate since we only need it at init time to
> retrieve the ISA address of a sub-device (SMBus master or integrated
> sensors), and possibly change that address on user request. Once this is
> done we can safely release the PCI device for others to use.
> 
> I am really glad to see this problem finally solved, as this was the
> last remaining annoying issue left from the Linux 2.6 migration (missing
> drivers left apart), and was generating many complaints both at our
> level and at the distributions' support.
> 
> Please apply,

What kernel tree is this against?  I get some rejects when trying to
apply it.

thanks,

greg k-h
