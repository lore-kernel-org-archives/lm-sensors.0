From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: bmcsensors port to 2.6
Message-Id: <20050316020121.GA13243@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
In-Reply-To: <FA095C015271B64E99B197937712FD02510AFF@freedom.grz.icomedias.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 13, 2005 at 05:51:06PM +0100, Jean Delvare wrote:
> So what I had been asking for some times ago, and Yani is asking for
> again now, is an extension of the sysfs interface that would let us have
> a single callback function for several interface files, with that
> additional parameter, whatever form it takes. Is there a chance such an
> extension could be accepted?

Yes, it would be accepted, as you are not the only ones asking for this
:)

> How this would have to be done, if you already have an idea on this?
> Or any reason why this isn't a good idea?

I don't really have any ideas about this can be implemented, because I
really haven't given it much thought, sorry.

Good luck,

greg k-h
