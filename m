From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Sep 2012 18:21:09 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <20120926182109.GA29908@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 26, 2012 at 03:01:55PM +0100, MrNice wrote:
> On 09/23/2012 07:39 PM, Jean Delvare wrote:
> >On Sun, 23 Sep 2012 19:07:05 +0100, MrNice wrote:
> >>Question: What program do you advise to heavy load the CPU and get
> >>higher temp?
> >$ md5sum /dev/zero &
> >
> >once per logical CPU.
> >
> Thanks Jean.
> 
> Unfortunately after the next boot, fan2 (CPU_FAN1 for ASROCK 970)
> was again at 0 RPM.
> I tried more reboots, changes in the UEFI but nothing.
> Very strange...
> 
The only idea I have at this point is for you to run superiotool (the version I
pointed you to earlier) when you see the fan output, and then again when you
don't. If we are lucky, we might see a difference in GPIO programming for the
two cases.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
