From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: robustified adm1021
Message-Id: <3E1F74AD.9060107@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E173681.3050806@paradyne.com>
In-Reply-To: <3E173681.3050806@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

actually I meant alarms = chip | fail.
So the 'sensors' program would say "ALARM" if the read failed -
no changes to 'sensors' required.

Ky?sti M?lkki wrote:
> On Tue, 7 Jan 2003, Mark Studebaker wrote:
> 
> 
>>Another idea I had was that, on read failure, the driver would set the
>>appropriate "alarms" bit in /proc. In other words the "alarms" entry
>>in /proc would be the logical OR of the alarms register in the chip
>>and the driver's internal "fail" bit register.
>>This wouldn't require any new /proc entries, and works with
>>"sensors" and other libsensors programs unchanged.
>>What do you think of that?
> 
> 
> Might be the easiest solution, if you mean alarms = chip|(fail<<8) ?
> 
> 
> 
>>The lm75 and adm1021 drivers were accepted, and i2c-proc has been
>>in the kernel for quite a while. I'm not at all inclined to
>>stir things up on LKML.
> 
> 
> While sensors don't use the client->driver->command() method at all, it
> is crucial for video4linux drivers. I would like to have something like:
> 
> /dev/i2c/host0/bus0/50-eeprom
>                  ../61-tuner
>                  ../80-msp3400
> 
> /dev/wbr/tuner -> /dev/i2c/host0/bus0/61-tuner
> /dev/wbr/demod -> /dev/i2c/host0/bus0/80-msp3400
> 
> Here, wbr could stand for wideband receiver. I need some use for the
> analog tuner card in a few years time.
> 
