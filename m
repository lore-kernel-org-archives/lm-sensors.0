From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: no resolution for tickets 846 and 764 (Tyan S2688 & w83781d hard
Message-Id: <3CB36057.ABD0782C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020403192003.S13832@lapsony.mydomain.here>
In-Reply-To: <20020403192003.S13832@lapsony.mydomain.here>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

"init=0" disables almost every call to w83781d_write_value().
If you put the printk in that function you should be able to find it.

Less likely - that a read is causing the problem
(you could use the same technique to debug).

Or perhaps the module is probing some other device with bad results
(anything else on i2cdetect besides 2d, 48, 49? esp. in 0x20 - 0x2f?)

And you have verified by looking at the board that it's a w83781d?




"Steven A. DuChene" wrote:
> 
> Hello all:
> Martin Kellermann <Kellermann@sk-datentechnik.com> and me have submittedlm-sensors
> support tickets (846 and 764) regarding a hard hang problem we are seeing with a
> Tyan S2688 motherboard and the w83781d lm-sensors module. We have both tried the
> "init=0" suggestion and Martin has tried adding printk's to the code. So far no
> hints of change in this condition. I have tried a few times ther latest lm-sensors
> code from cvs but each time I try to load the module or run sensors-detect it causes
> a hard hang of the system when it goes to try the w83781d module.
> 
> Any suggestions or further hints as to where to look or what to try?
> --
> Steven A. DuChene      linux-clusters@mindspring.com
>                       sduchene@mindspring.com
> 
>         http://www.mindspring.com/~sduchene/
