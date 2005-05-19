From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH 2.6] I2C: New chip driver: sis5595
Message-Id: <20050201165549.GE23118@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011420.17466.adobriyan@mail.ru> <20050201121414.GA15219@bode.aurel32.net>
In-Reply-To: <20050201121414.GA15219@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aurelien Jarno <aurelien@aurel32.net>, Alexey Dobriyan <adobriyan@mail.ru>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Tue, Feb 01, 2005 at 01:14:14PM +0100, Aurelien Jarno wrote:
> +	if(force_addr)

Please put a space after the "if" and before the "(".  You do this in a
number of places.

thanks,

greg k-h
