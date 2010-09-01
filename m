From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Wed, 01 Sep 2010 08:11:56 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <4C7E0ACC.8040409@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 09/01/2010 10:03 AM, Mahmood Naderan wrote:
>  >sudo ./sensors-detect
> Yes
> Intel Core family thermal sensor... Success!
> (driver `coretemp')
> ...
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> Driver `it87':
> * ISA bus, address 0x290
> Chip `ITE IT8720F Super IO Sensors' (confidence: 9)
> Driver `coretemp':
> * Chip `Intel Core family thermal sensor' (confidence: 9)
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): y
> Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> for initialization at boot time.
> You should now start the lm_sensors service to load the required
> kernel modules.
> I then copy that file and restart
> mahmood@localhost:~$ <mailto:mahmood@blackfish:~$> ls /etc/init.d/lm*
> /etc/init.d/lm-sensors
> However this is what I see again
> mahmood@localhost:~$ <mailto:mahmood@localhost:~$> sudo sensors
> it8720-isa-0290
> Adapter: ISA adapter
> in0: +0.86 V (min = +0.00 V, max = +4.08 V)
> in1: +1.58 V (min = +0.00 V, max = +4.08 V)
> in2: +3.39 V (min = +0.00 V, max = +4.08 V)
> in3: +3.02 V (min = +0.00 V, max = +4.08 V)
> in4: +0.05 V (min = +0.00 V, max = +4.08 V) ALARM
> in5: +3.12 V (min = +0.00 V, max = +4.08 V)
> in6: +0.02 V (min = +0.00 V, max = +4.08 V) ALARM
> in7: +2.16 V (min = +0.00 V, max = +4.08 V)
> Vbat: +3.10 V
> fan1: 1638 RPM (min = 10 RPM)
> fan2: 618 RPM (min = 0 RPM)
> fan3: 1278 RPM (min = 10 RPM)
> fan4: 1203 RPM (min = 0 RPM)
> temp1: +35.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
> temp2: +25.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
> temp3: +33.0°C (low = +127.0°C, high = +90.0°C) sensor = thermistor
> cpu0_vid: +0.313 V
> No core-i7.... :(
> *// Naderan *Mahmood;*
>
sudo /etc/init.d/lm_sensors restart


>
> ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
> *From:* Nikola Pajkovsky <npajkovs@redhat.com>
> *To:* lm-sensors@lm-sensors.org
> *Sent:* Wed, September 1, 2010 12:23:10 PM
> *Subject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
>
> sudo ./sensors-detect
>
> On 09/01/2010 09:46 AM, Mahmood Naderan wrote:
>  > >just svn update # not needed if you have fresh checkout
>  > To double check and be sure again:
>  > mahmood@localhost:~$ <mailto:mahmood@localhost:~$> svn update 5857
>  > Skipped '5857'
>  >
>  > Then:
>  >
>  >
>  > mahmood@localhost:~$ <mailto:mahmood@blackfish:~$> cd lm-sensors/prog/detect/
>  > mahmood@localhost:~/lm-sensors/prog/detect$ <mailto:mahmood@blackfish:~/lm-sensors/prog/detect$> sudo sensors-detect
>  > # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
>  > # System: Gigabyte Technology Co., Ltd. P55-USB3
>  > This program will help you determine which kernel modules you need
>  > to load to use lm_sensors most effectively. It is generally safe
>  > and recommended to accept the default answers to all questions,
>  > unless you know what you're doing.
>  > Some south bridges, CPUs or memory controllers contain embedded sensors.
>  > Do you want to scan for them? This is totally safe. (YES/no): y
>  > Silicon Integrated Systems SIS5595... No
>  > VIA VT82C686 Integrated Sensors... No
>  > VIA VT8231 Integrated Sensors... No
>  > AMD K8 thermal sensors... No
>  > AMD Family 10h thermal sensors... No
>  > AMD Family 11h thermal sensors... No
>  > Intel Core family thermal sensor... No
>  > Intel Atom thermal sensor... No
>  > Intel AMB FB-DIMM thermal sensor... No
>  > VIA C7 thermal sensor... No
>  > VIA Nano thermal sensor... No
>  > Some Super I/O chips contain embedded sensors. We have to write to
>  > standard I/O ports to probe them. This is usually safe.
>  > Do you want to scan for Super I/O sensors? (YES/no): y
>  > Probing for Super-I/O at 0x2e/0x2f
>  > Trying family `National Semiconductor'... No
>  > Trying family `SMSC'... No
>  > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>  > Trying family `ITE'... Yes
>  > Found `ITE IT8720F Super IO Sensors' Success!
>  > (address 0x290, driver `it87')
>  > Probing for Super-I/O at 0x4e/0x4f
>  > Trying family `National Semiconductor'... No
>  > Trying family `SMSC'... No
>  > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>  > Trying family `ITE'... No
>  > Some systems (mainly servers) implement IPMI, a set of common interfaces
>  > through which system health data may be retrieved, amongst other things.
>  > We first try to get the information from SMBIOS. If we don't find it
>  > there, we have to read from arbitrary I/O ports to probe for such
>  > interfaces. This is normally safe. Do you want to scan for IPMI
>  > interfaces? (YES/no): y
>  > Probing for `IPMI BMC KCS' at 0xca0... No
>  > Probing for `IPMI BMC SMIC' at 0xca8... No
>  > Some hardware monitoring chips are accessible through the ISA I/O ports.
>  > We have to write to arbitrary I/O ports to probe them. This is usually
>  > safe though. Yes, you do have ISA I/O ports even if you do not have any
>  > ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): y
>  > Probing for `National Semiconductor LM78' at 0x290... No
>  > Probing for `National Semiconductor LM79' at 0x290... No
>  > Probing for `Winbond W83781D' at 0x290... No
>  > Probing for `Winbond W83782D' at 0x290... No
>  > Lastly, we can probe the I2C/SMBus adapters for connected hardware
>  > monitoring devices. This is the most risky part, and while it works
>  > reasonably well on most systems, it has been reported to cause trouble
>  > on some systems.
>  > Do you want to probe the I2C/SMBus adapters now? (YES/no): y
>  > Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
>  > Sorry, no supported PCI bus adapters found.
>  > Module i2c-dev loaded successfully.
>  > Now follows a summary of the probes I have just done.
>  > Just press ENTER to continue:
>  > Driver `it87':
>  > * ISA bus, address 0x290
>  > Chip `ITE IT8720F Super IO Sensors' (confidence: 9)
>  > To load everything that is needed, add this to /etc/modules:
>  > #----cut here----
>  > # Chip drivers
>  > it87
>  > #----cut here----
>  > If you have some drivers built into your kernel, the list above will
>  > contain too many modules. Skip the appropriate ones!
>  > Do you want to add these lines automatically to /etc/modules? (yes/NO)yes
>  > Successful!
>  > Monitoring programs won't work until the needed modules are
>  > loaded. You may want to run '/etc/init.d/module-init-tools start'
>  > to load them.
>  > Unloading i2c-dev... OK
>  >
>  > But that didn't help. See the sensors output:
>  >
>  > mahmood@localhost:~/lm-sensors/prog/detect$ <mailto:mahmood@blackfish:~/lm-sensors/prog/detect$> sudo sensors
>  > it8720-isa-0290
>  > Adapter: ISA adapter
>  > in0: +0.86 V (min = +0.00 V, max = +4.08 V)
>  > in1: +1.58 V (min = +0.00 V, max = +4.08 V)
>  > in2: +3.39 V (min = +0.00 V, max = +4.08 V)
>  > in3: +3.02 V (min = +0.00 V, max = +4.08 V)
>  > in4: +0.05 V (min = +0.00 V, max = +4.08 V) ALARM
>  > in5: +3.12 V (min = +0.00 V, max = +4.08 V)
>  > in6: +0.02 V (min = +0.00 V, max = +4.08 V) ALARM
>  > in7: +2.16 V (min = +0.00 V, max = +4.08 V)
>  > Vbat: +3.10 V
>  > fan1: 1683 RPM (min = 10 RPM)
>  > fan2: 644 RPM (min = 0 RPM)
>  > fan3: 1280 RPM (min = 10 RPM)
>  > fan4: 1203 RPM (min = 0 RPM)
>  > temp1: +35.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
>  > temp2: +25.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
>  > temp3: +33.0°C (low = +127.0°C, high = +90.0°C) sensor = thermistor
>  > cpu0_vid: +0.313 V
>  >
>  > Any idea? Thanks,
>  > *// Naderan *Mahmood;*
>  >
>  >
>  > ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ------------------
----
> --
>  > *From:* Nikola Pajkovsky <npajkovs@redhat.com <mailto:npajkovs@redhat.com>>
>  > *To:* lm-sensors@lm-sensors.org <mailto:lm-sensors@lm-sensors.org>
>  > *Sent:* Wed, September 1, 2010 12:08:07 PM
>  > *Subject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
>  >
>  > On 09/01/2010 09:30 AM, Mahmood Naderan wrote:
>  > > Here is what I did:
>  > > mahmood@localhost:~$ <mailto:mahmood@localhost:~$> svn checkout http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors
>  > > ...
>  > > Checked out revision 5857.
>  > Yes
>  >
>  > > mahmood@localhost:~$ <mailto:mahmood@blackfish:~$> svn update http://lm-sensors.org/svn/lm-sensors/trunk lm-sensors
>  > > Skipped 'http://lm-sensors.org/svn/lm-sensors/trunk'
>  > > At revision 5857.
>  > > Summary of conflicts:
>  > > Skipped paths: 1
>  > > Is that what you meant?
>  > > *// Naderan *Mahmood;*
>  > just svn update # not needed if you have fresh checkout
>  >
>  > in lm-sensors/prog/detect run sensors-detect and it should find your core-i7
>  >
>  > >
>  > >
>  > > ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ ----------------
--
> ----
>  > --
>  > > *From:* Nikola Pajkovsky <npajkovs@redhat.com <mailto:npajkovs@redhat.com> <mailto:npajkovs@redhat.com <mailto:npajkovs@redhat.com>>>
>  > > *To:* lm-sensors@lm-sensors.org <mailto:lm-sensors@lm-sensors.org> <mailto:lm-sensors@lm-sensors.org <mailto:lm-sensors@lm-sensors.org>>
>  > > *Sent:* Wed, September 1, 2010 11:49:03 AM
>  > > *Subject:* Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
>  > >
>  > > On 09/01/2010 08:38 AM, Mahmood Naderan wrote:
>  > > > Dear all,
>  > > >
>  > > > I ran sensors-detect to detect Core-i7 temperatures but it doesn't show them. Here is the output of sensors-detect:
>  > > >
>  > > >
>  > > > mahmood@localhost:~$ sudo sensors-detect
>  > > > # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
>  > > > # System: Gigabyte Technology Co., Ltd. P55-USB3
>  > > >
>  > > > This program will help you determine which kernel modules you need
>  > > > to load to use lm_sensors most effectively. It is generally safe
>  > > > and recommended to accept the default answers to all questions,
>  > > > unless you know what you're doing.
>  > > >
>  > > > Some south bridges, CPUs or memory controllers contain embedded sensors.
>  > > > Do you want to scan for them? This is totally safe. (YES/no): y
>  > > > Silicon Integrated Systems SIS5595... No
>  > > > VIA VT82C686 Integrated Sensors... No
>  > > > VIA VT8231 Integrated Sensors... No
>  > > > AMD K8 thermal sensors... No
>  > > > AMD Family 10h thermal sensors... No
>  > > > AMD Family 11h thermal sensors... No
>  > > > Intel Core family thermal sensor... No
>  > > > Intel Atom thermal sensor... No
>  > > > Intel AMB FB-DIMM thermal sensor... No
>  > > > VIA C7 thermal sensor... No
>  > > > VIA Nano thermal sensor... No
>  > > >
>  > > > Some Super I/O chips contain embedded sensors. We have to write to
>  > > > standard I/O ports to probe them. This is usually safe.
>  > > > Do you want to scan for Super I/O sensors? (YES/no): y
>  > > > Probing for Super-I/O at 0x2e/0x2f
>  > > > Trying family `National Semiconductor'... No
>  > > > Trying family `SMSC'... No
>  > > > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>  > > > Trying family `ITE'... Yes
>  > > > Found `ITE IT8720F Super IO Sensors' Success!
>  > > > (address 0x290, driver `it87')
>  > > > Probing for Super-I/O at 0x4e/0x4f
>  > > > Trying family `National Semiconductor'... No
>  > > > Trying family `SMSC'... No
>  > > > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
>  > > > Trying family `ITE'... No
>  > > >
>  > > > Some systems (mainly servers) implement IPMI, a set of common interfaces
>  > > > through which system health data may be retrieved, amongst other things.
>  > > > We first try to get the information from SMBIOS. If we don't find it
>  > > > there, we have to read from arbitrary I/O ports to probe for such
>  > > > interfaces. This is normally safe. Do you want to scan for IPMI
>  > > > interfaces? (YES/no): y
>  > > > Probing for `IPMI BMC KCS' at 0xca0... No
>  > > > Probing for `IPMI BMC SMIC' at 0xca8... No
>  > > >
>  > > > Some hardware monitoring chips are accessible through the ISA I/O ports.
>  > > > We have to write to arbitrary I/O ports to probe them. This is usually
>  > > > safe though. Yes, you do have ISA I/O ports even if you do not have any
>  > > > ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): y
>  > > > Probing for `National Semiconductor LM78' at 0x290... No
>  > > > Probing for `National Semiconductor LM79' at 0x290... No
>  > > > Probing for `Winbond W83781D' at 0x290... No
>  > > > Probing for `Winbond W83782D' at 0x290... No
>  > > >
>  > > > Lastly, we can probe the I2C/SMBus adapters for connected hardware
>  > > > monitoring devices. This is the most risky part, and while it works
>  > > > reasonably well on most systems, it has been reported to cause trouble
>  > > > on some systems.
>  > > > Do you want to probe the I2C/SMBus adapters now? (YES/no): y
>  > > > Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.
>  > > > Sorry, no supported PCI bus adapters found.
>  > > > Module i2c-dev loaded successfully.
>  > > >
>  > > > Now follows a summary of the probes I have just done.
>  > > > Just press ENTER to continue:
>  > > >
>  > > > Driver `it87':
>  > > > * ISA bus, address 0x290
>  > > > Chip `ITE IT8720F Super IO Sensors' (confidence: 9)
>  > > >
>  > > > To load everything that is needed, add this to /etc/modules:
>  > > > #----cut here----
>  > > > # Chip drivers
>  > > > it87
>  > > > #----cut here----
>  > > > If you have some drivers built into your kernel, the list above will
>  > > > contain too many modules. Skip the appropriate ones!
>  > > >
>  > > > Do you want to add these lines automatically to /etc/modules? (yes/NO)yes
>  > > > Successful!
>  > > >
>  > > > Monitoring programs won't work until the needed modules are
>  > > > loaded. You may want to run '/etc/init.d/module-init-tools start'
>  > > > to load them.
>  > > >
>  > > > Unloading i2c-dev... OK
>  > > >
>  > > >
>  > > > Then I ran sensors:
>  > > >
>  > > > mahmood@localhost:~$ sudo sensors
>  > > > it8720-isa-0290
>  > > > Adapter: ISA adapter
>  > > > in0: +0.86 V (min = +0.00 V, max = +4.08 V)
>  > > > in1: +1.58 V (min = +0.00 V, max = +4.08 V)
>  > > > in2: +3.39 V (min = +0.00 V, max = +4.08 V)
>  > > > in3: +3.02 V (min = +0.00 V, max = +4.08 V)
>  > > > in4: +0.05 V (min = +0.00 V, max = +4.08 V) ALARM
>  > > > in5: +3.12 V (min = +0.00 V, max = +4.08 V)
>  > > > in6: +0.02 V (min = +0.00 V, max = +4.08 V) ALARM
>  > > > in7: +2.16 V (min = +0.00 V, max = +4.08 V)
>  > > > Vbat: +3.10 V
>  > > > fan1: 1679 RPM (min = 10 RPM)
>  > > > fan2: 644 RPM (min = 0 RPM)
>  > > > fan3: 1278 RPM (min = 10 RPM)
>  > > > fan4: 1205 RPM (min = 0 RPM)
>  > > > temp1: +36.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
>  > > > temp2: +25.0°C (low = +127.0°C, high = +127.0°C) sensor = thermistor
>  > > > temp3: +33.0°C (low = +127.0°C, high = +90.0°C) sensor = thermistor
>  > > > cpu0_vid: +0.313 V
>  > > >
>  > > >
>  > > > What can I do then? currently I have kubuntu 10.04
>  > > >
>  > > > *// Naderan *Mahmood;*
>  > > >
>  > > >
>  > >
>  > > Pick sensors-detect from svn or file bug against lm-sensors in ubuntu and maintainer(if he is nice) update lm-sensors.
>  > >
>  >
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
