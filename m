From: jim.cromie@gmail.com (Jim Cromie)
Date: Sat, 23 Sep 2006 21:07:25 +0000
Subject: [lm-sensors] [patch 3/3] pc87360 - fix unchecked
Message-Id: <4515A20D.1080803@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E73765.80603@gmail.com>
In-Reply-To: <44E73765.80603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Jim,
>
>   
>>> 3- rework sys-device-interface startup
>>>     use sysfs_create_group() for 2 sensor-types which are chip-model invariant.
>>>        ie all-or-nothing attribute groups
>>>     other 2 groups vary too much due to configuration, etc,
>>>        so we keep the loops of device_create_file(), but now check their returns.
>>>
>>> Signed-off-by:   Jim Cromie  <jim.cromie at gmail.com>
>>>       
>
> I just noticed that you do not properly propagate the error value if a
> device file creation actually fails:
>
>   
My timing was off.  I noted this too, and did a patch last nite. 
Was gonna stack them all up and test result this morning.
Ive now done so, using your patch, everything looks good :)

BTW, everything includes :
3 patches for pc87360 return-status-checks (already on your list)
1 vrm patch,
2 patches giving  pc87360 2D-callbacks,
3 superio-locks patches (add module, use in pc87360 & pc8736x_gpio)

Id like to get these into 18-mmX, for some value of X.
Do you have any thoughts on how and when this should happen ?
Im presuming it is sometime after the 19-rc0 submit window closes.


FWIW, my previously posted sensorck.pl shows this 'discrepancy', due to 
new vrm-vid patch..
(updated version attached)

$ sensorck.pl sensor-out
[10310.921653] hwmon-vid: requested unknown VRM version
check VPWR
check VCORE
check VCC
check Vbat
check Critical
check -12V
check Vsb
check Vdd
check +12V
check Temp
val out of range by 5.88%, 102 should be +108
check AVdd
check avi0
check GND
unknown sensors:
$VAR1 = {
  '          +0.000 V  (VRM Version 0.0)' => {
    'raw' => undef
  },
  'Voltage ID:' => {
    'raw' => undef
  }
};

$ sensorck.pl -h
Unknown option: h
usage: sensorck.pl [opts] <filename>
    -v  : verbose
    -r <5> : percentage difference (5% is default)
    -e  : verbose for errors
    -H  : more help

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensorck.pl
Type: application/x-perl
Size: 3743 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060923/1bd12843/attachment.bin 
