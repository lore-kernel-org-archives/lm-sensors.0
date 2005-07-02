From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 02 Jul 2005 18:37:37 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <42C6C2C3.9050201@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Eric J. Bowersox wrote:
> On Thu, 2005-06-30 at 18:33, Mark Studebaker wrote:
> 
>>you want hyst (hysteresis) to be high, like 68.
>>The alarm isn't cleared until the temperature goes below the hysteresis value.
> 
> 
> I just tried that on one of the nodes in question.  Didn't help.  Even
> with all tempN_over values set to 80 and all tempN_hyst values set to
> 75, the output of "sensors" still displays "ALARM" by the two CPU
> temperatures (which currently read 46 and 49 respectively), and the
> front-panel temperature light still blinks.  (The output of "sensors"
> did show that the two limits were set correctly by "sensors -s" though.)

Hello,

Please can you dump content of the chip before you will load the driver and after you will load?
(no sensors -s running)

You can do that like this:

1) run sensors command
2) get the bus and chip address, i will use 0 and 0x2f as example
3) reboot
4) load only i2c bus driver and i2c-dev module (you must somehow disable the automatic loading during startup)
5) i2cdump -y 0 0x2f >firstdump
6) modprobe w83792d
7) i2cdump -y 0 0x2f >seconddump

Also I would like to know which version of the driver did you used.
Was it http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/8dfe2e28/patch_w83792d-2.6.12-0001.gz ?
(note you can patch your kernel even if this is called 2.6.12)

Thanks

Regards
Rudolf
