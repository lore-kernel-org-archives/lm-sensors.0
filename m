From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Question about sensor result on intel motherboard
Message-Id: <419E88C9.3060601@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <000d01c4ce03$5bcbe790$6f0010ac@RANSONGNAN>
In-Reply-To: <000d01c4ce03$5bcbe790$6f0010ac@RANSONGNAN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the sensors shown below are behind the BMC.
If there are additional sensors behind the BMC that are not being displayed
for some reason, you should be able to find information about them in dmesg.
If you have additional sensors not behind the BMC, but on the 801, you should
have information about them in from sensors-detect. See also our FAQ.

Ran Songnan wrote:
> Hi!
>  
> I have installed i2c-2.8.8 and lm-sensors-2.8.8 on a machine with an 
> Intel motherboard(SE7501WV2). The operating system is Linux2.4.22. The 
> modules i2c-i801, i2c-isa, eeprom, bmcsensors, i2c-ipmi and ipmi_kcs_drv 
> have been load successfully.
>  
> The problem is, the output of sensors contains only voltage information 
> and a piece of temperature information. It seems that the some chipset 
> on the motherboard is recognized as bmi-ipmi-0000 or something, so the 
> sensors cannot get the corresponding information such as fans' rpm or 
> CPU temperature.
>  
> Any ideas?
>  
> The exact output of sensors is:
>  
> eeprom-i2c-0-52
> Adapter: SMBus I801 adapter at 0580
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
>  
> eeprom-i2c-0-56
> Adapter: SMBus I801 adapter at 0580
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
>  
> bmc-ipmi-0000
> Adapter: Dummy adapter
> Baseboard 1.2V:
>            +1.21 V  (min =  +1.07 V, max =  +1.33 V)
> Baseboard 1.25V:
>            +1.27 V  (min =  +1.02 V, max =  +1.49 V)
> Baseboard 1.8V:
>            +1.80 V  (min =  +1.60 V, max =  +1.98 V)
> Baseboard 1.8VSB:
>            +1.79 V  (min =  +1.60 V, max =  +1.98 V)
> Baseboard 2.5V:
>            +2.52 V  (min =  +2.16 V, max =  +2.83 V)
> Baseboard 3.3V:
>            +3.41 V  (min =  +2.99 V, max =  +3.64 V)
> Baseboard 3.3AUX:
>            +3.33 V  (min =  +2.92 V, max =  +3.69 V)
> Baseboard 5.0V:
>            +5.02 V  (min =  +4.52 V, max =  +5.49 V)
> Baseboard 5VSB:
>            +5.08 V  (min =  +4.44 V, max =  +5.62 V)
> Baseboard 12V:
>           +11.97 V  (min = +10.79 V, max = +13.08 V)
> Baseboard Temp:
>            +31.0 C  (high =   +65 C, hyst =   +63 C)
>  
> Thanks!
>  
> S.N. Ran Beijing
