From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [PATCH][2.5] Support for W83627THF sensor chip (Was Re: [2.5]
Message-Id: <20030618173223.GC1609@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055807044.7227.7.camel@nosferatu.lan>
In-Reply-To: <1055807044.7227.7.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 17, 2003 at 01:44:04AM +0200, Martin Schlemmer wrote:
> Hi
> 
> Ok, I was wrong in assuming that the W83627THF was on the I2C bus.
> It is on the ISA bus, id 0x90 (thanks to Alex Van Kaam author of
> MBM who corrected my assumption).
> 
> Attached is two patches .. one against sources without my previous
> broken patch, and one that will revert the broken one.

Ok, I've added this to my tree.

thanks,

greg k-h
