From: nick.upson@gmail.com (Nick Upson)
Date: Tue, 06 Feb 2007 13:28:47 +0000
Subject: [lm-sensors] install problem
Message-Id: <36ba31bd0702060528s17a53e7bx277fad9858a354a5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <36ba31bd0702050856p43e34277se02078d9815328c8@mail.gmail.com>
In-Reply-To: <36ba31bd0702050856p43e34277se02078d9815328c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In case someone else needs this in the future, the solution is that
fedora core 5 does not appear to work with version 2.10 even if I
upgrade sysfs as well. However, installing lm_sensors-2.9.2-1 does
appear to work, at least it produces output.

On 05/02/07, Nick Upson <nick.upson at gmail.com> wrote:
> I should have mentioned that I've already tried moving /sys to /sysfs
> with no effect either.
>
> On 05/02/07, Nick Upson <nick.upson at gmail.com> wrote:
> > Hi,
> >
> > I get "Can't access procfs/sysfs file" upon running sensors. I'm using
> > fedora core 5 which is a 2.6.16 core. sensors-detect seems to work ok
> > and produces output that I have used for the modprobe commands below.
> > I read every reference I could find but none seem to apply/fix the
> > issue. I've used both the tar.gz and rpm with the same effect, both
> > 2.10.2
> >
> > #----cut here----
> > # I2C module options
> > alias char-major-89 i2c-dev
> > #----cut here----
> >
> > To load everything that is needed, add this to some /etc/rc* file:
> >
> > #----cut here----
> > # I2C adapter drivers
> > modprobe i2c-sis96x
> > modprobe i2c-isa
> > # Chip drivers
> > modprobe eeprom
> > modprobe w83627hf
> > # sleep 2 # optional
> > /usr/local/bin/sensors -s # recommended
> > #----cut here----
> >
>

