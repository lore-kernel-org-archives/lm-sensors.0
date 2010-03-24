From: Dean Nelson <dnelson@redhat.com>
Date: Wed, 24 Mar 2010 14:44:51 +0000
Subject: [lm-sensors] 'modprobe coretemp' seeing "Unable to access MSR 0xEE,
Message-Id: <4BAA2563.9090702@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020807090005000905090409"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807090005000905090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

When doing a 'modprobe coretemp' on a system installed with RHEL6 (which
is based on linux-2.6.32), I'm seeing "Unable to access MSR 0xEE, for
Tjmax, left at default" type errors.

My question is whether this is what I should expect from the system I'm
running on?

Some of the (hopefully) relevant details can be found in the attached
file.

Thanks,
Dean

--------------020807090005000905090409
Content-Type: text/plain;
 name="zz"
Content-Disposition: attachment;
 filename="zz"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx1.redhat.com id o2OEirIX019455


 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||

[root@dell-per710-01 ~]# modprobe coretemp
[root@dell-per710-01 ~]# sensors -s
[root@dell-per710-01 ~]# dmesg | tail -20
bnx2: eth1 NIC Copper Link is Up, 1000 Mbps full duplex
ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
eth2: no IPv6 routers present
eth1: no IPv6 routers present
coretemp coretemp.0: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.1: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.2: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.3: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.4: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.5: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.6: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.7: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.8: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.9: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
coretemp coretemp.10: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
coretemp coretemp.11: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
coretemp coretemp.12: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
coretemp coretemp.13: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
coretemp coretemp.14: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
coretemp coretemp.15: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
[root@dell-per710-01 test]# sensors
coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +38.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +37.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +35.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0004
Adapter: ISA adapter
Core 4:      +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0005
Adapter: ISA adapter
Core 5:      +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0006
Adapter: ISA adapter
Core 6:      +36.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0007
Adapter: ISA adapter
Core 7:      +35.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0008
Adapter: ISA adapter
Core 8:      +38.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-0009
Adapter: ISA adapter
Core 9:      +37.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000a
Adapter: ISA adapter
Core 10:     +35.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000b
Adapter: ISA adapter
Core 11:     +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000c
Adapter: ISA adapter
Core 12:     +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000d
Adapter: ISA adapter
Core 13:     +39.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000e
Adapter: ISA adapter
Core 14:     +35.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

coretemp-isa-000f
Adapter: ISA adapter
Core 15:     +35.0=C2=B0C  (high =3D +90.0=C2=B0C, crit =3D +100.0=C2=B0C=
) =20

[root@dell-per710-01 test]#=20


 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 The system I'm running on has 16 CPUs, all much like the following one:

[root@dell-per710-01 ~]# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 26
model name	: Intel(R) Xeon(R) CPU           E5530  @ 2.40GHz
stepping	: 5
cpu MHz		: 2393.589
cache size	: 8192 KB
physical id	: 1
siblings	: 8
core id		: 0
cpu cores	: 4
apicid		: 16
initial apicid	: 16
fpu		: yes
fpu_exception	: yes
cpuid level	: 11
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat ps=
e36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall rdtscp lm con=
stant_tsc arch_perfmon pebs bts rep_good xtopology tsc_reliable nonstop_t=
sc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm =
dca sse4_1 sse4_2 popcnt lahf_lm ida tpr_shadow vnmi flexpriority ept vpi=
d
bogomips	: 4787.17
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management:

<snip>
[root@dell-per710-01 ~]#=20


 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||

[root@dell-per710-01 ~]# sensors-detect
# sensors-detect revision 1.1
# System: Dell Inc. PowerEdge R710
# Board: Dell Inc. 0M233H

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): no

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): no

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): no

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): no
Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): no
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe coretemp
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

[root@dell-per710-01 ~]#


 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 I also ran after adding a debug printk() following each call to
 rdmsr_safe_on_cpu() in coretemp.c. And also setting eax and edx to 0 bef=
ore
 each call. The following was what I pulled from dmesg after running
 'modprobe coretemp'.

 Notice for 0xee rdmsr_safe_on_cpu() returns a -5 or -EIO. Are the values=
 of
 eax=3D0x200200 and edx=3D0x100100 meaningful (aside from somewhat resemb=
ling
 LIST_POISON2 and LIST_POISON1)? Also notice that for CPU 11, eax=3D0x246=
 and
 edx=3D0xa655c68.


debug: rdmsr_safe_on_cpu(id=3D0x0, 0x19c,) err=3D0 eax=3D0x883e0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x0, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x0, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.0: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x0, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x1, 0x19c,) err=3D0 eax=3D0x883e0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x1, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x1, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.1: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x1, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x2, 0x19c,) err=3D0 eax=3D0x88400008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x2, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x2, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.2: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x2, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x3, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x3, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x3, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.3: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x3, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x4, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x4, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x4, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.4: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x4, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x5, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x5, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x5, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.5: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x5, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x6, 0x19c,) err=3D0 eax=3D0x88400008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x6, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x6, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.6: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x6, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x7, 0x19c,) err=3D0 eax=3D0x88410008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x7, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x7, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.7: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x7, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x8, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x8, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x8, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.8: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x8, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0x9, 0x19c,) err=3D0 eax=3D0x883e0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0x9, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0x9, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.9: Unable to access MSR 0xEE, for Tjmax, left at defaul=
t
debug: rdmsr_safe_on_cpu(id=3D0x9, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xa, 0x19c,) err=3D0 eax=3D0x88400008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xa, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xa, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.10: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xa, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xb, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xb, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xb, 0xee,) err=3D-5 eax=3D0x246 edx=3D0xa6=
55c68
coretemp coretemp.11: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xb, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xc, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xc, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xc, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.12: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xc, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xd, 0x19c,) err=3D0 eax=3D0x883d0008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xd, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xd, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.13: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xd, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xe, 0x19c,) err=3D0 eax=3D0x88400008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xe, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xe, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.14: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xe, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

debug: rdmsr_safe_on_cpu(id=3D0xf, 0x19c,) err=3D0 eax=3D0x88410008 edx=3D=
0x0
debug: rdmsr_safe_on_cpu(id=3D0xf, 0x17,) err=3D0 eax=3D0x0 edx=3D0x0
debug: rdmsr_safe_on_cpu(id=3D0xf, 0xee,) err=3D-5 eax=3D0x200200 edx=3D0=
x100100
coretemp coretemp.15: Unable to access MSR 0xEE, for Tjmax, left at defau=
lt
debug: rdmsr_safe_on_cpu(id=3D0xf, 0x1a2,) err=3D0 eax=3D0x610a00 edx=3D0=
x0

 ||||||||||||||||||||||||||||||||||||||||||||||||||||||||


--------------020807090005000905090409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020807090005000905090409--
