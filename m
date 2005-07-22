From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 11:59:41 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <Q9cq7HHM.1122026013.2522630.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716013537.GA4265@jupiter.solarsys.private>
In-Reply-To: <20050716013537.GA4265@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

On 2005-07-22, Yani Ioannou wrote:
> I'm a bit confused on the current state of hwmon, was the latest patch
> accepted anywhere?

It was accepted by me, for what it's worth. I'd expect Greg KH to ack
it when he gets around, but he is currently busy with the various Linux
summer summits.

> Aside from ipmisensors (which is blocked on other
> work anyway) I'm looking into adding a sysfs/hwmon interface to the
> new hdaps driver (see http://hdaps.sourceforge.net/), any opinions?

The site lacks documentation. Care to explain to us what exactly the
project does, and why you do think it is related with hardware
monitoring? Any precise example of what sysfs files would be created?

> It would probably mean adding two new classes of sensor types,
> acceleration and 'variation' types. The hdaps driver is not the only
> driver out there that could use these though, I believe some
> powerbooks and other notebooks have a similair system (see
> http://www.kernelthread.com/software/ams/).

I think I can imagine whan an acceleration sensor is about. Not too sure
what "variations" would be though. What unit are these variations
expressed in? Sensors are typically about measuring a current state
rather than expressing variations between states.

--
Jean Delvare
