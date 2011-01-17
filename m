From: DarkNovaNick@gmail.com
Date: Mon, 17 Jan 2011 20:26:54 +0000
Subject: [lm-sensors] Sandy Bridge support?
Message-Id: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2842409114854830882=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2842409114854830882==
Content-Type: multipart/alternative; boundary=0022152d6d71d9f4ff049a109aff

--0022152d6d71d9f4ff049a109aff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes

I recently bought the new Intel Sandy Bridge processor, i5-2500k, along  
with a Gigabyte GA-H67A-UD3H motherboard. I've used lm_sensors in the past  
and am trying to get it to work with my new setup (on Ubuntu 10.10 kernel  
2.6.35-24). I downloaded the latest version of the sensors-detect script  
from the website and it was not able to find any sensors. Here is the  
output:

---------

# sensors-detect revision 5901 (2011-01-14 17:11:54 +0100)
# System: Gigabyte Technology Co., Ltd. H67A-UD3H

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595... No
VIA VT82C686 Integrated Sensors... No
VIA VT8231 Integrated Sensors... No
AMD K8 thermal sensors... No
AMD Family 10h thermal sensors... No
AMD Family 11h thermal sensors... No
Intel Core family thermal sensor... No
Intel Atom thermal sensor... No
Intel AMB FB-DIMM thermal sensor... No
VIA C7 thermal sensor... No
VIA Nano thermal sensor... No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'... No
Trying family `SMSC'... No
Trying family `VIA/Winbond/Nuvoton/Fintek'... No
Trying family `ITE'... Yes
Found unknown chip with ID 0x8728
(logical device 4 has address 0x290, could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'... No
Trying family `SMSC'... No
Trying family `VIA/Winbond/Nuvoton/Fintek'... No
Trying family `ITE'... No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0... No
Probing for `IPMI BMC SMIC' at 0xca8... No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290... No
Probing for `National Semiconductor LM79' at 0x290... No
Probing for `Winbond W83781D' at 0x290... No
Probing for `Winbond W83782D' at 0x290... No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)
Module i2c-i801 loaded successfully.
Module i2c-dev loaded successfully.

