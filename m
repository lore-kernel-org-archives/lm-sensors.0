From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sat, 20 Aug 2005 09:32:45 +0000
Subject: [lm-sensors] Working on Abit Uguru driver
Message-Id: <4306DCBF.4000003@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

2 months ago bought an Abit KV8 Pro motherboard, because I thought it 
was well supported under Linux. And to be fair it is well supported 
under Linux except for the @#$% Uguru chip.

I've kindly requested Abit for programming info, and I believe you 
already know the answer (NO).

I did however find this little GPL openguru program on the internet 
written by Olle Sandberg <ollebull@gmail.com>. You can find this program 
at: http://hem.bredband.net/b330708/oguru/oguru.tar.gz

This program only supports reading the actual sensor values and does not 
support reading/setting min/max and reading alarms. I've written an 
lmsensors chip driver for the abituguru chip based on this program. This 
driver thus is limited to only reading the sensor values like the 
openguru program.

In my enthousiasm to get my abituguru sensors supported I didn't read
doc/developers/new_drivers, but instead started working on a driver 
immediatly, using the drivers (specific the via686a) in the 2.6 kernel 
tree as a base.

Currently I've a working 2.6 driver, it reports correct values when 
catting /sys/bus/i2c/devices/xxx/xxx_input. I've made up an I2C_ID for 
now, can you provide me with one?

I still have a problem with my current driver sensors does see the 
client (I've added it and a bunch of label statements to sensors.conf), 
but doesn't report any values for it, do you know what could be the 
cause of this?

Last question. What todo now, I assume I need to port my driver to your 
current CVS tree. Can you explain the difference between the in kernel 
stuff and your stuff. And why is there a difference in the first place?

Regards,

Hans

p.s.

I know you're not enthousiastic about supporting sensorchips without 
proper datasheets. But since I wanted to get this chip supported I've 
just bitten the bullet. I promise I'll handle all support for THIS chip.
