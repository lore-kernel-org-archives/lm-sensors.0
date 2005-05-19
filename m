From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: [PATCH 2.6] Bring w83l785ts in compliance with sysfs naming
Message-Id: <20040202230502.GB1397@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040202210315.17a290ee.khali@linux-fr.org>
In-Reply-To: <20040202210315.17a290ee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 02, 2004 at 09:03:15PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Here is a patch that brings the w83l785ts driver in compliance with
> sysfs naming conventions. This is pretty much the same problem and
> solution that occured very recently with the lm75 and lm78 drivers.
> 
> The patch was tested to work fine by James Bolt.
> 
> If it's too late for Linux 2.6.2, this is no big deal. I'd add a
> workaround in libsensors before releasing lm_sensors 2.8.4, and remove
> it right after.

Applied, thanks.

It's too late for 2.6.2, sorry.

greg k-h
