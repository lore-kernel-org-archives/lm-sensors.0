From: bertrik@zonnet.nl (Bertrik Sikken)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Driver w83781d for lm_sensors
Message-Id: <3E5DCB7F.8060606@zonnet.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mikolaj Tutak wrote:

>I have tested your W83781D driver with may Asus MB (A7V333, Asus chip
>ASB100A) and I have discovered that temperature readings are wrong (BIOS
>shows other values) :-(
>
>Anyway I made some changes to your driver (only AS99127F/ASB100A part),
>the idea was taken from "xmbmon".
>
>Changes:
>
>- new temperature sensor on address 0x17, named temp2 (works similar to
>temp1 on 0x27, but connected with CPU temperature sensor). Readings from
>0x17 show the same values like monitor built in MB BIOS - this readings
>has less latency (CPU internal diode?).
>
>- temp2 sensor renamed to temp3 (another CPU temperature sensor,
>probably connected with thermistor under CPU - higher lattency). ASUS
>doesn't show this values in BIOS monitor!
>
>- temp3 sensor removed (unconnected?) - maybe better keep and rename to
>temp4?
>
>- removed macro AS99127_TEMP_ADD_TO_REG & AS99127_TEMP_ADD_FROM_REG -
>standard one works _better_!
>
>TODO:
>
>- find right addresses for AS99127_REG_TEMP_OVER &
>AS99127_REG_TEMP_HIST!
>
I did some research on the undocumented temperature registers, it's at
http://home.kabelfoon.nl/~bertrik/asb100/asb100.html

Maybe you are looking for registers 0x18 and 0x19 ?

I think I also found an undocumented motherboard temperature
plus hist and over temp, at registers 0x1a, 0x1b and 0x1c.

Regards,
Bertrik Sikken

P.S. Your message was somehow classified as spam by the mailing list filter.
