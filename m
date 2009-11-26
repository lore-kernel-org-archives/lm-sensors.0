From: Clemens Ladisch <clemens@ladisch.de>
Date: Thu, 26 Nov 2009 13:24:45 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <4B0E819D.2080109@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Charles Pr=C3=A9vot wrote:
> I have some problems configuring the fancontrol script, because each time=
 I
> shutdown my computer, when I reboot my /sys/class/hwmon/ is different
> (subfolders hwmon? are numbered differently).
> What is responsible for this order ?

The order in which the respective drivers are initialized.  Since the
initialization functions run in parallel, this is essentially random,
as you're seeing.

> How can I configure it to have i fixed order ?

The entries in /sys/class/hwmon/ are actually symbolic links (see the
output of "ls -l /sys/class/hwmon"), so you could refer to the devices
by their real path.

If some program requires paths in /sys/class/hwmon, you could blacklist
all the hwmon modules to prevent them from loading, then load them later
in some predetermined order.  (How this is done depends on the
distribution, usually with files in /etc/modprobe.conf.)


HTH
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
