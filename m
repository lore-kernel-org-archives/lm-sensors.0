From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: [PATCH 2.6] I2C: Do not init global variables to 0
Message-Id: <20040908193806.GE6976@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040825225039.0cded377.khali@linux-fr.org>
In-Reply-To: <20040825225039.0cded377.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 25, 2004 at 10:50:39PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> This trivial patch enforces the rule that global variables should not be
> explicitely initialized to 0 for all i2c chip drivers.


Applied, thanks.

greg k-h
