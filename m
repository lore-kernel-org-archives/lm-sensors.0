From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: How to convert i2c adapter drivers into good kernel code
Message-Id: <20030325074112.GG12590@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325072511.GD12590@kroah.com> <20030325073834.B30897@infradead.org>
In-Reply-To: <20030325073834.B30897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Tue, Mar 25, 2003 at 07:38:34AM +0000, Christoph Hellwig wrote:
> On Mon, Mar 24, 2003 at 11:25:12PM -0800, Greg KH wrote:
> >    line in the driver, and replace the LM_VERSION and LM_DATE entries
> >    with I2C_VERSION and I2C_DATE to fix that compile time error.
> 
> That's bogus.  Replace LM_VERSION with the lm_sensors version you took it
> from + lk1 (e.g. "2.7.0-lk1) and LM_DATE with your modification date.
> Or just remove them altogether..

Fine with me, I was just trying to copy what I had seen done for the
other drivers already in the kernel.  version and dates don't really
make _any_ sense once the driver is in the kernel, so I'd recommend just
removing them altogether too.

thanks,

greg k-h
