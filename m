From: andrew@pbltd.net (Andrew Greig)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Linux driver for the PC87366 chip
Message-Id: <408B5B3E.4010208@pbltd.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040424191636.7375a3f0.khali@linux-fr.org>
In-Reply-To: <20040424191636.7375a3f0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Andrew,
> 
> Two years ago, you asked us about the support we could offer for the
> PC87366 Super-I/O hardware monitoring functions. We had no driver back
> then.
> 
> I just wanted to let you know that I wrote a driver. You can the get the
> latest version of lm_sensors from our CVS repository:
> http://secure.netroedge.com/~lm78/download.html#cvs
> It has support for the whole PC76360 family.
> 
> If you give it a try, please let us know how it works for you.
> 
> Thanks.

Hi Jean,

I'm stunned that you've got back to me after all this time, its 
incredibly conscientious of you.  Good work on the driver.

My company used to have several dozen systems containing this chipset at 
customer sites.  Unfortunately they have all self-destructed due to 
their power supply fan failing, resulting in a cooked motherboard. 
Guess I missed out on some very high sensor readings :)

I won't be able to try out the PC87366 driver, but I'll certainly be 
using the sensor software on our current hardware.

Thanks again,
Andrew Greig
