From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 15 Mar 2011 18:15:00 +0000
Subject: Re: [lm-sensors] [PATCH resend] sensors: Add support for additional
Message-Id: <1300212900.20292.74.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110210030757.GA22858@ericsson.com>
In-Reply-To: <20110210030757.GA22858@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, 2011-03-15 at 13:48 -0400, Jean Delvare wrote:
[ ... ]
> > > > However, that overlaps with "max" for the new SENSORS_SUBFEATURE_POWER_MAX.
> > > > 
> > > > I've changed the highest output to to "hmax" to lift the limitation.
> > > > Not optimal, since there is still the average max which is also displayed
> > > > as "max". Please let me know if you have a better idea.
> > > 
> > > Instant and average power sensors are supposed to be mutually
> > > exclusive, and so are their limits, so I don't see any problem here.
> > > 
> > Should I use "lowest" and "highest" here as well for consistency ?
> 
> Yes, please.
> 
Ok. 

Regarding formatting, there is also "emergency" and "emergency hyst".
Also, there can be temperature limits above 100C, which affects
formatting as well. So it won't be easy to keep everything aligned.

Some sample output:

max6696-i2c-1-19
Adapter: Phalanx i2c channel 1
temp1:        +21.6 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emergency = +90.0 C, emergency hyst = +80.0 C)
temp2:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (MIN)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emergency = +120.0 C, emergency hyst = +110.0 C)
temp3:          FAULT  (low  = -55.0 C, high = +70.0 C)  ALARM (MIN)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emergency = +120.0 C, emergency hyst = +110.0 C)

max6696-i2c-100-18
Adapter: SMBus I801 adapter at 5080
temp1:        +22.4 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +70.0 C, crit hyst = +60.0 C)
                       (emergency = +90.0 C, emergency hyst = +80.0 C)
temp2:        +81.1 C  (low  = -55.0 C, high = +70.0 C)  ALARM (MAX)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emergency = +120.0 C, emergency hyst = +110.0 C)
temp3:        +22.8 C  (low  = -55.0 C, high = +70.0 C)
                       (crit = +90.0 C, crit hyst = +80.0 C)
                       (emergency = +120.0 C, emergency hyst = +110.0 C)
jc42-i2c-100-1a
Adapter: SMBus I801 adapter at 5080
temp1:        +26.2 C  (low  =  +0.0 C, high =  +0.0 C)  ALARM (MAX,
CRIT)
                       (hyst =  +0.0 C, crit =  +0.0 C)
                       (crit hyst =  +0.0 C)

lineage_pem-i2c-61-45
Adapter: i2c-55-mux (chan_id 0)
in1:          +0.00 V                                    ALARM (MAX)
in2:          +0.00 V                                    ALARM
fan1:             N/A
temp1:        +34.0 C  (high = +97.0 C, crit = +107.0 C)
power1:        0.00 nW  
curr1:        +0.00 A  


Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
