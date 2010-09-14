From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 14 Sep 2010 16:20:02 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100914162002.GA5440@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 04:04:40AM -0400, Mahmood Naderan wrote:
> What is the conclusion then? I read this thread but didn't end up with a clear solution. Is it related to the distro or lm-sensors?
> 
> I need to see core temps in my kubuntu/ubuntu 10.04 with 2.6.32-24-generic kernel. Some one please answer step byt step from scratch.
> 
Stick with your distribution.

Run "sudo modprobe coretemp", then check if the core sensors show up.
If yes, add the required modules (probably it87 and coretemp) into /etc/modules.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
