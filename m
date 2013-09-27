From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Sep 2013 16:32:15 +0000
Subject: Re: [lm-sensors] Sudden shutdown and wrong temperature reading (driver jc42)
Message-Id: <20130927163215.GC10392@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
In-Reply-To: <CAA9rSiUf_zbJ-sZ99yRQpakmpZrBurzM613ra0RqWQe8bVEcmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 27, 2013 at 12:57:07PM -0300, Olavo Luppi Silva wrote:
> Hi dear lm-sensors developers,
> 
> My name is Olavo, I am a newbie in this group and I am writing because I'm
> facing some problems that I suspect it could be a lm-sensors bug. If it's a
> bug I would be happy to help fixing it.
> 
> 
> SHORT STORY:
> The workstation suddenly shuts down, usually when performing intensive
> computation. Workaround: comment line jc42 at /etc/modules apparently
> solves the problem.
> 
> 
> 
> LONG STORY:
> We have 3 Intel workstations with the specification described below,
> running linux ubuntu and lm-sensors installed. In June, one of the machines
> (raphson) started to shutdown suddenly during intensive computations, all
> processor in use during several hours. The shutdown events where becoming
> more and more frequent (a shutdown at each 5 minutes) and raphson were
> taken to technical assistance. They detected a hardware problem and
> replaced the motherboard which was in warranty period.
> 
> Raphson returned but the shutdown events were still present at each 12h to
> 24h, roughly. Then I created a script to save sensors temperatures, which
> is pasted below, and monitored the workstation for many hours.  Ploting
> temperature of sensors jc42-i2c-8-1a, jc42-i2c-8-1b, etc, I noticed some
> spikes both down (0 Celsius degrees) and up (250 C).
> Then I disabled sensor jc42 commenting line jc42 at /etc/modules and it
> apparently solves the problem. Raphson is running without interruption
> performing intensive computations for 3 weeks now.
> 
> I also performed the same temperature monitoring at the two other machines:
> kalman and gauss. Kalman temperature plots are ok, but Gauss's aren't. It
> presents the same spikes and sometimes produces the following error:
> ERROR: Can't get value of subfeature temp1_input:
> Kalman is running intensive computations without interruption for 2 weeks.
> Gauss was running intensive computations since last week but yesterday
> night and today morning it shutdown.
> Now I'm suspecting jc42 sensor is causing this problem.
> 

Kind of unlikely. The sometimes wrong readings suggest that the i2c connection
to the memory chips may be flaky. Another question would be if you have
configured acpi_enforce_resources=lax in your boot command line to be able to
read the sensors. If so, there may be a conflict between the BIOS and the jc42
driver trying to access the sensors.

Secondary question is if temperature limits are set correctly, the value of
those limits, and if the temperature ever comes close to that limit. The only
"default" activity performed by the jc42 driver is to enable the sensors. If the
temperature limits are not set or not set correctly, and the alert output from
the sensor chip is connected to a board reset or NMI, you might well observe
shutdowns.

However, the occassional error in reading sensor information is a real concern.
Again, there is either a problem in the I2C connection between the sensor and
the i2c controller, or the sensor is accessed from multiple sources at the same
time (ie you configured acpi_enforce_resources=lax).

Please post any relevant dmesg output as well as output from the "sensors"
command. That might help us tracking down the problem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
