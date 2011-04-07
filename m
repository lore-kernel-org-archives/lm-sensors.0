From: Darren Hart <dvhart@linux.intel.com>
Date: Thu, 07 Apr 2011 20:59:13 +0000
Subject: Re: [lm-sensors] w83795 fan control not working
Message-Id: <4D9E25A1.1030704@linux.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110407150007.51dd1c06@endymion.delvare>
In-Reply-To: <20110407150007.51dd1c06@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



On 04/07/2011 06:00 AM, Jean Delvare wrote:
> Hi Darren,
> 
> I am redirecting this discussion to the right mailing list.
> 
> On Wed, 06 Apr 2011 16:41:07 -0700, Darren Hart wrote:
>> I haven't been able to control the fan speed using the w83795 driver.
>> The BIOS "Quiet" setting appears to be braindead as it runs quietly for
>> a while and then switches to near full throttle for a minute or so and
>> then returns to the previous state (this is with the system basically
>> idle). The temperatures (from w83795adg-i2c-0-2f) never reach anything
>> approaching critical:
> 
> At least, if the BIOS has a "Quiet" setting, this suggests that the
> hardware is designed for fan speed control.
> 
> Do you see any message in the kernel logs when the fan switches to high
> speed?

No. Nothing.

> 
>>
>> Quiet State:
>> temp1:       +83.5°C  (high = +127.0°C, hyst = +127.0°C)
>>              (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
> 
> This is very hot.

It is... and yet it's much hotter than anything reported by coretemp (which I assumed would have some of the higher temperatures). Any idea what temp1 might be measuring?

$ sensors | grep °C
Core 0:      +26.0°C  (high = +81.0°C, crit = +101.0°C)  Core 1:      +26.0°C  (high = +81.0°C, crit = +101.0°C)  Core 2:      +24.0°C  (high = +81.0°C, crit = +101.0°C)  Core 8:      +22.0°C  (high = +81.0°C, crit = +101.0°C)  temp1:       +40.0°C  (high = +138.0°C, hyst = +96.0°C)  sensor = thermistor
temp2:       -61.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
temp3:       +36.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
temp1:       +75.0°C  (high = +127.0°C, hyst = +127.0°C)                        (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
temp5:       +35.8°C  (high = +127.0°C, hyst = +127.0°C)                        (crit = +75.0°C, hyst = +70.0°C)  sensor = thermistor
temp7:       +24.8°C  (high = +95.0°C, hyst = +92.0°C)                        (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
temp8:       +23.0°C  (high = +95.0°C, hyst = +92.0°C)                        (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
Core 9:      +25.0°C  (high = +81.0°C, crit = +101.0°C)  Core 10:     +24.0°C  (high = +81.0°C, crit = +101.0°C)  Core 0:      +24.0°C  (high = +81.0°C, crit = +101.0°C)  Core 1:      +21.0°C  (high = +81.0°C, crit = +101.0°C)  Core 2:      +20.0°C  (high = +81.0°C, crit = +101.0°C)  Core 8:      +15.0°C  (high = +81.0°C, crit = +101.0°C)  Core 9:      +22.0°C  (high = +81.0°C, crit = +101.0°C)  Core 10:     +19.0°C  (high = +81.0°C, crit = +101.0°C)  


> 
>> temp5:       +40.0°C  (high = +127.0°C, hyst = +127.0°C)
>>              (crit = +75.0°C, hyst = +70.0°C)  sensor = thermistor
>> temp7:       +29.5°C  (high = +95.0°C, hyst = +92.0°C)
>>              (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
>> temp8:       +25.5°C  (high = +95.0°C, hyst = +92.0°C)
>>              (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
>>
>> Loud State:
>> ...
>> OK, waited 10 minutes and it didn't want to scream at me. But if memory
>> serves, there is only a variance of a few degrees before the fans kick
>> in.
> 
> None of the measurements above is anywhere close to its set limits, so
> this behavior isn't caused by an alarm raised by the W83795ADG.
> 
>> I'm hoping to use pwmconfig/fancontrol with the w83795 driver to restore
>> some sanity to the fan usage. I tried with V 0.7 on the Ubuntu 10.10
>> server kernel (vmlinuz-2.6.35-22-server) as well as with the current
>> version in the linux-2.6.git tree (2.6.39-rc1+). I'm running on the
>> following hardware with a pair of Intel Xeon X5680 CPUs.
>>
>> SUPERMICRO MBD-X8DTL-iF-O Motherboard
>> http://www.supermicro.com/products/motherboard/QPI/5500/X8DTL-iF.cfm
>>
>> On the following kernel:
>> linux-2.6.39-rc1+: 99759619b27662d1290901228d77a293e6e83200
>>
>> With the experimental fan control enabled for the w83795:
>> $ grep 83795 .config
>> CONFIG_SENSORS_W83795=m
>> CONFIG_SENSORS_W83795_FANCTRL=y
>>
>> The module is loaded:
>> $ lsmod | grep 83795
>> w83795                 43879  0 
>> pwmconfig reports the following:
>>
>> ---------------------------
>> Found the following devices:
>>    hwmon0/device is max1617
> 
> This would be very surprising and smells like a misdetection. Which
> could, in turn, explain (some of) your problems. What the use of the
> adm1021 driver suggested by sensors-detect?

Hrm, I noticed it reports:
Intel Core family thermal sensor...                         No
But if I load coretemp I get 12 sane temperature readings...

It does not detect adm1021, but it did report:

Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0x1a11

However Kconfig says:

│ If you say yes here you get support for Analog Devices ADM1021          │  │ and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,        │  │ Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,          │  │ and the XEON processor built-in sensor.  
These are XEON CPUs, is this an older interface that has been replaced by something else?

> I presume that the output
> for the supposed max1617 chip in "sensors" is plain wrong? I would
> advise that you do not load the adm1021 driver.
> 

OK, unloaded.

>>    hwmon1/device is w83627dhg
> 
> Super-I/O (multifunction) chip, probably not used for monitoring.
> Unloading the w83627ehf driver would make running pwmconfig much easier.

Done

> 
>>    hwmon2/device is w83795adg <--- So it found the device
>>
>> Found the following PWM controls:
>>    hwmon1/device/pwm1
>>    hwmon1/device/pwm2
>>    hwmon1/device/pwm3
>>    hwmon2/device/pwm1
>> hwmon2/device/pwm1 stuck to 125 <--- This doesn't look good.
>> Manual control mode not supported, skipping hwmon2/device/pwm1.
> 
> Indeed. This suggests that the driver wasn't able to switch this fan
> output to manual mode. The strange thing is that it works for me, with
> the same chip on a different board (lm-sensors 3.3.0, kernel 2.6.38.2.)
> 


$ sensors --version
sensors version 3.1.2 with libsensors version 3.1.2

$ uname -a
2.6.39-rc1+


>>    hwmon2/device/pwm2 <--- Which fans does it control?
> 
> The next steps in pwmconfig should tell. One thing worth noting is that
> you have 6 fan inputs used on the W83795ADG, but the chip has only two
> fan control outputs. So it is impossible that you have one control per
> fan. On my board, pwm1 controls both CPU fans and pwm2 controls all 6
> case fans.


I read somewhere during my hours of searching for a solution to this that both CPU fans are controlled by the same pwm signal, so that is not surprising. It's too bad about the case fans though, I really like to run the larger quiet fan up before bringing up the smaller front fan, but, it is what it is.


> 
>>
>> Giving the fans some time to reach full speed...
>> Found the following fan sensors:
>>    hwmon1/device/fan1_input     current speed: 0 ... skipping!
>>    hwmon1/device/fan2_input     current speed: 0 ... skipping!
>>    hwmon1/device/fan3_input     current speed: 0 ... skipping!
>>    hwmon1/device/fan5_input     current speed: 0 ... skipping!
>>    hwmon2/device/fan1_input     current speed: 0 ... skipping!
>>    hwmon2/device/fan2_input     current speed: 1931 RPM <-- cpu fan
>>
>> Note, the CPUs are very close together and to the rear chassis fan, this
>> prevents me from installing both CPU fans. I opted to keep the larger
>> (quieter) chassis fan adjacent to the second CPU over the second smaller
>> CPU fan.
>>
>>    hwmon2/device/fan3_input     current speed: 0 ... skipping!
>>    hwmon2/device/fan4_input     current speed: 2652 RPM <-- small chassis fan
>>    hwmon2/device/fan5_input     current speed: 1814 RPM <-- large chassis fan
>>    hwmon2/device/fan6_input     current speed: 0 ... skipping!
>>
>> ---------------------------
>>
>> The fans didn't change speed during the pwmconfig run. I did allow it to
>> switch all the pwm controls to manual mode.
> 


I ran pwmconfig again with adm1021, ipmi_si, and w83627ehf unloaded. This time it detected 8 pwm interfaces, and only pwm1 failed to enter manual mode.

   hwmon2/device is w83795g

Found the following PWM controls:
   hwmon2/device/pwm1
hwmon2/device/pwm1 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n) y
hwmon2/device/pwm1 stuck to 125

While trying to turn them off, I watched syslog:

During pwm3 test:
Apr  7 08:40:48 rage kernel: [ 1617.363333] w83795 0-002f: Failed to read from register 0x023, err -6

I then searched for the pwm controls manually and tried adjusting them. I was able reduce fan noise considerably by echo'ing 0 to pwm1, and I brought it back up by echo'ing 125 to it. I didn't notice any change with the other pwms. Also, the fan speed as reported by sensors stayed constant, even though they obviously had slowed down considerably.

# for PWM in $(find . -name "pwm[0-8]"); do echo $PWM; echo 0 > $PWM; echo -n "Off ($(cat $PWM))..."; sleep 5; echo 125 > $PWM; echo "On ($(cat $PWM))"; done
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm1
Off (0)...On (119)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm2
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm3
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm4
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm5
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm6
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm7
Off (0)...On (0)
./devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/pwm8
Off (0)...On (0)

I ran pwmconfig again... and it didn't complain about pwm1 not entering manual mode. It was also able to bring the fans up and shut them down with pwm1. It did NOT detect a correlation however.

I hit a bug in pwmconfig when configuring the pwm temperature input and fan speeds:

--------------
Enter the low temperature (degree C)
below which the fan should spin at minimum speed (20): 35

Enter the high temperature (degree C)
over which the fan should spin at maximum speed (60): /usr/sbin/pwmconfig: line 923: [: -eq: unary operator expected
/usr/sbin/pwmconfig: line 949: [: -eq: unary operator expected
--------------

923:
                       if [ $FAN_MIN -eq 0 ]
949:
                        if [ $FAN_MIN -eq 0 ]

Apparently, earlier in the script (line 877):

                FAN_MIN=`echo $fanactive_min|cut -d' ' -f$REPLY`

sets FAN_MIN to "" instead of a number. Adding some debug confirms this:
		FAN_MIN=`echo $fanactive_min|cut -d' ' -f$REPLY`
                # dvhart debug
                if [ -z "$FAN_MIN" ]; then
                        echo "FAN_MIN detection failed, setting to 0."
                        FAN_MIN=0
                fi

------------
FAN_MIN detection failed, setting to 0.
------------

------------
Enter the low temperature (degree C)
below which the fan should spin at minimum speed (20): 35

Enter the high temperature (degree C)
over which the fan should spin at maximum speed (60): 
Enter the minimum PWM value (0-255)
at which the fan STOPS spinning (press t to test) (100): t

Now we decrease the PWM value to figure out the lowest usable value.
We will use a slightly greater value as the minimum speed.
------------

After fixing that, the detection of the lowest value (where the fan stops) ran for 30 minutes without indicating any forward progress or making an audibly detectable change in fan speed. I tried adjusting it manually, and was able to make several speed adjustments, finding the min value somewhere between 35 and 50 (sys reports 'pwm1_start: 48'). Before I could finish, the interface stopped responding to commands. I reloaded the w83795 module, and pwmconfig then reported:

/usr/sbin/pwmconfig: There are no fan-capable sensor modules installed

And sensors only reported:

# sensors
w83795g-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
beep_enable:enabled


> Does the board manual say whether the case fans are supposed to be
> controllable, or only the CPU fans?

It is rather vague on the topic unfortunately:

"Fan status monitor with firmware control and CPU fan auto-off in sleep mode"
"Pule Width Modulation (PWM) Fan Control"
"The PC health monitor can check the RPM status of the cooling fans. The onboard CPU and chassis fans are controlled by Thermal Management via BIOS (under Hardware Monitoring in the Advanced Setting)."

And under the Nuvoton WPCM450R Controller (the baseboard management controller):
"The WPCM450R communicates with onboard components via six SMBus interfaces, fan control, and Platform Environment Control Interface (PECI) buses."

The case fans are definitely controllable given my experiment above on pwm1. pwm2 doesn't appear to do anything... and I'm not sure what 3-8 are supposed to do :-)

> 
>>
>> Fans 2, 4, and 5 below should be connected via the w83795 driver as far as I can tell:
>> $ rage-ipmi.sh sensor
>> FAN 1            | na         | RPM        | na    | na        | na        | na        | na        | na        | na        
>> FAN 2            | 1936.000   | RPM        | ok    | 400.000   | 576.000   | 784.000   | 33856.000 | 34225.000 | 34596.000 
>> FAN 3            | na         | RPM        | na    | na        | na        | na        | na        | na        | na        
>> FAN 4            | 2704.000   | RPM        | ok    | 400.000   | 576.000   | 784.000   | 33856.000 | 34225.000 | 34596.000 
>> FAN 5            | 1764.000   | RPM        | ok    | 400.000   | 576.000   | 784.000   | 33856.000 | 34225.000 | 34596.000 
>> FAN 6            | na         | RPM        | na    | na        | na        | na        | na        | na        | na        
>> CPU1 Vcore       | 0.952      | Volts      | ok    | 0.776     | 0.800     | 0.824     | 1.352     | 1.376     | 1.400     
>> CPU2 Vcore       | 0.952      | Volts      | ok    | 0.776     | 0.800     | 0.824     | 1.352     | 1.376     | 1.400     
>> CPU1 DIMM        | 1.520      | Volts      | ok    | 1.288     | 1.312     | 1.336     | 1.656     | 1.680     | 1.704     
>> CPU2 DIMM        | 1.520      | Volts      | ok    | 1.288     | 1.312     | 1.336     | 1.656     | 1.680     | 1.704     
>> +1.5 V           | na         | Volts      | na    | na        | na        | na        | na        | na        | na        
>> +5 V             | 5.056      | Volts      | ok    | 4.416     | 4.448     | 4.480     | 5.536     | 5.568     | 5.600     
>> +5VSB            | 5.056      | Volts      | ok    | 4.416     | 4.448     | 4.480     | 5.536     | 5.568     | 5.600     
>> +12 V            | 12.137     | Volts      | ok    | 10.600    | 10.653    | 10.706    | 13.250    | 13.303    | 13.356    
>> -12 V            | -11.904    | Volts      | ok    | -13.650   | -13.456   | -13.262   | -10.546   | -10.352   | -10.158   
>> VTT              | 1.112      | Volts      | ok    | 0.808     | 0.816     | 0.824     | 1.320     | 1.336     | 1.352     
>> +3.3VCC          | 3.264      | Volts      | ok    | 2.880     | 2.904     | 2.928     | 3.648     | 3.672     | 3.696     
>> +3.3VSB          | 3.264      | Volts      | ok    | 2.880     | 2.904     | 2.928     | 3.648     | 3.672     | 3.696     
>> VBAT             | 3.096      | Volts      | ok    | 2.880     | 2.904     | 2.928     | 3.648     | 3.672     | 3.696     
>> CPU1 Temp        | 0x1        | discrete   | 0x0000| na        | na        | na        | na        | na        | na        
>> CPU2 Temp        | 0x1        | discrete   | 0x0000| na        | na        | na        | na        | na        | na        
>> System Temp      | 40.000     | degrees C  | ok    | -9.000    | -7.000    | -5.000    | 75.000    | 77.000    | 79.000    
>> P1-DIMM1A        | 37.000     | degrees C  | ok    | -9.000    | -7.000    | -5.000    | 65.000    | 70.000    | 75.000    
>> P1-DIMM2A        | na         | degrees C  | na    | na        | na        | na        | na        | na        | na        
>> P1-DIMM3A        | na         | degrees C  | na    | na        | na        | na        | na        | na        | na        
>> P2-DIMM1A        | 37.000     | degrees C  | ok    | -9.000    | -7.000    | -5.000    | 65.000    | 70.000    | 75.000    
>> P2-DIMM2A        | na         | degrees C  | na    | na        | na        | na        | na        | na        | na        
>> P2-DIMM3A        | na         | degrees C  | na    | na        | na        | na        | na        | na        | na        
>> Chassis Intru    | 0x0        | discrete   | 0x0000| na        | na        | na        | na        | na        | na        
>> PS Status        | 0x1        | discrete   | 0x01ff| na        | na        | na        | na        | na        | na        
>>
>>
>> dmesg reports:
>> $ dmesg | grep 83795
>> [   12.643929] i2c i2c-0: Found w83795adg rev. B at 0x2f
>> [   12.883789] w83795 0-002f: PECI agent 1 Tbase temperature: 100
>> [   12.903779] w83795 0-002f: PECI agent 2 Tbase temperature: 100
>> [ 2288.932629] w83795 0-002f: Failed to read from register 0x030, err -6
>> [ 2613.292773] w83795 0-002f: Failed to write to register 0x040, err -6
>> [ 2693.333461] w83795 0-002f: Failed to read from register 0x01e, err -11
> 
> -6 is -ENXIO, returned by the i2c-i801 driver when a slave I2C device
> doesn't answer. -11 is -EAGAIN, meaning arbitration loss, which can
> happen on multi-master I2C buses, and I guess IPMI is implemented
> exactly that way.
> 
>> Am I doing something wrong?
> 
> Yes. You are using IPMI and a native Linux driver to access the same
> monitoring chip. Both access methods don't know of each other and are
> not synchronized.

OK, I removed the ipmi_si driver early on and am still seeing the problems described above.

> 
>> Can I provide any additional information to
>> help narrow down what might be wrong?
> 
> Choose between IPMI and native drivers. If you want to use IPMI on this
> board, then you have to forget about the w83795 driver. And about
> software-driven fan speed control too, I'm afraid.

Does that mean all IPMI features? I'd hate to have to lose SOL and power control.

> 
> Did you look for a BIOS or IPMI firmware update already?
> 

IPMI is current.
BIOS had an update available. After hunting down a FreeDOS USB boot image, I managed to flash it. pwmconfig is much happier now, and the sensors report the fan speed correctly now. pwmconfig walked through the PWM:RPM mapping for fan2_input, and all three fans dropped along with it. When it started in on fan4_input produced an error:

----------
  hwmon2/device/fan4_input ... speed was 4285 now 1058
    It appears that fan hwmon2/device/fan4_input
    is controlled by pwm hwmon2/device/pwm1
/usr/sbin/pwmconfig: line 464: hwmon2/device: expression recursion level exceeded (error token is "device")
Testing is complete.
----------

line 464
fanactive="$(($j+${fanactive}))" #not supported yet by fancontrol


fancontrol appears to work now as well. It appears all my fans are connected to the same PWM control, which is pretty unfortunate, but things are MUCH better now than they were. It appears there are a few scripting bugs in pwmconfig (at least in my distro version) that can be corrected with some string checking, but the core problem appears to be a buggy BIOS - big surprise ;-)

I am not sure which temperature sensor to use to control pwm1. I don't trust the temp1 input of 82C, temp5 reads 39 idle, and 7 and 8 read about 25 idle. While the coretemp sensors read 24-29.

temp1:       +82.5°C  (high = +127.0°C, hyst = +127.0°C)  
                      (crit = +127.0°C, hyst = +127.0°C)  sensor = thermal diode
temp5:       +39.0°C  (high = +127.0°C, hyst = +127.0°C)  
                      (crit = +75.0°C, hyst = +70.0°C)  sensor = thermistor
temp7:       +25.0°C  (high = +95.0°C, hyst = +92.0°C)  
                      (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI
temp8:       +22.8°C  (high = +95.0°C, hyst = +92.0°C)  
                      (crit = +95.0°C, hyst = +92.0°C)  sensor = Intel PECI

# sensors | grep Core
Core 0:      +27.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 1:      +28.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 2:      +27.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 8:      +25.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 9:      +28.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 10:     +26.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 0:      +25.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 1:      +23.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 2:      +21.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 8:      +17.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 9:      +24.0°C  (high = +81.0°C, crit = +101.0°C)  
Core 10:     +20.0°C  (high = +81.0°C, crit = +101.0°C)  


And as I'm typing this, dmesg started spewing a lot of errors and temp1-5 now report 0°C

[ 1056.545180] w83795 0-002f: Failed to write to register 0x040, err -6
[ 1056.585158] w83795 0-002f: Failed to read from register 0x041, err -6
[ 1056.605143] w83795 0-002f: Failed to read from register 0x042, err -6
[ 1056.645123] w83795 0-002f: Failed to read from register 0x043, err -6
[ 1056.685094] w83795 0-002f: Failed to read from register 0x044, err -6
[ 1056.705084] w83795 0-002f: Failed to read from register 0x045, err -6
[ 1056.745057] w83795 0-002f: Failed to read from register 0x046, err -6
[ 1056.765044] w83795 0-002f: Failed to write to register 0x040, err -6
....
[ 1060.442767] w83795 0-002f: Failed to set bank to 2, err -6
[ 1060.482745] w83795 0-002f: Failed to set bank to 2, err -6
[ 1060.502728] w83795 0-002f: Failed to set bank to 2, err -6
...
[ 1060.702605] w83795 0-002f: Failed to read from register 0x040, err -6
[ 1060.722590] w83795 0-002f: Failed to read from register 0x046, err -6
[ 1060.762569] w83795 0-002f: Failed to write to register 0x040, err -6
...
and on for pages.

Reloading w83795 stops the messages, but the w83795 sensors don't come back.

OK, that's a ton of data, hopefully it's good data.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