Next adapter: saa7133[0] (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Next adapter: NVIDIA i2c adapter (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-3)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-4)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-5)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... No
Probing for `EDID EEPROM'... Yes
(confidence 8, not a hardware monitoring chip)

Next adapter: NVIDIA i2c adapter (i2c-6)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-7)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter (i2c-8)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus I801 adapter at 0500 (i2c-9)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4e
Probing for `National Semiconductor LM75'... No
Probing for `Dallas Semiconductor DS75'... No
Probing for `Dallas Semiconductor DS1621/DS1631'... No
Probing for `Analog Devices ADM1021'... No
Probing for `Analog Devices ADM1021A/ADM1023'... No
Probing for `Maxim MAX1617'... No
Probing for `Maxim MAX1617A'... No
Probing for `Maxim MAX1668'... No
Probing for `Maxim MAX1805'... No
Probing for `Maxim MAX1989'... No
Probing for `Maxim MAX6655/MAX6656'... No
Probing for `TI THMC10'... No
Probing for `National Semiconductor LM84'... No
Probing for `Genesys Logic GL523SM'... No
Probing for `Onsemi MC1066'... No
Probing for `Maxim MAX1618'... No
Probing for `Maxim MAX1619'... No
Probing for `National Semiconductor LM82/LM83'... No
Probing for `Maxim MAX6654'... No
Probing for `Maxim MAX6690'... No
Probing for `Maxim MAX6659'... No
Probing for `Maxim MAX6647'... No
Probing for `Maxim MAX6680/MAX6681'... No
Probing for `Maxim MAX6695/MAX6696'... No
Probing for `Texas Instruments TMP411'... No
Probing for `Texas Instruments TMP421'... No
Probing for `Texas Instruments TMP422'... No
Probing for `Texas Instruments AMC6821'... No
Probing for `National Semiconductor LM64'... No
Probing for `National Semiconductor LM73'... No
Probing for `Maxim MAX6633/MAX6634/MAX6635'... No
Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)'... No
Probing for `Fintek F75111R/RG/N (GPIO)'... No
Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R'... Yes
(confidence 6, not a hardware monitoring chip)
Client found at address 0x50
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... No
Probing for `EDID EEPROM'... No
Client found at address 0x51
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... No
Client found at address 0x52
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... No
Client found at address 0x53
Probing for `Analog Devices ADM1033'... No
Probing for `Analog Devices ADM1034'... No
Probing for `SPD EEPROM'... No

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

----------------

I also tried running i2c-detect on "SMBus I801 adapter at 0500", here is  
the output:

-------------

0 1 2 3 4 5 6 7 8 9 abcdef
00: -- -- -- -- -- 08 -- -- -- -- -- -- --
10: 10 11 -- 13 14 15 -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- 4e --
50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

------------

Is there anything else I can do to get this working, or help by providing  
some more info, or is just a matter of waiting until there is support for  
Sandy Bridge? Or am I doing something wrong? Thanks,

Nick

--0022152d6d71d9f4ff049a109aff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I recently bought the new Intel Sandy Bridge processor, i5-2500k, along wit=
h a Gigabyte GA-H67A-UD3H motherboard. I&#39;ve used lm_sensors in the past=
 and am trying to get it to work with my new setup (on Ubuntu 10.10 kernel =
2.6.35-24). I downloaded the latest version of the sensors-detect script fr=
om the website and it was not able to find any sensors. Here is the output:=
<br /><br />---------<br /><br /># sensors-detect revision 5901 (2011-01-14=
 17:11:54 +0100)<br /># System: Gigabyte Technology Co., Ltd. H67A-UD3H<br =
/><br />This program will help you determine which kernel modules you need<=
br />to load to use lm_sensors most effectively. It is generally safe<br />=
and recommended to accept the default answers to all questions,<br />unless=
 you know what you&#39;re doing.<br /><br />Some south bridges, CPUs or mem=
ory controllers contain embedded sensors.<br />Do you want to scan for them=
? This is totally safe. (YES/no): <br />Silicon Integrated Systems SIS5595.=
..                       No<br />VIA VT82C686 Integrated Sensors...        =
                  No<br />VIA VT8231 Integrated Sensors...                 =
           No<br />AMD K8 thermal sensors...                               =
    No<br />AMD Family 10h thermal sensors...                           No<=
br />AMD Family 11h thermal sensors...                           No<br />In=
tel Core family thermal sensor...                         No<br />Intel Ato=
m thermal sensor...                                No<br />Intel AMB FB-DIM=
M thermal sensor...                         No<br />VIA C7 thermal sensor..=
.                                    No<br />VIA Nano thermal sensor...    =
                              No<br /><br />Some Super I/O chips contain em=
bedded sensors. We have to write to<br />standard I/O ports to probe them. =
This is usually safe.<br />Do you want to scan for Super I/O sensors? (YES/=
no): <br />Probing for Super-I/O at 0x2e/0x2f<br />Trying family `National =
Semiconductor&#39;...                   No<br />Trying family `SMSC&#39;...=
                                     No<br />Trying family `VIA/Winbond/Nuv=
oton/Fintek&#39;...               No<br />Trying family `ITE&#39;...       =
                               Yes<br />Found unknown chip with ID 0x8728<b=
r />    (logical device 4 has address 0x290, could be sensors)<br />Probing=
 for Super-I/O at 0x4e/0x4f<br />Trying family `National Semiconductor&#39;=
...                   No<br />Trying family `SMSC&#39;...                  =
                   No<br />Trying family `VIA/Winbond/Nuvoton/Fintek&#39;..=
.               No<br />Trying family `ITE&#39;...                         =
             No<br /><br />Some systems (mainly servers) implement IPMI, a =
set of common interfaces<br />through which system health data may be retri=
eved, amongst other things.<br />We first try to get the information from S=
MBIOS. If we don&#39;t find it<br />there, we have to read from arbitrary I=
/O ports to probe for such<br />interfaces. This is normally safe. Do you w=
ant to scan for IPMI<br />interfaces? (YES/no): <br />Probing for `IPMI BMC=
 KCS&#39; at 0xca0...                      No<br />Probing for `IPMI BMC SM=
