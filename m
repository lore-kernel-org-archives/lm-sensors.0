From: rhirst@levanta.com (Richard Hirst)
Date: Tue, 22 Nov 2005 23:35:10 +0000
Subject: [lm-sensors] Reading LM96000 on an Intel SE7221BK1 server board
Message-Id: <20051122223405.GF5252@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050622212816.GD7554@levanta.com>
In-Reply-To: <20050622212816.GD7554@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 22, 2005 at 07:13:14PM +0200, Arturas wrote:
> Hello Richard,
> 
> I have found Your messages in the list have simmilar hardware and same
> problems:
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012847.html
> 
> I want to read IPMI sensors data and no success :(
> 
> Could you describe witch patches have applied to kernel, to get sensor
> data? As I understod Intel provides ISM with closed drivers (IPMI also)
> only for RedHat and Suse. I have Debian...
> Maybe You have found intresting links about that.
> My MB is Intel E7221BK, not sure about PC87431M (maybe PC87427), but
> LM96000 is mentioned.

We are using Fedora Core 3, starting with kernel-2.6.10-1.766.FC3.src.rpm
and applying these additional patches:

linux-ipmi-2.6.10-base.diff
linux-i2c-2.6.10-nonblock.diff
linux-i2c-2.6.10-i801_nonblock.diff
linux-ipmi-2.6.10-smb.diff
patch-linux-2.6.11.5-bmcsensors.diff

We are using

lm_sensors-2.8.7-2.i386.rpm
ipmitool-1.8.2-1.i386.rpm

We have a patch in ipmitool which is just a fix to the rc script it
includes to load the ipmi_smb module.  You are probably more interested
in the modules we load, and the order we load them in.  I included the
full list below, and marked what I think are the relevant ones (>>):

   [root@localhost ~]# lsmod
   Module                  Size  Used by
   nfsd                  185697  9
   exportfs                9921  1 nfsd
   lockd                  59625  2 nfsd
>> bmcsensors             53861  0 
>> i2c_ipmi                8397  0 
>> i2c_dev                13249  0 
>> ipmi_smb               18601  1 
>> ipmi_devintf           11077  0 
>> ipmi_msghandler        41509  3 i2c_ipmi,ipmi_smb,ipmi_devintf
   sunrpc                135077  19 nfsd,lockd
   md5                     8001  1
   ipv6                  236897  20
   ip_conntrack_ftp       76145  0
   ip_conntrack_tftp       7921  0
   iptable_nat            27493  1
   ipt_state               5825  3
   ip_conntrack           45317  4 ip_conntrack_ftp,ip_conntrack_tftp,iptable_nat,ipt_state
   iptable_filter          7489  1
   ip_tables              20929  3 iptable_nat,ipt_state,iptable_filter
   video                  19653  0
   button                 10577  0
   battery                13253  0
   ac                      8773  0
   uhci_hcd               33497  0
   ehci_hcd               33737  0
   hw_random               9429  0
>> i2c_i801               13053  0 
>> i2c_core               29889  5 bmcsensors,i2c_ipmi,i2c_dev,ipmi_smb,i2c_i801
   e1000                  84373  0
   floppy                 56913  0
   raid1                  19393  2
   dm_snapshot            20709  0
   dm_zero                 6465  0
   dm_mirror              24861  2
   ext3                  117961  28
   jbd                    57177  1 ext3
   dm_mod                 57925  32 dm_snapshot,dm_zero,dm_mirror
   ata_piix               12485  4
   libata                 44101  1 ata_piix
   3w_9xxx                35013  1
   sd_mod                 20545  8
   scsi_mod              115649  3 libata,3w_9xxx,sd_mod
   [root@localhost ~]#


Having done this, I can read the sensors via ipmitool, or via lm_sensors:



[root@localhost ~]# sensors
bmc-i2c-1-00
Adapter: IPMI adapter
1.8V:      +1.81 V  (min =  +1.61 V, max =  +1.96 V)
5.0V:      +5.05 V  (min =  +4.55 V, max =  +5.58 V)
12V:      +12.45 V  (min = +10.78 V, max = +13.20 V)
BoardTemp: +29.0?C  (high =   +78?C, hyst =    +2?C)
CoreTemp:  +39.0?C  (high =   +88?C, hyst =    +2?C)

IPMI-i2c-0-42
Adapter: SMBus I801 adapter at 0400

[root@localhost ~]#


ot@localhost ~]# ipmitool sensor
Baseboard 1.8V   | 1.808      | Volts      | ok    | na        | 1.613     | 1.665     | 1.912     | 1.964     | na
Baseboard 5.0V   | 5.055      | Volts      | ok    | na        | 4.555     | 4.705     | 5.430     | 5.580     | na
Baseboard 12V    | 12.454     | Volts      | ok    | na        | 10.780    | 11.152    | 12.826    | 13.198    | na
Serverboard temp | 29.000     | degrees C  | ok    | na        | 0.000     | 5.000     | 65.000    | 78.000    | na
Proc1 Core temp  | 39.000     | degrees C  | ok    | na        | 5.000     | 10.000    | 81.000    | 88.000    | na
Proc IERR        | 0x0        | discrete   | 0x0000| na        | na        | na        | na        | na        | na
P1 Thermal Trip  | 0x0        | discrete   | 0x0000| na        | na        | na        | na        | na        | na
Interrupt Button | 0x0        | discrete   | 0x0000| na        | na        | na        | na        | na        | na
ID Button        | 0x0        | discrete   | 0x0000| na        | na        | na        | na        | na        | na
[root@localhost ~]#



The bmc sensors patch was from <http://bmcsensors-26.sourceforge.net>,
and the others were from <http://openipmi.sourceforge.net/>

It took me quite a while to get this working too; I started by trying
to talk to the sensor chips directly, but eventually I worked out that
they are probably only visible through the mBMC chip.  The mBMC chip
sits on the visible i2c bus, and then has the actual sensor chip on
a secondary i2c bus behind that, I believe.

I did manage to read one of the fan speeds via a driver I wrote, but
couldn't get at the sensor for the cpu fan speed, so didn't persue
that.

I don't think you'll have any joy with kernels newer than 2.6.12
because the bmcsensors code wont work.  It is being rewritten, I
believe, but I don't know the status.

Richard

