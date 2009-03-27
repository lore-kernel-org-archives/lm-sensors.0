From: Craig MacFarlane <camacfarl@gmail.com>
Date: Fri, 27 Mar 2009 21:09:11 +0000
Subject: [lm-sensors] Repeated starts for the i2c-801.c adapter?
Message-Id: <e96eb2570903271409s2692741dpe79dbb3fd0d88a77@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm working on a project that uses a smm665 that contains a small
eeprom device on an i2c bus connected to an intel ICH9.

The datasheet for the smm665 specifies that a eeprom read needs
a repeated start.

Figure 24 here:

  http://www.summitmicro.com/prod_select/summary/SMM665/SMM665B_2089_20.pdf

Does anyone happen to know if this adapter supports repeated starts?
The kernel version I'm currently using (admittedly a bit old) does not
appear to do so.

Needless to say, vanilla reads using the smbus api don't work for this
device (but do for an atmel eeprom that I also have access to).

Thanks,
Craig

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
