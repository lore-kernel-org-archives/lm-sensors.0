From: kevins@tyan.com (kevin schlichter)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket# 1566
Message-Id: <1076028170.5373.264.camel@debbi>
List-Id: <lm-sensors.vger.kernel.org>
References: <02f601c3ebf9$5dacdde0$c8de11cc@black>
In-Reply-To: <02f601c3ebf9$5dacdde0$c8de11cc@black>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Your readings all look fine to me.  Are your assumptions based on the
min= and max= settings in the /etc/sensors.conf file?

It looks like the tolerances in the sensors.conf file aren't set
correctly, but I wouldn't pay too much attention to them anyway.  DDR V
doesn't have anything set at all, 3VSB should actually be 3.3VSB, and
your battery will be fine all the way down to something like 2.4V before
you start seeing CMOS errors on boot up.  For the sake of being
thorough, I'll post a new version of the .conf file on our website in a
few days.  Until then, I wouldn't worry about any of the readings you've
posted here (except maybe your CPU temps which seem to be hot).

On Thu, 2004-02-05 at 07:04, Mike Black wrote:
<clip>

    sensors now shows:
    w83782d-i2c-3-2d
    Adapter: SMBus AMD756 adapter at 80e0
    AGP V:     +1.52 V  (min =  +3.14 V, max =  +3.46 V)
    +5 V:     +4.89 V  (min =  +4.73 V, max =  +5.24 V)
    DDR V:     +1.23 V  (min =  +2.85 V, max =  +3.47 V)       <<<<<<<< low by more than 2X
    3 VSB:     +3.33 V  (min =  +2.85 V, max =  +3.15 V)        <<<<<<<< too high?
    Bat V:     +2.61 V  (min =  +2.64 V, max =  +3.95 V)         <<<<<<<< too low??
    CPU1 Fan: 3325 RPM  (min =   -1 RPM, div = 2)
    CPU2 Fan: 5000 RPM  (min =   -1 RPM, div = 2)
    chs1 Fan:    0 RPM  (min =   -1 RPM, div = 2)
    VRM2 Temp:   +52?C  (high =  +100?C)                     sensor = 3904 transistor
    CPU1 Temp: +49.5?C  (high =   +72?C, hyst =   +32?C)   sensor = 3904 transistor   ALARM
    CPU2 Temp: +50.0?C  (high =   +72?C, hyst =   +32?C)   sensor = 3904 transistor   ALARM
    alarms:   Chassis intrusion detection                      ALARM
    beep_enable:
             Sound alarm disabled

<clip>

    Michael D. Black mblack@csi-inc.com
    http://www.csi-inc.com/
    http://www.csi-inc.com/~mike
    321-676-2923, x203
    Melbourne FL
    
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040205/75b9cfbf/attachment.html
