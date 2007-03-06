From: den_tichel@zonnet.nl (Jan van Tiggelen)
Date: Tue, 06 Mar 2007 18:03:30 +0000
Subject: [lm-sensors] SMSC47m1 Error inserting and Not configured - will
Message-Id: <20070306180331.5E4483C20@mta-fe.casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070227220412.7D6195920@mta-fe.casema.nl>
In-Reply-To: <20070227220412.7D6195920@mta-fe.casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----Original Message-----
From: Jean Delvare [mailto:khali at linux-fr.org] 
Sent: Tuesday, March 06, 2007 3:59 PM
To: Jan van Tiggelen
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] SMSC47m1 Error inserting and Not configured - will
notuse errors

On Mon, 5 Mar 2007 21:46:46 +0100, Jan van Tiggelen wrote:
> Sorry for posting this message again. But since there's not reply to this
> topic at all, I was still hoping that someone could help out on the issue
> I've described below...
> 
> 
> -----Original Message-----
> From: lm-sensors-bounces at lm-sensors.org
> [mailto:lm-sensors-bounces at lm-sensors.org] On Behalf Of Jan van Tiggelen
> Sent: Tuesday, February 27, 2007 11:04 PM
> To: lm-sensors at lm-sensors.org
> Subject: [lm-sensors] SMSC47m1 Error inserting and Not configured - will
> notuse errors
> 
> The issue's been bugging me for a few days, but nevertheless I hope this
is
> an issue which can be sorted out. So here goes with the details:
> 
> FSC micro-atx mainboard (W26361-W39) with an SMC LPC47M107S-MC onboard (I
> physically checked the presence! ;) )
>  
> Installed Fedora Core 6
> 2.6.19-1.2911.fc6 
> i686 i686 i386 GNU/Linux
> 
> Sensors version 2.10.1 with libsensors version 2.10.1
> 
> Sensors-detect returns (as it seems) the proper values:
> modprobe.conf:
> # I2C module options
> alias char-major-89 i2c-dev
> 
> rc.local:
> # I2C adapter drivers
> modprobe i2c-i801
> modprobe i2c-isa
> # I2C chip drivers
> modprobe eeprom
> modprobe smsc47m1
> sleep 2 # optional
> /usr/bin/sensors -s # recommended
> 
> Everything seems to load properly:
> # lsmod |grep i2c
> i2c_isa                 9665  0
> i2c_ec                  9281  1 sbs
> i2c_i810                9797  0
> i2c_algo_bit           12105  1 i2c_i810
> i2c_i801               11853  0
> i2c_core               26049  5
i2c_isa,eeprom,i2c_ec,i2c_algo_bit,i2c_i801
> 
> But modprobe smsc47m1 seems to cause the initial error: 
> FATAL: Error inserting smsc47m1
> (/lib/modules/2.6.19-1.2911.fc6/kernel/drivers/hwmon/smsc47m1.ko): No such
> device
> 
> And dmesg returns:
> smsc47m1: Found SMSC LPC47M10x/LPC47M112/LPC47M13x
> i2c_adapter i2c-9191: Device at 0x800 is not configured, will not use

It means just what the message says: your Super-I/O chip is not
configured to monitor and control your fans. The pins are used for a
different functions.

Do you have any reason to believe that your fans are actually connected
to this chip?

-- 
Jean Delvare

-------------------
Jean, hi,

Honestly speaking I have no other reference (e.g. Windows) than this
installation to see what the chip is capable of reporting.

I'm assuming that, besides FAN-speeds, it also monitors and reports voltage
levels, etc... But I couldn't find any datasheet to support those thoughts.

So probably that leaves me with a motherboard of which I cannot monitor
anything... Or do you have any other suggestions to get readings of, let's
say CPU core temperature, etc...

Kind regards,

Jan van Tiggelen


