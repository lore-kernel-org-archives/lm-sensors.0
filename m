From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <20030923091617.B10818@infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10642734271572@kroah.com> <1064273428551@kroah.com>
In-Reply-To: <1064273428551@kroah.com>; from greg@kroah.com on Mon, Sep 22, 2003 at 04:30:28PM -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Mon, Sep 22, 2003 at 04:30:28PM -0700, Greg KH wrote:
>  	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
> -		/* XXX: WTF is going on here??? */
> -		if ((is_isa && check_region(addr, 1)) ||
> +		void *region_used = request_region(addr, 1, "foo");
> +		release_region(addr, 1);
> +		if ((is_isa && (region_used = NULL)) ||

WTF??  Your papering over bugs again, this doesn't help at all.
