From: "d. d. gmane" <gmanesensors@dubin.org>
Date: Sun, 28 Oct 2007 15:43:12 +0000
Subject: Re: [lm-sensors] Intel DP35DP - P35 Sensor Support?
Message-Id: <4724AE10.3070405@dubin.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4531394786239850053=="
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071015T022008-788@post.gmane.org>
In-Reply-To: <loom.20071015T022008-788@post.gmane.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============4531394786239850053==
Content-Type: multipart/alternative;
	boundary="------------040105000106020906010206"

This is a multi-part message in MIME format.
--------------040105000106020906010206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the response.  Below is what I get with the latest 
release...I am unable to gather the fan data or motherboard temps.  
Using lmsensors with my prior motherboard (a 975xbx), I was able to 
gather the data.  I mention this because I know that I'm using the same 
case fans, hence they work.  As a side note, the BIOS hardware 
monitoring does display the case fans as well.

Full details here -- are there other scans/probes that you would recommend?

[root@skippy detect]# ./sensors-detect
# sensors-detect revision 4966 (2007-10-20 01:41:53 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 4000 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: NVIDIA i2c adapter  (i2c-1)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter  (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter  (i2c-3)
Do you want to scan it? (YES/no/selectively):

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   Yes
Found `Nat. Semi. PC8374L Super IO Sensors'                
    (but not activated)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# Chip drivers
modprobe coretemp
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):
[root@skippy detect]#


Jean Delvare wrote:
> On Mon, 15 Oct 2007 02:23:17 +0000 (UTC), d.d. wrote:
>   
>> I'm seeing only 2 CPU core temperatures, but am unable to pick off any other
>> sensors (but I know they are there...)
>>
>> Any luck with the Intel Desktop DP35DP Motherboard / P35 / ICH9 ?
>>     
>
> The ICH9 integrates sensors we don't support yet. Your motherboard may
> or may not use these.
>
>   
>> Running Linux Kernel:
>> 2.6.22.9-91.fc7 #1 SMP Thu Sep 27 20:47:39 EDT 2007 x86_64 x86_64 x86_64
>> GNU/Linux
>>     
>
> Did you try running the latest version of sensors-detect? What did it
> find?
>
>   

--------------040105000106020906010206
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Thank you for the response.&nbsp; Below is what I get with the latest
release...I am unable to gather the fan data or motherboard temps.&nbsp;
Using lmsensors with my prior motherboard (a 975xbx), I was able to
gather the data.&nbsp; I mention this because I know that I'm using the same
case fans, hence they work.&nbsp; As a side note, the BIOS hardware
monitoring does display the case fans as well.<br>
<br>
Full details here -- are there other scans/probes that you would
recommend?<br>
<br>
[root@skippy detect]# ./sensors-detect<br>
# sensors-detect revision 4966 (2007-10-20 01:41:53 -0700)<br>
<br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you're doing.<br>
<br>
We can start with probing for (PCI) I2C or SMBus adapters.<br>
Do you want to probe now? (YES/no): <br>
Probing for PCI bus adapters...<br>
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9<br>
<br>
We will now try to load each adapter module in turn.<br>
Module `i2c-i801' already loaded.<br>
If you have undetectable or unsupported adapters, you can have them<br>
scanned by manually loading the modules before running this script.<br>
<br>
To continue, we need module `i2c-dev' to be loaded.<br>
Do you want to load `i2c-dev' now? (YES/no): <br>
Module loaded successfully.<br>
<br>
We are now going to do the I2C/SMBus adapter probings. Some chips may<br>
be double detected; we choose the one with the highest confidence<br>
value in that case.<br>
If you found that the adapter hung after probing a certain address,<br>
you can specify that address to remain unprobed.<br>
<br>
Next adapter: SMBus I801 adapter at 4000 (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x44<br>
Probing for `Maxim MAX6633/MAX6634/MAX6635'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x51<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x52<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x53<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Next adapter: NVIDIA i2c adapter&nbsp; (i2c-1)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
<br>
Next adapter: NVIDIA i2c adapter&nbsp; (i2c-2)<br>
Do you want to scan it? (YES/no/selectively): <br>
<br>
Next adapter: NVIDIA i2c adapter&nbsp; (i2c-3)<br>
Do you want to scan it? (YES/no/selectively): <br>
<br>
Some chips are also accessible through the ISA I/O ports. We have to<br>
write to arbitrary I/O ports to probe them. This is usually safe though.<br>
Yes, you do have ISA I/O ports even if you do not have any ISA slots!<br>
Do you want to scan the ISA I/O ports? (YES/no): <br>
Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM78-J' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83782D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Silicon Integrated Systems SIS5595'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `VIA VT82C686 Integrated Sensors'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `VIA VT8231 Integrated Sensors'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some Super I/O chips may also contain sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>
Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
Found `Nat. Semi. PC8374L Super IO Sensors'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; (but not activated)<br>
Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `VIA/Winbond/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some CPUs or memory controllers may also contain embedded sensors.<br>
Do you want to scan for them? (YES/no): <br>
AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD K10 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success!<br>
&nbsp;&nbsp;&nbsp; (driver `coretemp')<br>
Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Now follows a summary of the probes I have just done.<br>
Just press ENTER to continue: <br>
<br>
Driver `coretemp' (should be inserted):<br>
&nbsp; Detects correctly:<br>
&nbsp; * Chip `Intel Core family thermal sensor' (confidence: 9)<br>
<br>
I will now generate the commands needed to load the required modules.<br>
Just press ENTER to continue: <br>
<br>
To load everything that is needed, add this to some /etc/rc* file:<br>
<br>
#----cut here----<br>
# Chip drivers<br>
modprobe coretemp<br>
# sleep 2 # optional<br>
/usr/bin/sensors -s # recommended<br>
#----cut here----<br>
<br>
If you have some drivers built into your kernel, the list above will<br>
contain too many modules. Skip the appropriate ones! You really<br>
should try these commands right now to make sure everything is<br>
working properly. Monitoring programs won't work until the needed<br>
modules are loaded.<br>
<br>
Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): <br>
[root@skippy detect]# <br>
<br>
<br>
Jean Delvare wrote:
<blockquote cite="mid:20071028152612.63bd58e5@hyperion.delvare"
 type="cite">
  <pre wrap="">On Mon, 15 Oct 2007 02:23:17 +0000 (UTC), d.d. wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I'm seeing only 2 CPU core temperatures, but am unable to pick off any other
sensors (but I know they are there...)

Any luck with the Intel Desktop DP35DP Motherboard / P35 / ICH9 ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The ICH9 integrates sensors we don't support yet. Your motherboard may
or may not use these.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Running Linux Kernel:
2.6.22.9-91.fc7 #1 SMP Thu Sep 27 20:47:39 EDT 2007 x86_64 x86_64 x86_64
GNU/Linux
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Did you try running the latest version of sensors-detect? What did it
find?

  </pre>
</blockquote>
</body>
</html>

--------------040105000106020906010206--


--===============4531394786239850053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4531394786239850053==--
