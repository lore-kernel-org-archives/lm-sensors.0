From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Jul 2007 16:57:32 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <20070719185732.6fc8a18c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Sorry for the late answer, I'm swamped :(

On Sat, 14 Jul 2007 22:17:34 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Fri, 13 Jul 2007 14:08:53 +0200, Hans de Goede wrote:
> >> I know it looks strange to store the return value in an int then, but in some 
> >> of the other store methods I need val to be signed, and for consistency I've 
> >> thus stored it into an int everywhere.
> > 
> > But wouldn't then a large input value (fitting in a long but not in an
> > int) be silently turned into a negative value, possibly doing crazy
> > things in the rest of the code?
> 
> That could happen, but then people are _really_ asking for it. Notice that most 
> hwmon drivers store functions do even less checking then this. We really need 
> to discuss this and make a decision on it for all hwmon drivers, starting with 
> the question wether or not to check if the user input actually is a number?
> 
> Currently a user can do:
> echo -n foo > /sys/class/hwmon/hwmon0/in0_max
> and not get an error (instead in0_max typically gets set to 0

I am totally fine handling really invalid values as 0. As you said,
people doing that are asking for trouble, and handling this case would
slow down and/or enlarge our drivers quite a bit.

OTOH, the reason why I think that numbers should always be treated
correctly, even if out of bounds, is that they may be written by
libsensors rather than directly by a human. And libsensors may have
done some arithmetic operations on the values based
on /etc/sensors.conf, in particular for voltages. This can easily
result in a negative value being written to a voltage sysfs file. This
is really important that we correctly trim the negative value to 0 mV
and not to 4080 mV, otherwise we trigger an unwanted alarm. This is
only an example but it shows why we have to be careful.

That being said, this is kind of low priority and I am fine fixing the
drivers when people report such problems. I really don't have the time
to go thought all drivers to make sure that they are always correct
(but wouldn't mind if someone else does, of course.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
