From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: sensor readings using kernel 2.5.x/2.6.0-test1
Message-Id: <20030716061247.GA5053@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F14E4B0.6080006@warder.ath.cx>
In-Reply-To: <3F14E4B0.6080006@warder.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 16, 2003 at 01:37:52AM -0400, Todor T. Zviskov wrote:
> Hi,
> 
> I'm sorry if I'm bothering you but I just discovered something that 
> might interest you. I just noticed I got sensor readings in gkrellm with 
> the 2.6.0-test1 kernel. At first it was disabled when I booted in the 
> new kernel and opened gkrellm but then I noticed that the readings were 
> just disabled (for some reason) in the config. I previously thought 
> gkrellm was using the `sensors' program for the readings (cause they say 
> lm_sensors is required) but I guess I was wrong and it's actually 
> getting the info from /sys/bus/i2c/devices/ or something (1-6000 in 
> mycase - via686a chip). I find the readings in /sys/bus/i2c/devices/ to 
> be pretty straight forward (at least for my mobo).

lmsensors does not work with 2.5/2.6 yet, sorry.

Any help would be appreciated in porting :)

thanks,

greg k-h
