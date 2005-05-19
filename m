From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [TRIVIAL PATCH 2.5.67] fix compilation error for various i2c-devices
Message-Id: <20030409181104.GA1067@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304091417.h39EHQWq001134@shire.frodo.local>
In-Reply-To: <200304091417.h39EHQWq001134@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 09, 2003 at 03:00:50PM +0200, Thomas Schlichter wrote:
> Changed the i2c_adapter name definition to match the current interface.

Thanks, I've applied this to my trees and will send it on in a bit.

But how did you compile the i2c-adap-ite and i2c-frodo drivers?  They
can not be built in the current kernel tree at all due to lack of either
Kconfig or Makefile support.

thanks,

greg k-h