IC&#39; at 0xca8...                     No<br /><br />Some hardware monitor=
ing chips are accessible through the ISA I/O ports.<br />We have to write t=
o arbitrary I/O ports to probe them. This is usually<br />safe though. Yes,=
 you do have ISA I/O ports even if you do not have any<br />ISA slots! Do y=
ou want to scan the ISA I/O ports? (YES/no): <br />Probing for `National Se=
miconductor LM78&#39; at 0x290...       No<br />Probing for `National Semic=
onductor LM79&#39; at 0x290...       No<br />Probing for `Winbond W83781D&#=
39; at 0x290...                   No<br />Probing for `Winbond W83782D&#39;=
 at 0x290...                   No<br /><br />Lastly, we can probe the I2C/S=
MBus adapters for connected hardware<br />monitoring devices. This is the m=
ost risky part, and while it works<br />reasonably well on most systems, it=
 has been reported to cause trouble<br />on some systems.<br />Do you want =
to probe the I2C/SMBus adapters now? (YES/no): <br />Using driver `i2c-i801=
&#39; for device 0000:00:1f.3: Intel Cougar Point (PCH)<br />Module i2c-i80=
1 loaded successfully.<br />Module i2c-dev loaded successfully.<br /><br />=
Next adapter: saa7133[0] (i2c-0)<br />Do you want to scan it? (yes/NO/selec=
tively): <br /><br />Next adapter: NVIDIA i2c adapter  (i2c-1)<br />Do you =
want to scan it? (YES/no/selectively): <br /><br />Next adapter: NVIDIA i2c=
 adapter  (i2c-2)<br />Do you want to scan it? (YES/no/selectively): <br />=
<br />Next adapter: NVIDIA i2c adapter  (i2c-3)<br />Do you want to scan it=
? (YES/no/selectively): <br /><br />Next adapter: NVIDIA i2c adapter  (i2c-=
4)<br />Do you want to scan it? (YES/no/selectively): <br /><br />Next adap=
ter: NVIDIA i2c adapter  (i2c-5)<br />Do you want to scan it? (YES/no/selec=
tively): <br />Client found at address 0x50<br />Probing for `Analog Device=
s ADM1033&#39;...                     No<br />Probing for `Analog Devices A=
DM1034&#39;...                     No<br />Probing for `SPD EEPROM&#39;... =
                                No<br />Probing for `EDID EEPROM&#39;...   =
                             Yes<br />    (confidence 8, not a hardware mon=
itoring chip)<br /><br />Next adapter: NVIDIA i2c adapter  (i2c-6)<br />Do =
you want to scan it? (YES/no/selectively): <br /><br />Next adapter: NVIDIA=
 i2c adapter  (i2c-7)<br />Do you want to scan it? (YES/no/selectively): <b=
r /><br />Next adapter: NVIDIA i2c adapter  (i2c-8)<br />Do you want to sca=
n it? (YES/no/selectively): <br /><br />Next adapter: SMBus I801 adapter at=
 0500 (i2c-9)<br />Do you want to scan it? (YES/no/selectively): <br />Clie=
nt found at address 0x4e<br />Probing for `National Semiconductor LM75&#39;=
...                No<br />Probing for `Dallas Semiconductor DS75&#39;...  =
                No<br />Probing for `Dallas Semiconductor DS1621/DS1631&#39=
;...         No<br />Probing for `Analog Devices ADM1021&#39;...           =
          No<br />Probing for `Analog Devices ADM1021A/ADM1023&#39;...     =
       No<br />Probing for `Maxim MAX1617&#39;...                          =
    No<br />Probing for `Maxim MAX1617A&#39;...                            =
 No<br />Probing for `Maxim MAX1668&#39;...                              No=
<br />Probing for `Maxim MAX1805&#39;...                              No<br=
 />Probing for `Maxim MAX1989&#39;...                              No<br />=
Probing for `Maxim MAX6655/MAX6656&#39;...                      No<br />Pro=
bing for `TI THMC10&#39;...                                  No<br />Probin=
g for `National Semiconductor LM84&#39;...                No<br />Probing f=
or `Genesys Logic GL523SM&#39;...                      No<br />Probing for =
`Onsemi MC1066&#39;...                              No<br />Probing for `Ma=
xim MAX1618&#39;...                              No<br />Probing for `Maxim=
 MAX1619&#39;...                              No<br />Probing for `National=
 Semiconductor LM82/LM83&#39;...           No<br />Probing for `Maxim MAX66=
