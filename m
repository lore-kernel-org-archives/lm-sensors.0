From: sigint <lnx_usb@yahoo.com>
Date: Fri, 06 Jun 2008 21:20:49 +0000
Subject: Re: [lm-sensors] Issue with w83627hf? FIXED. Please take a look.
Message-Id: <178518.84091.qm@web38308.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


OK, I figured out what's going on..

I modified the config file, and added "-isa-0290" at
"chip" label (in w83627hf section). My w83627HF is on
ISA bus at 0290 address.

Now, I get the proper readings.

I don't know what wrong I did. If someone can point it
to me, I do appreciate it. If it's an issue with
lm_sensors, please add it to the "README".

Thanks!

--- sigint <lnx_usb@yahoo.com> wrote:

> Hello,
> 
> I have an old linux box with Winbond w83627hf chip,
> and I'm trying to read the system health values.
> 
> I'm using 2.6.12, and lm_sensor3.0.1.
> 
> I ran the sensor-detect, and loaded the required
> modules, "i2c-isa", and "w83627hf", and I can see
> the
> entries in the "sys" file system.
> 
> Whatever I do (modify the label name, etc) with the
> configuration file, "sensors" isn't reading from it
> at
> all. If I comment the chip name, and run "sensors
> -s",
> it complains - otherwise it doesn't appear to read
> the
> config file at all. "sensors" runs fine.
> 
> But, "sensors" divides all the voltages (in0_input,
> in1_input, ...) by 1000, and prints them. 
> 
> "sensors" even works without the config file
> (/etc/sensors.conf)
> 
> I really appreciate if someone helps me understand
> what's going on.
> 
> Thanks!
> 
> 
>       
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
>
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
