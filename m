From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 06 Jul 2006 17:42:36 +0000
Subject: [lm-sensors] Winbond W83627HF - deactivated
Message-Id: <44AD4B8C.1010002@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Albert,

>> Probing for `Winbond W83627HF Super IO Sensors'
>>   Success... but not activated

Hmm strange.

Temperature Monitoring
    The Super I/O controller (W83627HF) performs the temperature monitoring
function and has inputs
    directly from two thermistors on the board. One thermistor is located near
the CPU and the other
    thermistor is located near the I/O Hub (Southbridge).
     NOTE               The ReadyBoard 800 requires a heatsink for all
                        processors, but no fan.

Maybe they just forgotten it to activate ....

Enter configuration mode

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87

select logical device 0xb - hw monitor
isaset -y 0x2e 0x2f 0x07 0xb

select base addr: (assuming 0x290 is safe, check /proc/ioports and see if the
0x290 - 0x29F is empty)

isaset -y 0x2e 0x2f 0x61 0x90
isaset -y 0x2e 0x2f 0x60 0x2

activate it:
isaset -y 0x2e 0x2f 0x30 0x1

Leave configuration mode
isaset -y -f 0x2e 0xaa


Now the modprobe or sensors-detect should work.

You will need to do this reprogramming every boot. If it works, please complain
to them so they will fix their BIOS.

Let me know if it works for you ;)

Regards,
Rudolf




