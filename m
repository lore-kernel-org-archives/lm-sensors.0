From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 03 Nov 2012 16:03:25 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121103160325.GA21426@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 02, 2012 at 06:31:34PM +0100, Jean Delvare wrote:
> On Fri, 2 Nov 2012 10:19:25 -0700, Guenter Roeck wrote:
> > On Fri, Nov 02, 2012 at 04:24:04PM +0100, Jean Delvare wrote:
> > > temp3_offset value of 116000 makes them match.
> >
> > Good, so at least we know that we have the correct register. The only remaining
> > question is if we should make tempX_offset unsigned if a sensor is configured
> > for AMDTSI. Kind of odd, though, since it is signed for everything else and
> > might thus change sign when/if the sensor type is changed. Not sure what the
> > best approach might be.
> 
> Treating it as unsigned when the type is set to AMD-SI is probably the
> way to go for now, although I would love to get more samples from users

Agreed.

> of AMD CPUs to make sure. I suppose we'll get more feedback after the
> patch series you send earlier this week hits mainline.
> 
and agreed.

I'll come up with one more patch to add support for AMD-SI to it8728f.
Hopefully sometime this weekend.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
