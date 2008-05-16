From: Angela Palladino <a.palladino@gmail.com>
Date: Fri, 16 May 2008 12:14:12 +0000
Subject: [lm-sensors] bmcsensors error
Message-Id: <482d7a96.05a0660a.32e5.ffff92d6@mx.google.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Yani,

I have a Sun Netra 4200 and I need to get temperature using 
lm_sensors. I downloaded bmcsensors for my kernel (I'm using Red Hat 
Enterprise 4 Update 4 WS with kernel 2.6.9-42.ELsmp), I installed it 
and then I load the modules in this order: i2c-isa, ipmi_msghandler, 
ipmi_si, i2c_ipmi and bmcsensors.

The output of dmesg is the following:

ipmi message handler version 33.13
IPMI System Interface driver version 33.13, KCS version 33.13, SMIC 
version 33.13, BT version 33.13
ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca4, 
slave address 0x20
  IPMI kcs interface initialized
i2c-ipmi.o
i2c-ipmi.o: Registered IPMI interface 0 with version 2.0
i2c-ipmi.o: BMC access for i2c modules initialized.
bmcsensors.o
bmcsensors.o: Registered client, scanning for sensors...
bmcsensors.o: Too many reservations cancelled, giving up

and this the output of "sensors" command:

bmc-i2c-1-00
Adapter: IPMI adapter

Have you any suggestion?

Thank you in advance,

Angela


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
