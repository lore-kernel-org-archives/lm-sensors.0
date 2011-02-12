From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Feb 2011 08:44:52 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add support for humidity
Message-Id: <20110212094452.00472a08@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210054256.GA23546@ericsson.com>
In-Reply-To: <20110210054256.GA23546@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Feb 2011 10:04:11 -0800, Guenter Roeck wrote:
> On Thu, Feb 10, 2011 at 07:08:10AM -0500, Guenter Roeck wrote:
> > On Thu, Feb 10, 2011 at 03:20:20AM -0500, Jean Delvare wrote:
> > > Hi Guenter,
> > > 
> > > On Wed, 9 Feb 2011 21:42:56 -0800, Guenter Roeck wrote:
> > > > This patch adds support for humidity sensors to libsensors.
> > > 
> > > Maybe it's a little late to discuss this now that humidity[1-*]_input
> > > is already described in Documentation/hwmon/sysfs-interface, but... do
> > > humidity sensors really belong to the hardware monitoring framework?
> > > What are the use cases of these sensors in practice?
> > > 
> > > We let the accelerometer drivers slip in in the past (thankfully
> > > without documenting their attributes), and now we have a hard time
> > > getting them moved to the right place. I wouldn't want to do the same
> > > mistake with humidity sensors. My feeling is that they don't belong to
> > > hwmon.
> > > 
> > The argument is that humidity is an environmental parameter which does
> > affect system operation, and thus it does belong to the hwmon framework.
> > I don't know what the existing/supported sensors are used for, but could
> > well imagine one in an industrial computer used to ensure that the system
> > isn't running in too much humidity.
>
> Copying Jonathan for additional comments.
> 
> I did some search on the web, and noticed that many environmental monitoring
> systems for server environments include humidity sensors, and it is often listed
> at the same level of importance as temperature sensors.

Feel free to commit this patch then, if you're confident this is the
right thing to do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
