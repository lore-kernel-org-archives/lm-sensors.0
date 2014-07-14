From: Gianni Vialetto <gianni@rootcube.net>
Date: Mon, 14 Jul 2014 16:47:28 +0000
Subject: [lm-sensors] hwmon: question about the sysfs interface
Message-Id: <20140714164728.GA1041@elysium.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@lm-sensors.org
Cc: gianni@rootcube.net, nouveau@lists.freedesktop.org

Hello guys,

For a patch to this nouveau bug [1] I'm trying to implement the sysfs
interface for two properties (linear_min and linear_max) nouveau uses
internally to decide when to raise the fan speed. The initial idea was
to have them as custom sysfs attributes, but I was advised to try to
fit them into the hwmon sysfs interface.

And this is when I hit a little roadblock. If my understanding is
correct (and I'm not ashamed to admit it probably isn't) trip points
are used to tie together a specific fan speed to a specific
temperature. Unfortunately nouveau does not quite work that way: those
two properties above mark the temperature the driver uses to decide
when to start and stop the *scaling* of the fan speed (from a specific
minimum value all the way to 100%).

Now, could I strech the trip point definition above to mean that a
trip point specify a *minimum* value for the fan speed at a specific
temperature, and that the driver can decide to use an higher speed as
needed when the temperature goes above the one specified in the trip
point without fear of breaking some convention/userspace tool that
expect a constant fan speed? Is this an acceptable/correct usage for
the interface?

Thanks,
Gianni

[1] https://bugs.freedesktop.org/show_bug.cgi?id=80901

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
