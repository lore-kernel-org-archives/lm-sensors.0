From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 30 Aug 2005 21:00:33 +0000
Subject: [lm-sensors] VGN-S4
Message-Id: <20050830210008.2bc7c217.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43136363.5050507@gmail.com>
In-Reply-To: <43136363.5050507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Knefas,

> I have a sony vaio VGN-S4 and lm_sensors doens't recognize any
> hardware sensor.

This is expected. Sony Vaio laptops almost never have hardware
monitoring chips lm_sensors can drive.

The only thing you can use on these laptops for monitoring is the ACPI
thermal zone (/proc/acpi/thermal_zone/ATF0/temperature.)

> I've seen that in 2.9.2
> 
> Program sensors: Support the VAIO "VGN" prefix for eeprom
> 
> I hope this will support my eeprom too.

It will, but this isn't very helpful, as the decode-vaio.pl script does
a much better job than sensors for these EEPROMs anyway. And the time
will come (soon) when sensors doesn't decode EEPROMs at all anymore -
after all these are not sensors.

Oh, BTW, maybe you should change your laptop's password now that you
exposed it to the world...

-- 
Jean Delvare
