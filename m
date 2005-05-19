From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Sensors wrapup?
Message-Id: <3DE2C5AE.8CAFA691@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021115140810.GA15246@rdlg.net>
In-Reply-To: <20021115140810.GA15246@rdlg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

sorry, none of us have this board, so we don't have the "definitive"
answers.
You may wish to correspond with some of the folks referenced in the
tickets.
good luck.
mds

"Robert L. Harris" wrote:
> 
>   I'm reading through the "old news" and current tickets concerning the
> tyan 2466.  Using the difinitive sensors.conf from ticket 941 and the
> default "modules options" I get this:
> 
> root@rharris-build1.acs:~# sensors
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD768 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.69 V  (min =  +1.66 V, max =  +1.82 V)
> VCore 2:   +1.71 V  (min =  +1.66 V, max =  +1.82 V)
> +3.3V:     +3.34 V  (min =  +3.13 V, max =  +3.45 V)
> +12V:     +11.66 V  (min = +10.80 V, max = +13.20 V)
> -12V:     -12.70 V  (min = -13.21 V, max = -10.90 V)
> CPU1 Fan: 4856 RPM  (min = 3000 RPM, div = 2)
> CPU2 Fan: 4821 RPM  (min = 3000 RPM, div = 2)
> Ch Fan 4:    0 RPM  (min = 3000 RPM, div = 2)
> VRM 1:       +47?C  (limit =  +60?C)                       sensor = 3904 transistor
> AGP:        +5.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor   ALARM
> DDR:        +4.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = 3904 transistor
> vid2:     +1.750 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
> 
> (I did disable the eeprom as it only gives me a list of how much ram is
> in the system).
> 
> With this system I've seen people saying they're getting the actual
> CPU temps, not just the motherboard temps.
> 
> Can you give a 'wrapup' of what the current set of options for
> /etc/modutils/local should be and or any force_subclients?  If you can't
> post a "use XXXXXXXXXXXXXXX" then a how to find the values would be
> great.  I tried a number of different compinations that I dug up in
> /proc/ and on the boards but nothing ever changed.  There doesn't seem
> to be a difinitive "do this with modutils" or "use these
> force_subclients" anywhere I can find just "you need to use
> force_subclients".
> 
> Thanks for all your work,
>   Robert
> 
> :wq!
> ---------------------------------------------------------------------------
> Robert L. Harris                     | PGP Key ID: FC96D405
> 
> DISCLAIMER:
>       These are MY OPINIONS ALONE.  I speak for no-one else.
> FYI:
>  perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
