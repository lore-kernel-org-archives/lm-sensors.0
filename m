From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 29 Jun 2007 17:52:10 +0000
Subject: Re: [lm-sensors] VRM value in libsensors/sensors
Message-Id: <191fb4ca0706291052i246f3b41y6fc4b9ec8a9fd11e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070629134434.66d96ab3@hyperion.delvare>
In-Reply-To: <20070629134434.66d96ab3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/29/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Jean Delvare wrote:
> > Hi all,
> >
> > I am thinking of removing SENSORS_FEATURE_VRM from the new libsensors.
> > A first reason for that is that the newer VRM codes as used in the 2.6
> > kernel are arbitrary numbers and don't match the Intel specification
> > numbers as the first ones did. So we may display things like "VRM
> > version 1.3" and that's confusing because it doesn't correspond to
> > anything real. A second reason is that Rudolf Marek added code to set
> > the VRM version automatically depending on the CPU model some times ago
> > already, and it works very well, so the users no longer have to care
> > about VRM versions.
> >
> > I would even go as far as switching the vrm attribute of the hwmon
> > kernel drivers to read-only... or even remove them entirely.
> >
>
> I think that removing VRM support is a good idea, its called libsensors, so
> lets stick to sensors.

I second that.

...juerg



>
> Regards,
>
> Hans
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
