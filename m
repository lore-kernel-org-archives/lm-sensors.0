From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Kill i2c_client.id
Message-Id: <20050119233713.GA6178@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

On Sun, Jan 16, 2005 at 07:46:53PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> As discussed earlier on the LKML [1], here comes a patch set killing the
> id member of the i2c_client structure. Let me recap my main reasons for
> doing so:

I've applied all 5 patches, and then just deleted the field altogether
(mainly because sparse complained about it, and there's no reason to
have it around anymore.)

thanks for doing this work, it was really needed.

greg k-h
