From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Nov 2007 21:56:35 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <20071113225635.25def70b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4738C247.4030501@hhs.nl>
In-Reply-To: <4738C247.4030501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 13 Nov 2007 22:08:48 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > So, are you done with your porting work? If so, and if you didn't find
> > any problem with the new libsensors API, is there any reason to delay
> > the release of lm-sensors 3.0.0 any further?
> 
> I'm not done with my porting work, next on the list is net-snmp, which looks 
> easy to fix, I'll take a shot at it tomorrow. Then we also have an xfce applet 

I am interested in net-snmp as well, so maybe we can work on this
together. Well, you'll certainly be quicker than me on the code, but I
can review your patch and push it in opensuse.

> and kdelibs (although that might only depend on lm_sensors through net-snmp).

On my end (opensuse), I have kdegraphics and kdeutils which depend on
net-snmp. Only kdebase depends on libsensors directly (for ksysguard.)

> However judging from my experience sofar the API is fine, so I see no reason to 
> delay 3.0.0

Excellent. I'll do the release as my time permits. I'm very busy this
week though, so it might not be until next week.

P.S.: Please remember to add a short comment to your wiki edits so that
others see what's happening.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
