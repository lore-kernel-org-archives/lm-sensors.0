From: jmunsin@abo.fi (Jonas Munsin)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <20040513184928.GA23342@nemo.sby.abo.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 13, 2004 at 06:17:22PM +1000, Bradley Schatz wrote:
> I tested this. pwmconfig didnt manage to stop any of my fans though. It
> looks like my pwm isnt configured at the hardware level.

Ok. I don't know pwmconfig, and the patch adds a interface that is only
proposed atm (i.e., pwmconfig might not know about it). And looking at
the patch and Documentation/i2c/sysfs-interface makes me think I gave
some of the stuff the wrong names, need to fix that. So for further
testing, it's currently better to use the sysfs interface directly.

Also, there are starting to be a whole lot of toggles in the interface
to get wrong... So here is a brief description:

Mode 1: pwm disabled, gives on/off for the fan:

xena:/sys/bus/i2c/devices/0-0290# echo 0 > pwm1_enable
xena:/sys/bus/i2c/devices/0-0290# echo 1 > fan1_enable

now the fan should be on.

xena:/sys/bus/i2c/devices/0-0290# echo 0 > fan1_enable

And that should turn it off.

On my Asus a7v600, this is the only mode that works for the third fan (marked PWR IIRC).

Mode 2: pwm enabled, manual control

xena:/sys/bus/i2c/devices/0-0290# echo 1 > pwm1_enable
xena:/sys/bus/i2c/devices/0-0290# echo 0 > fan1_auto_enable
xena:/sys/bus/i2c/devices/0-0290# echo 255 > pwm1

Now it should run with full speed, doing

xena:/sys/bus/i2c/devices/0-0290# echo 200 > pwm1

cuts down the speed a bit.

Mode 3:

xena:/sys/bus/i2c/devices/0-0290# echo 1 > pwm1_enable
xena:/sys/bus/i2c/devices/0-0290# echo 1 > fan1_auto_enable

Well, this mode isn't really ready yet...

> >   http://people.debian.org/~jmunsin/it87.patch2
