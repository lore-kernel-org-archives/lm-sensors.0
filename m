From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix i2c-core.c with DEBUG
Message-Id: <20040119210343.GB4407@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118123749.5001d609.khali@linux-fr.org>
In-Reply-To: <20040118123749.5001d609.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 18, 2004 at 12:37:49PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> At the moment, i2c-core.c fails compiling with DEBUG. Following patch
> should fix that.

Applied, thanks.

greg k-h
