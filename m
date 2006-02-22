From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 22 Feb 2006 08:37:38 +0000
Subject: [lm-sensors] Question on platform drivers
Message-Id: <VIQXhcYE.1140597458.3931800.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
In-Reply-To: <191fb4ca0602191403u1392a3b4hc5d7b93720c57355@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Juerg,

On 2006-02-22, Juerg Haefliger wrote:
> Yes I did register the device with the hwmon class. It shows up under
> /sys/class/hwmon/hwmon0/device

Did you create a "name" device attribute? libsensors needs it to find
out the chip name. i2c drivers don't need to explicitely create it
because the i2c subsystem does it for them, but there is no such
mechanism for platform drivers (yet).

You can take a look at my f71805f driver to see how this is done. It's
really simple.

If it still doesn't work after that, you could strace sensors and see
where it is failing.

--
Jean Delvare

