From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: lsb in emc6d102 and adm1027
Message-Id: <20050324002426.GA7328@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200503201236.33120.rafael.espindola@gmail.com>
In-Reply-To: <200503201236.33120.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 21, 2005 at 08:42:51AM -0300, Rafael ?vila de Esp?ndola wrote:
> Em Mon 21 Mar 2005 04:40, Philip Pokorny escreveu:
> >
> > This doesn't look right.  The lm85_read_value() function generally only
> > returns an 8-bit value.  In some cases it returns 16 bits but those are
> > exceptions, and you haven't added the EMC6D102 registers to that
> > exception list.
> >
> > So how can you shift ext4, ext3, ext1, etc right 8 bits and have a value
> > with any meaning?
> >
> > Perhaps you meant to shift by only 4 bits to get the high nibble?
> > :v)
> 
> Yes, you are wright. What a embarrassing error....
> 
> A corrected patch is attached. Thanks.

Applied, thanks.

greg k-h
