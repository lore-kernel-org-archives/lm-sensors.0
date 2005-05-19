From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: lm_sensors ticket #1287
Message-Id: <3EEE776A.8000704@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <001001c33432$c6e54830$6501a8c0@RICHARD>
In-Reply-To: <001001c33432$c6e54830$6501a8c0@RICHARD>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that's not good.
I'm stumped.
I'll email Corey Minyard and ask if he knows anything about the Winbond BMC.


Richard Au wrote:
> 
> Hi,
>  
> As you requested, I changed "0xca" to "0xc9" at line 668 in bmcsensors.c 
> (while leaving in #define DEBUG 1).  The relevant output of dmesg is now:
>  
> ###############################################################
> i2c-core.o: i2c core module version 2.7.0 (20021208)
> i2c-i801.o version 2.7.0 (20021208)
> i2c-i801.o: I801 bus detected and initialized
> i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
> i2c-dev.o: Registered 'SMBus I801 adapter at 1100' as minor 0
> i2c-proc.o version 2.7.0 (20021208)
> ipmi: message handler initialized
> ipmi_kcs: Acquiring BMC @ port=0xca2
> i2c-isa.o version 2.7.0 (20021208)
> i2c-dev.o: Registered 'ISA main adapter' as minor 1
> i2c-isa.o: ISA bus access for i2c modules initialized.
> i2c-proc.o version 2.7.0 (20021208)
> eeprom.o version 2.7.0 (20021208)
> i2c-ipmi.o version 2.7.0 (20021208)
> i2c-dev.o: Registered 'IPMI adapter' as minor 2
> i2c-ipmi.o: Registered IPMI interface 0 with version 1.0
> i2c-ipmi.o: BMC access for i2c modules initialized.
> bmcsensors.o version 2.7.0 (20021208)
> bmcsensors.o: Registered client, scanning for sensors...
> bmcsensors.o: Send BMC msg, cmd: 0x22
> bmcsensors.o: Got first resid 0x0001
> bmcsensors.o: Get SDR 0x0 0x0 0x0
> bmcsensors.o: Send BMC msg, cmd: 0x23
> bmcsensors.o: Reducing SDR request size to 33
> bmcsensors.o: Get SDR 0x0 0x0 0x0
> bmcsensors.o: Send BMC msg, cmd: 0x23
> bmcsensors.o: Reducing SDR request size to 16
> bmcsensors.o: Get SDR 0x0 0x0 0x0
> bmcsensors.o: Send BMC msg, cmd: 0x23
> bmcsensors.o: Reducing SDR request size to 8
> bmcsensors.o: Get SDR 0x0 0x0 0x0
> bmcsensors.o: Send BMC msg, cmd: 0x23
> bmcsensors.o: IPMI buffers too small, giving up
> ###############################################################
>  
> Four your reference, here is the original dmesg output:
>  
> ###############################################################
> ipmi: message handler initialized
> ipmi_kcs: Acquiring BMC @ port=0xca2
> i2c-isa.o version 2.6.5 (20020915)
> i2c-dev.o: Registered ?ISA main adapter? as minor 1
> i2c-isa.o: ISA bus access for i2c modules initialized.
> i2c-proc.o version 2.7.0 (20021208)
> eeprom.o version 2.6.5 (20020915)
> i2c-ipmi.o version 2.7.0 (20021208)
> i2c-dev.o: Registered ?IPMI adapter? as minor 2
> i2c-ipmi.o: Registered IPMI interface 0 with version 1.0
> i2c-ipmi.o: BMC access for i2c modules initialized.
> bmcsensors.o version 2.7.0 (20021208)
> bmcsensors.o: Registered client, scanning for sensors...
> bmcsensors.o: Send BMC msg, cmd: 0x22
> bmcsensors.o: Got first resid 0x0001
> bmcsensors.o: Get SDR 0x0 0x0 0x0
> bmcsensors.o: Send BMC msg, cmd: 0x23
> bmcsensors.o: Error 0xc9 on cmd 0xa/0x23; state = 2; probably fatal.
> ###############################################################
>  
> Regards,
> Richard
