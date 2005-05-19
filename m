From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <20030818210300.GA3276@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Aug 17, 2003 at 05:32:19PM -0700, Philip Pokorny wrote:
> Why don't we just make it policy that now and in the future we don't 
> initialize the limits on the sensors?

Sounds good to me.  Anyone want to test the existing 2.6 drivers with
the init code ripped out from them and send me a patch?

thanks,

greg k-h
