From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: LM Sensors problems
Message-Id: <3C50B879.3A62166B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A1: fix in /etc/sensors.conf
A2: don't know about "lvcool", is it also accessing sensor data?
    perhaps there is a locking problem?
A3: LM80 is often misdetected, you probably have something else,
    look at your motherboard to verify.
B1: See A3 above for LM80. Via686 data doesn't look that bad.

mds


Timothy Covell wrote:
> 
> Hi.  I've had a couple problems, one somewhat serious
> when using lm sensors.
> 
> System A:  Duron 800 MHz on KT133A MoBo
> Sensors output: attached file: sensors.out
> Modules:
> 
> i2c-voodoo3             2720   0 (unused)
> i2c-algo-bit            6880   2 [i2c-voodoo3]
> eeprom                  3056   0 (unused)
> via686a                 8256   0 (unused)
> lm80                    5216   0 (unused)
> sensors                 6320   0 [eeprom via686a lm80]
> i2c-isa                 1136   0 (unused)
> i2c-viapro              3856   0 (unused)
> i2c-core               12832   0 [i2c-algo-bit eeprom via686a lm80 sensors
> i2c-isa i2c-viapro]
> 
> Problem 1: CPU/System temperatures should be swapped
> 
> Problem 2: When running "lvcool" to try to cool better, the
> sensors program hangs after printing out data and only a
> reboot will kill cpu hogging "zombie".
> 
> Problem 3: lm80 data is completely meaningless and all backwards
> 
> System B: Via C3 on VT82C694X based MoBo.
> 
> Problem: Output is meaningless, see attached file gauss.sensors.out
> 
> Thanks.
> 
> --
> timothy.covell@ashavan.org.
> 
> 
>                   Name: sensors.out
>    sensors.out    Type: Plain Text (text/plain)
>               Encoding: base64
> 
>                         Name: gauss.sensors.out
>    gauss.sensors.out    Type: Plain Text (text/plain)
>                     Encoding: base64
