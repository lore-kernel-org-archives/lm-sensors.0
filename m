From: "Hector Lahoz" <hectorlahoz@gmail.com>
Date: Sun, 16 Nov 2008 20:32:52 +0000
Subject: Re: [lm-sensors] can't start lm_sensors: Can't access procfs/sysfs
Message-Id: <efa7127e0811161232y129b85aer69bb576ee4cea0bd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <695200da0811150909u7b8804f6k8ae2ecb6076afdbb@mail.gmail.com>
In-Reply-To: <695200da0811150909u7b8804f6k8ae2ecb6076afdbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 15, 2008 at 6:09 PM, Rudi Ahlers <rudiahlers@gmail.com> wrote:
> Hi all,
>
> I'm trying to get lm_sensors working on CentOS 5.2, but get the following error:
>
> root@rewards1 dev]# /etc/init.d/lm_sensors restart; sensors
> Stopping lm_sensors:                                       [  OK  ]
> Starting lm_sensors: Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
>                                                           [FAILED]
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> [root@rewards1 dev]# insmod i2c-proc
> insmod: can't read 'i2c-proc': No such file or directory
> [root@rewards1 dev]# modprobe i2c-proc
> FATAL: Module i2c_proc not found.
>
>
>
> The machine is running kernel 2.6.18-92.1.10.el5xen
>
>  uname -a
> Linux rewards1.softdux.com 2.6.18-92.1.10.el5xen #1 SMP Tue Aug 5
> 08:46:32 EDT 2008 i686 i686 i386 GNU/Linux
>
>
> How do I get lm_sensors working on this kernel?
>
First of all, make sure you have sysfs support. To check run "mount".
You should see something like

sysfs on /sys type sysfs

in the ouotput. Next you have to know what chip you have. So run the
command "sensors-detect" as root. It'll find the chip and tell you
what drivers you need

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
