From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Feb 2007 15:12:04 +0000
Subject: [lm-sensors] ADT75 sensor
Message-Id: <20070206161204.a1b16cdc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <15533071.11811170705037131.JavaMail.root@jupiler.digium.com>
In-Reply-To: <15533071.11811170705037131.JavaMail.root@jupiler.digium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Doug,

On Mon, 5 Feb 2007 13:50:37 -0600 (CST), Doug Bailey wrote:
> I am writing an interface for a Analog Devices ADT75 using
> a uClinux distribution for the blackfin processor.  I want
> to use the HWMON interface to do this.  
> 
> The distribution does not specifically have an ADT75 sensor
> but does have a LM75 sensor. Unfortunately, the addition of
> the one-shot register in the ADT75 causes the LM75_detect
> portion of the driver to fail.  In addition the temp
> precision is different on the ADT75 from the LM75.

Can you please provide the output of i2cdump for your ADT75 chip in
both byte and word modes?

> I don't see on your web site that anyone has already
> generated an ADT75 driver. Therefore I made the relatively
> simple modifications to make the LM75 into an ADT75.  In
> doing this I have run into a couple of issues: 
> 
> - My problems come in that I do not have an i2c ID for the
> driver (There is no I2C_DRIVERID_ADT75.)  Is there a way of
> getting one of these defined?

You really don't want to write a new driver. Insead you want to add
support for the ADT75 to the lm75 driver, so you don't need any driver
id. That way we avoid code duplication.

> - I would like to access a couple of the ADT75 registers through
> sysfs that currently do not have defined interfaces. (Most notably
> the one shot register and the fault queue registers.)  Is there
> some guideline on how these should be defined?

Using the one-shot mode doesn't fit in the hwmon subsystem very well.
What interface would you like to offer exactly? My fear is that people
will start reporting to us that "it doesn't work" because applications
expect the sensor values to be updated in real time. Also, continuous
monitoring allows the alarm output to be triggered even if no
application is reading the value.

As for the fault queue, we do not have a standard for it, I tend to
believe that the BIOS should be setting it if needed. I've never seen
it useful in practice.

-- 
Jean Delvare

