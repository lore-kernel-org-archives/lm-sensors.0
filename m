From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.65
Message-Id: <20030320235203.GA10249@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030320223046.GA4959@kroah.com> <10481995574110@kroah.com> <20030320234156.A21189@infradead.org>
In-Reply-To: <20030320234156.A21189@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Thu, Mar 20, 2003 at 11:41:56PM +0000, Christoph Hellwig wrote:
> On Thu, Mar 20, 2003 at 02:32:00PM -0800, Greg KH wrote:
> >  	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
> 
> Do I see a check_region here? :)

You really need to start reading all of the patches in the series :)

thanks,

greg k-h
