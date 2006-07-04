From: brian@rapsure.net (Brian Beardall)
Date: Tue, 04 Jul 2006 05:08:28 +0000
Subject: [lm-sensors] F75383 driver development,
Message-Id: <1151989708.2551.11.camel@rapsure.rapsure.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1151977904.2551.3.camel@rapsure.rapsure.net>
In-Reply-To: <1151977904.2551.3.camel@rapsure.rapsure.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2006-07-03 at 20:03 -0600, Brian Beardall wrote:
> On Mon, 2006-07-03 at 19:51 -0600, Brian Beardall wrote:
> > On Mon, 2006-06-26 at 22:39 +0200, Jean Delvare wrote:
> > > Hi Brian,
> > > 
> > > > I've been working on a driver for the chip, but I can't get it to
> > > > interface with sensors. I have it reading from the registers correctly,
> > > > and I used a printk statement to make sure that the driver was reading,
> > > > and storing the values correctly, but when I run sensors it doesn't
> > > > print out anything. I based the code off of your lm63 driver. The driver
> > > > does initialize, and detect. Would you like to look at it, and how woule
> > > > you like me to send it? I have a couple things to fix with temperature
> > > > calculation, hyst, and min, and max, but I first want to get it to talk
> > > > to userland software.
> > > 
> > > If you want "sensors" to display anything for your chip, you must add
> > > support for it to libsensors, and to sensors itself. You must also make
> > > sure that you register your driver with the hwmon class.
> > > 
> > > You are welcome to post your code on this list, as a -p1 patch against
> > > either Linus' or Andrew's tree. You can post the patch either inline
> > > (if your mailer can do this properly) or as an attchement (type
> > > text/plain) so that we can comment on it and help you.
> > > 
> > 
> > I've been working on the userland, and on the Linux kernel 2.4 driver,
> > but I have a few questions now. How do I choose these:
> > 
> > #define F75383_SYSCTL_TEMP1		1200
> > #define F75383_SYSCTL_TEMP1_TCRIT	1201
> > #define F75383_SYSCTL_TEMP1_TCRIT_HYST	1202
> > #define F75383_SYSCTL_TEMP2		1203
> > #define F75383_SYSCTL_TEMP2_TCRIT	1204
> > #define F75383_SYSCTL_TEMP2_TCRIT_HYST	1205
> > #define F75383_SYSCTL_ALARMS		1206
> > 
> > Besides that everything will be done by tomorrow.
> > 
> > Thanks in advance.
> > 
> > Brian Beardall
> > 
> I figured it out.
> 

The driver is complete, and tomorrow I will be submitting the patches
against Linus's tree, and lm_sensors. Also there is a Linux 2.4 driver
that will need to be tested. I have tested the 2.6 driver, and it has
passed all of the tests that I could think of. I would like the code to
be checked, and suggestions are welcome.

Brian Beardall


