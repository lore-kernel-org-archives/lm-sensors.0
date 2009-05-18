From: madhu <madhu.chinakonda@gmail.com>
Date: Mon, 18 May 2009 18:31:48 +0000
Subject: Re: [lm-sensors] Support for  nuvoton(Winbond) W83627DHG-P ?
Message-Id: <1242670788.2944.68.camel@dhcppc0>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-V7AVINZtdIIO29xvTZiu"
List-Id: <lm-sensors.vger.kernel.org>
References: <1242369988.21111.53.camel@localhost.localdomain>
In-Reply-To: <1242369988.21111.53.camel@localhost.localdomain>
To: lm-sensors@vger.kernel.org


--=-V7AVINZtdIIO29xvTZiu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jean,

It was showing as 'W83627DHG-P' on the chip, and also confirmed here,
http://download.intel.com/support/motherboards/desktop/dg41ty/sb/e5279701_en.pdf (page 17).

Tried with the latest 'sensors-detect' and got the following (attached
the full result),

----------------
Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.           
Do you want to scan for Super I/O sensors? (YES/no):              
Probing for Super-I/O at 0x2e/0x2f                                
Trying family `National Semiconductor'...                   No    
Trying family `SMSC'...                                     No    
Trying family `VIA/Winbond/Fintek'...                       Yes   
Found unknown chip with ID 0xb073                                 
Probing for Super-I/O at 0x4e/0x4f                                
Trying family `National Semiconductor'...                   No    
Trying family `SMSC'...                                     No    
Trying family `VIA/Winbond/Fintek'...                       No    
Trying family `ITE'...                                      No    
------------------



Thanks,
Madhu,



On Mon, 2009-05-18 at 09:23 +0200, Jean Delvare wrote:
> Hi Madhu,
> 
> On Fri, 15 May 2009 12:51:56 +0530, Madhu wrote:
> >    I have nuvoton(Winbond) W83627DHG-P Super I/O controller chip on the
> > Intel DG41TY motherboard. 
> > 
> >    I see the kernel supports W83627DHG but not the W83627DHG-P and
> > sensor-detect fails. I am using the latest 2.6.30-rc2 on F11.
> > 
> >    Is there any plans to support this chip? 
> 
> I am not aware of a significantly different "P" variant of the
> W83627DHG. Please try the latest version of the sensors-detect script:
> 
> http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> 
> and report the full output.
> 

--=-V7AVINZtdIIO29xvTZiu
Content-Disposition: attachment; filename="sensors-detect.log"
Content-Type: text/x-log; name="sensors-detect.log"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[root@dhcppc0 Desktop]# ./sensors-detect                                                                                                                                                       
Stopping lm_sensors:                                       [  OK  ]                                                                                                                            
# sensors-detect revision 5715 (2009-05-08 10:37:41 +0200)                                                                                                                                     
# Board: Intel Corporation DG41TY                                                                                                                                                              

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe  
and recommended to accept the default answers to all questions,   
unless you know what you're doing.                                

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):           
Silicon Integrated Systems SIS5595...                       No          
VIA VT82C686 Integrated Sensors...                          No          
VIA VT8231 Integrated Sensors...                            No          
AMD K8 thermal sensors...                                   No          
AMD K10 thermal sensors...                                  No          
Intel Core family thermal sensor...                         Success!    
    (driver `coretemp')                                                 
Intel AMB FB-DIMM thermal sensor...                         No          
VIA C7 thermal and voltage sensors...                       No          

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.           
Do you want to scan for Super I/O sensors? (YES/no):              
Probing for Super-I/O at 0x2e/0x2f                                
Trying family `National Semiconductor'...                   No    
Trying family `SMSC'...                                     No    
Trying family `VIA/Winbond/Fintek'...                       Yes   
Found unknown chip with ID 0xb073                                 
Probing for Super-I/O at 0x4e/0x4f                                
Trying family `National Semiconductor'...                   No    
Trying family `SMSC'...                                     No    
Trying family `VIA/Winbond/Fintek'...                       No    
Trying family `ITE'...                                      No    

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it    
there, we have to read from arbitrary I/O ports to probe for such       
interfaces. This is normally safe. Do you want to scan for IPMI         
interfaces? (YES/no):                                                   
Probing for `IPMI BMC KCS' at 0xca0...                      No          
Probing for `IPMI BMC SMIC' at 0xca8...                     No          

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually  
safe though. Yes, you do have ISA I/O ports even if you do not have any 
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):             
Probing for `National Semiconductor LM78' at 0x290...       No          
Probing for `National Semiconductor LM79' at 0x290...       No          
Probing for `Winbond W83781D' at 0x290...                   No          
Probing for `Winbond W83782D' at 0x290...                   No          

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.                                                      
Do you want to probe the I2C/SMBus adapters now? (YES/no):            
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7    
WARNING: Deprecated config file /etc/modprobe.conf, all config files belong into /etc/modprobe.d/.
WARNING: All config files need .conf: /etc/modprobe.d/blacklist-visor, it will be ignored in a future release.
WARNING: All config files need .conf: /etc/modprobe.d/blacklist, it will be ignored in a future release.      
WARNING: All config files need .conf: /etc/modprobe.d/floppy-pnp, it will be ignored in a future release.     
WARNING: All config files need .conf: /etc/modprobe.d/modprobe.conf.dist, it will be ignored in a future release.
Module i2c-dev loaded successfully.                                                                              

Next adapter: intel drm CRTDDC_A (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x49                  
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50                                  
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: intel drm HDMIC (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus I801 adapter at 0400 (i2c-2)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
Starting lm_sensors: loading module coretemp               [  OK  ]
Unloading i2c-dev... OK
[root@dhcppc0 Desktop]#

--=-V7AVINZtdIIO29xvTZiu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-V7AVINZtdIIO29xvTZiu--