54&#39;...                              No<br />Probing for `Maxim MAX6690&=
#39;...                              No<br />Probing for `Maxim MAX6659&#39=
;...                              No<br />Probing for `Maxim MAX6647&#39;..=
.                              No<br />Probing for `Maxim MAX6680/MAX6681&#=
39;...                      No<br />Probing for `Maxim MAX6695/MAX6696&#39;=
...                      No<br />Probing for `Texas Instruments TMP411&#39;=
...                   No<br />Probing for `Texas Instruments TMP421&#39;...=
                   No<br />Probing for `Texas Instruments TMP422&#39;...   =
                No<br />Probing for `Texas Instruments AMC6821&#39;...     =
             No<br />Probing for `National Semiconductor LM64&#39;...      =
          No<br />Probing for `National Semiconductor LM73&#39;...         =
       No<br />Probing for `Maxim MAX6633/MAX6634/MAX6635&#39;...          =
    No<br />Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)&#39;...      =
 No<br />Probing for `Fintek F75111R/RG/N (GPIO)&#39;...                 No=
<br />Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R&#39;...        Yes<b=
r />    (confidence 6, not a hardware monitoring chip)<br />Client found at=
 address 0x50<br />Probing for `Analog Devices ADM1033&#39;...             =
        No<br />Probing for `Analog Devices ADM1034&#39;...                =
     No<br />Probing for `SPD EEPROM&#39;...                               =
  No<br />Probing for `EDID EEPROM&#39;...                                N=
o<br />Client found at address 0x51<br />Probing for `Analog Devices ADM103=
3&#39;...                     No<br />Probing for `Analog Devices ADM1034&#=
39;...                     No<br />Probing for `SPD EEPROM&#39;...         =
                        No<br />Client found at address 0x52<br />Probing f=
or `Analog Devices ADM1033&#39;...                     No<br />Probing for =
`Analog Devices ADM1034&#39;...                     No<br />Probing for `SP=
D EEPROM&#39;...                                 No<br />Client found at ad=
dress 0x53<br />Probing for `Analog Devices ADM1033&#39;...                =
     No<br />Probing for `Analog Devices ADM1034&#39;...                   =
  No<br />Probing for `SPD EEPROM&#39;...                                 N=
o<br /><br />Sorry, no sensors were detected.<br />Either your system has n=
o sensors, or they are not supported, or<br />they are connected to an I2C =
or SMBus adapter that is not<br />supported. If you find out what chips are=
 on your board, check<br />http://www.lm-sensors.org/wiki/Devices for drive=
r status.<br /><br />----------------<br /><br />I also tried running i2c-d=
etect on &quot;SMBus I801 adapter at 0500&quot;, here is the output:<br /><=
br />-------------<br /><br />     0  1  2  3  4  5  6  7  8  9  a  b  c  d=
  e  f<br />00:          -- -- -- -- -- 08 -- -- -- -- -- -- -- <br />10: 1=
0 11 -- 13 14 15 -- -- -- -- -- -- -- -- -- -- <br />20: -- -- -- -- -- -- =
-- -- -- -- -- -- -- -- -- -- <br />30: -- -- -- -- -- -- -- -- -- -- -- --=
 -- -- -- -- <br />40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- 4e -- <br =
/>50: 50 51 52 53 -- -- -- -- -- -- -- -- -- -- -- -- <br />60: -- -- -- --=
 -- -- -- -- -- 69 -- -- -- -- -- -- <br />70: -- -- -- -- -- -- -- --     =
   <br />                 <br />------------<br /><br />Is there anything e=
lse I can do to get this working, or help by providing some more info, or i=
s just a matter of waiting until there is support for Sandy Bridge? Or am I=
 doing something wrong? Thanks,<br /><br />Nick
--0022152d6d71d9f4ff049a109aff--


--===============2842409114854830882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2842409114854830882==--
