From: dbailey@digium.com (Doug Bailey)
Date: Thu, 08 Feb 2007 13:29:38 +0000
Subject: [lm-sensors] Fwd:  ADT75 sensor
Message-Id: <12356743.60251170941378136.JavaMail.root@jupiler.digium.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have not yet ported i2cdump to my embedded appliance.  The problems reside in the detection 
portion of the the lm75 driver in comparing the valid registers with other registers.  


               int cur, conf, hyst, os, i;

                /* Unused addresses */
                cur = i2c_smbus_read_word_data(new_client, 0);
                conf = i2c_smbus_read_byte_data(new_client, 1);
                hyst = i2c_smbus_read_word_data(new_client, 2);
                if (i2c_smbus_read_word_data(new_client, 4) != hyst
                 || i2c_smbus_read_word_data(new_client, 5) != hyst
                 || i2c_smbus_read_word_data(new_client, 6) != hyst
                 || i2c_smbus_read_word_data(new_client, 7) != hyst)
                        goto exit_free;
                os = i2c_smbus_read_word_data(new_client, 3);
                if (i2c_smbus_read_word_data(new_client, 4) != os
                 || i2c_smbus_read_word_data(new_client, 5) != os
                 || i2c_smbus_read_word_data(new_client, 6) != os
                 || i2c_smbus_read_word_data(new_client, 7) != os)
                        goto exit_free;

                /* Unused bits */
                if (conf & 0xe0)
                        goto exit_free;

                /* Addresses cycling */
                for (i = 8; i < 0xff; i += 8)
                        if (i2c_smbus_read_byte_data(new_client, i + 1) != conf
                         || i2c_smbus_read_word_data(new_client, i + 2) != hyst
                         || i2c_smbus_read_word_data(new_client, i + 3) != os)
                                goto exit_free;

Even when I remove the one-shot register from the compare (Register at address 4) the comparisons still fail. 
While the identification process for the lm75 is pretty lame, the adt75 is worse.  (No id register, etc.)

I've reevaluated what you have said and have modified the lm75 driver to reduce the detect checking to a minimum.  
(I make sure the reserved bit in the config register is zero.)  Given what the intent for the device I am using, 
the lm75 driver's +/- .5 deg C temperature is fine.  I can do without the one shot for now.  

If I need it, I will probably access it via the i2c ioctl calls as it would be a non-standard application anyway.

Doug 



----- Forwarded Message -----
From: Jean Delvare <khali at linux-fr.org>
To: Doug Bailey <dbailey at digium.com>
Cc: lm-sensors at lm-sensors.org
Sent: Tuesday, February 6, 2007 9:12:04 AM GMT-0600 US/Central
Subject: Re: [lm-sensors] ADT75 sensor

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


