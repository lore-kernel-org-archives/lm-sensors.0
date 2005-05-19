From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <20030612002844.GC27815@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 11, 2003 at 08:16:58PM -0400, Mark D. Studebaker  wrote:
> - Incompatibility w/ 2.4 kernel i2c structs

You need to make sure you get the i2c changes that are now in
2.4.21-rc7.  They fix some serious i2c-dev problems.

thanks,

greg k-h
