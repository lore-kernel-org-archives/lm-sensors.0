From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20031006163853.GA4137@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 05, 2003 at 11:37:22AM +0200, Jean Delvare wrote:
> 
> > "porting-chip-drivers-2.4-to-2.6"?  Why make it short?  :)
> 
> Because all our other docs have short names. And I usually avoid names
> longer than 23, to keep "ls -l" happy. I could place the document in our
> doc/chips subdirectory and name it "PORTING-2.6".

Ok, that's fine with me.  Want to add my porting bus drivers document
too?

> BTW, I don't think the busses and chips documentation is included into
> Linux 2.6.0-testX. Is it on purpose (users will want to download
> lm_sensors for at least sensors-detect anyway)?

Care to send a patch to fix this?  :)

thanks,

greg k-h
