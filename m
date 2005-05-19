From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: problem with 2.6?
Message-Id: <20030715223418.GA6409@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0307152345480.29705@draco.qip-net.lan>
In-Reply-To: <Pine.LNX.4.56.0307152345480.29705@draco.qip-net.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 15, 2003 at 11:51:48PM +0200, Thomas Gruber wrote:
> Hi people of lm-sensors (what a start) =)
> 
> 3 days ago i compiled the 2.6.0-test1 kernel on my system (which runs very
> smoothly, i must say) however: if i try to compile lm-sensors, all fails.

The lm-sensors userspace library doesn't work with the 2.6 kernel,
sorry.

For now you can read the settings by hand from sysfs.

Help on working on the 2.6 port of lmsensors would be appreciated.

thanks,

greg k-h
