From: lmsensors@continuingtime.com
Date: Sun, 22 Apr 2012 10:19:24 +0000
Subject: [lm-sensors] Sensors [via-cputemp] is cpu intensive?
Message-Id: <4F93DB2C.5000405@continuingtime.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi All,

Historically, I've been getting my CPU thermal info from=20
/proc/acpi/thermal_zone/THRM/temperature for the longest time and it's=20
generally been giving me consistent temperature values.

After a kernel upgrade I acpi stopped creating the above file so I=20
decided that rather than try to figure out what I did to get it working=20
many years ago, I'd give lm-sensors a try but I'm getting some really=20
weird results out of it that I want to confirm with you.

mobo: EPIA SN (mini-itx)
CPU: via C7 1.8GHz (cooled by half height 80mm fan)
driver:  via-cputemp


So if I just run /usr/bin/sensors, I get a CPU temp of 32 degC.  But,=20
when I run it from a script per...

--------

MAIL_SUBJECT=3D"$(hostname -s | tr '[a-z]' '[A-Z]'): Temperature Warning"
MAIL_RCPT=3D'xxxx'
MAIL_BODY=3D$(mktemp)
MAIL_SEND=3D""
TFS=3D$IFS

DEBUG=3D''

# Sensor thresholds
HDD_THRESHOLD=3D48
CPU_THRESHOLD=3D65

IFS=3D$'\n'
for i in $(/usr/bin/sensors | grep Core); do
   cpu=3D$(echo $i | awk -F: '{ print $1 }')
   temp=3D$(echo $i | awk -F: '{ print $2 }' | sed -e 's/[^0-9\.]//g' -e=20
's/\..*//g')
   if [ $CPU_THRESHOLD -ge $(($temp)) ]; then
     printf "  %10s: %5s\n" $cpu $temp >> $MAIL_BODY
   else
     printf "**%10s: %5s  !!WARNING!!\n" $cpu $temp >> $MAIL_BODY
     MAIL_SEND=3D1
   fi
done
# debug
cat $MAIL_BODY
-----------------

I get a temp of 36 degC.

So, with nothing else running on this box, running something as simple=20
as bash, mktemp, grep and sensors sends my CPU temp up 4 degC.  Okay, I=20
can accept that actually using the CPU can create a temp spike but have=20
a look at this....

------------------
#!/bin/bash
for i in $(seq 1 200); do
   /usr/bin/sensors | grep Core
done
sleep 1
/usr/bin/sensors | grep Core

-------------------

Remember that just running sensors returns a temp of ~32.  When I run=20
the above script, the first temp is usually ~36 and through the 200 runs=20
it clocks up to ~43-45.  And the last temp on the list (after the sleep=20
1) is ~34.

Now, I know that this is low power CPU and it's got a relatively small=20
heatsink on the EPIA-SN board but I'm having trouble with the fact that=20
my CPU spikes by nearly 10 degrees just running bash once and=20
sensors+grep 202 times.

Just how CPU intensive is 'sensors' and why does it give me wildly=20
different CPU temps than acpi used to?

Note:  Here is the raw output of just a single run of sensors:

-------------------
# sensors
via_cputemp-isa-0000
Adapter: ISA adapter
Core 0:      +32.0=B0C
-------------------

I'm expecting replies like 'you are suffering from Heisenberg's=20
uncertainty principle'; the act of monitoring your CPU changes the=20
temp.  Or, 'that's a low power CPU so the moment it's not idle you see=20
the spike and the fact that a sleep 1 ramps the temperature down clearly=20
shows that it's dissipating heat from the heatsink relatively quickly..=20
so your heatsink probably doesn't have enough mass or there's something=20
wrong with the sensor in your chip'.

But almost 10 degrees just for running sensors+grep in a loop?

Note:  I also created a script that was just 200 instances of 'sensors |=20
grep Core' and I got the same progression of temperature rise so it's=20
not like the for loop on the `seq 1 200` is contributing to the spike.

Okay, so assuming that's the temperature profile of my CPU, I decided to=20
run 20 instances of the following script....

----------------------
while [ 1 ]; do echo 1234 > /dev/null ; done &
----------------------

That showed a system load of ~18 and a CPU usage 85%.  After 5 mins, I=20
ran my script and all of the CPU temps returned were at ~57 and they=20
held there.

So loading the CPU rose the temp by another 15 degC.  Fair enough.

So then I killed all of the while loops and re-ran my 200 'sensors'=20
runs.  The first temp was 46, the last temp was 53.  Again, sensors is=20
having a massive impact on my CPU... in fact, the 200 runs are reliably=20
causing a 10+ degC spike in the CPU, no matter what the temp.

That seems a bit much... even for a low power CPU [that starts at=20
'idle'] and that has airflow going over it that's way over spec and when=20
I only have one sensor module loaded.

I don't care about the CPU cycles, I'm just wondering if the via-cputemp=20
driver is doing something silly.  Your thoughts?

Cheers,
Dave.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
