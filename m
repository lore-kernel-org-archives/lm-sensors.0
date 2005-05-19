From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Refactor swap_bytes in i2c chip drivers
Message-Id: <20040330222555.GB12583@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329212303.2b47b12d.khali@linux-fr.org>
In-Reply-To: <20040329212303.2b47b12d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 29, 2004 at 11:20:14PM +0200, Jean Delvare wrote:
> > Ick, no, we should be using the proper kernel call for this, swab16(),
> > right?  Care to redo this patch to just fix the drivers and get rid of
> > our duplicating of this function.
> 
> Oh, I didn't know such a function existed, sorry.
> 
> Here's a new patch, hope you like it. Tested to work on my as99127f, btw
> (w83781d driver).

Looks good, applied, thanks.

greg k-h
