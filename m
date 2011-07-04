From: Jeff Rickman <jrickman@myamigos.us>
Date: Mon, 04 Jul 2011 18:13:56 +0000
Subject: Re: [lm-sensors] IT8772E info and reports
Message-Id: <4E1202E4.7050105@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
In-Reply-To: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On 7/4/2011 9:33 AM, Kazuya wrote:
> Hello,
>
> I am a bit stuck currently. I would like to know if you can help me. I
> would like to access to the temperature of my processor. That what I
> have already done ..
>
> If you need more information I can send everything you want.
>
> My system :
>
> root@teddy:~# uname -a
>
> *Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64
> GNU/Linux***
>
> Other information :
>
> Shuttle SH67H3 =96 i5 2300
>
> The last version of sensors detect gives :
>
> root@teddy:~# perl sensors-detect
>
> *# sensors-detect revision 5981 (2011-07-03 13:57:57 +0200)*
>
> *# System: Shuttle SH67H3*
>
> *# Board: Shuttle FH67*
>
> **
>
> *This program will help you determine which kernel modules you need*
>
> *to load to use lm_sensors most effectively. It is generally safe*
>
> *and recommended to accept the default answers to all questions,*
>
> *unless you know what you're doing.*
>
> **
>
> *Some south bridges, CPUs or memory controllers contain embedded sensors.*
>
> *Do you want to scan for them? This is totally safe. (YES/no): yes*
>
> *Module cpuid loaded successfully.*
>
> *Silicon Integrated Systems SIS5595... No*
>
> *VIA VT82C686 Integrated Sensors... No*
>
> *VIA VT8231 Integrated Sensors... No*
>
> *AMD K8 thermal sensors... No*
>
> *AMD Family 10h thermal sensors... No*
>
> *AMD Family 11h thermal sensors... No*
>
> *AMD Family 12h and 14h thermal sensors... No*
>
> *AMD Family 15h thermal sensors... No*
>
> *AMD Family 15h power sensors... No*
>
> *Intel digital thermal sensor... Success!*
>
> *(driver `coretemp')*
>
> *Intel AMB FB-DIMM thermal sensor... No*
>
> *VIA C7 thermal sensor... No*
>
> *VIA Nano thermal sensor... No*
>
> **
>
> *Some Super I/O chips contain embedded sensors. We have to write to*
>
> *standard I/O ports to probe them. This is usually safe.*
>
> *Do you want to scan for Super I/O sensors? (YES/no): yes*
>
> *Probing for Super-I/O at 0x2e/0x2f*
>
> *Trying family `National Semiconductor/ITE'... No*
>
> *Trying family `SMSC'... No*
>
> *Trying family `VIA/Winbond/Nuvoton/Fintek'... No*
>
> *Trying family `ITE'... Yes*
>
> *Found `ITE IT8772E Super IO Sensors' Success!*
>
> *(address 0xa30, driver `to-be-written')*
>
> *Probing for Super-I/O at 0x4e/0x4f*
>
> *Trying family `National Semiconductor/ITE'... No*
>
> *Trying family `SMSC'... No*
>
> *Trying family `VIA/Winbond/Nuvoton/Fintek'... No*
>
> *Trying family `ITE'... No*
>
> **
>
> *Some systems (mainly servers) implement IPMI, a set of common interfaces*
>
> *through which system health data may be retrieved, amongst other things.*
>
> *We first try to get the information from SMBIOS. If we don't find it*
>
> *there, we have to read from arbitrary I/O ports to probe for such*
>
> *interfaces. This is normally safe. Do you want to scan for IPMI*
>
> *interfaces? (YES/no): yes*
>
> *Probing for `IPMI BMC KCS' at 0xca0... No*
>
> *Probing for `IPMI BMC SMIC' at 0xca8... No*
>
> **
>
> *Some hardware monitoring chips are accessible through the ISA I/O ports.*
>
> *We have to write to arbitrary I/O ports to probe them. This is usually*
>
> *safe though. Yes, you do have ISA I/O ports even if you do not have any*
>
> *ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes*
>
> *Probing for `National Semiconductor LM78' at 0x290... No*
>
> *Probing for `National Semiconductor LM79' at 0x290... No*
>
> *Probing for `Winbond W83781D' at 0x290... No*
>
> *Probing for `Winbond W83782D' at 0x290... No*
>
> **
>
> *Lastly, we can probe the I2C/SMBus adapters for connected hardware*
>
> *monitoring devices. This is the most risky part, and while it works*
>
> *reasonably well on most systems, it has been reported to cause trouble*
>
> *on some systems.*
>
> *Do you want to probe the I2C/SMBus adapters now? (YES/no): yes*
>
> *Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH=
)*
>
> **
>
> *Next adapter: SMBus I801 adapter at f040 (i2c-0)*
>
> *Do you want to scan it? (yes/NO/selectively): yes*
>
> *Client found at address 0x50*
>
> *Handled by driver `eeprom' (already loaded), chip type `eeprom'*
>
> *(note: this is probably NOT a sensor chip!)*
>
> *Client found at address 0x52*
>
> *Handled by driver `eeprom' (already loaded), chip type `eeprom'*
>
> *(note: this is probably NOT a sensor chip!)*
>
> **
>
> *Now follows a summary of the probes I have just done.*
>
> *Just press ENTER to continue:*
>
> **
>
> *Driver `to-be-written':*
>
> ** ISA bus, address 0xa30*
>
> *Chip `ITE IT8772E Super IO Sensors' (confidence: 9)*
>
> **
>
> *Driver `coretemp':*
>
> ** Chip `Intel digital thermal sensor' (confidence: 9)*
>
> **
>
> *Note: there is no driver for ITE IT8772E Super IO Sensors yet.*
>
> *Check http://www.lm-sensors.org/wiki/Devices for updates.*
>
> **
>
> *Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes*
>
> *Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors*
>
> *for initialization at boot time.*
>
> *You should now start the lm_sensors service to load the required*
>
> *kernel modules.*
>
> **
>
> *Unloading cpuid... OK*
>
> root@ted:~# modprobe it87 force_id=3D0x8721
>
> *FATAL: Error inserting it87
> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such devic=
e*
>
> As you told me I tried modprobe it87 force_id=3D0x8721
>
> IT8772E yes LPC (2011-06-10) Found on Foxconn and Shuttle H67 boards. No
> datasheet yet. One request (Boris Hajduk). Support can probably be added
> to the it87 driver. Try "modprobe it87 force_id=3D0x8721" and report.
>
> Thank you,
>
> Do not hesitate to ask me any question if you want !
>

What distribution is this?

What is the output from the 'sensors -v' command? That should display=20
what version of LM_Sensors is installed and what libsensors library=20
version is used.

What is the output from the 'sensors' command? If the necessary drivers=20
have properly loaded, that command will display various outputs.

The 'it87' module should be present if LM_Sensors is properly installed.=20
Also, the 'coretemp' module should be present if LM_Sensors is properly=20
installed. Did you attempt to "modprobe coretemp" and observe what happened?

Did you attempt to start the lm_sensors service to load the required=20
modules? If you tried to start the service, what did you observe?

To monitor CPU temperatures on an Intel CPU, the 'coretemp' driver from=20
LM_Sensors can do the job.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
