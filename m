From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Dec 2008 15:38:46 +0000
Subject: Re: [lm-sensors] Sensors 3.0.3 on CentOS 5.2 (kernel 2.6.18) shows
Message-Id: <200812261638.47139.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4953F5E1.8050906@Winfirst.Com>
In-Reply-To: <4953F5E1.8050906@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Mark, Hans,

Le Vendredi 26 Décembre 2008 12:17, Hans de Goede a écrit :
> Mark E. Hansen wrote:
> > Some time ago, I upgraded my Linux machine to use a new motherboard:
> > 
> >   ASUS M2NPV-VM
> > 
> > At that time, I was told (on this list) that my CentOS Linux kernel was
> > too old for the 3.0.X version of the lm_sensors package. I've now upgraded
> > the machine to CentOS 5.2, which includes the Linux kernel 2.6.18.
> > 
> > I downloaded lm_sensors-3.0.3 from http://www.lm-sensors.org/wiki/Download
> > and built/installed successfully. This included some changes to the system's
> > ld.so.conf to include /usr/local/lib on the system LD path.
> > 
> > When I ran sensors-detect, it found the following:
> > 
> >   It said it found 'ITE IT8716F Super IO Sensors', address 0x290,
> >   driver 'it87'.
> > 
> >   It also said it found an AMD K8 thermal sensor embedded with the CPU
> >   (driver 'k8temp').
> > 
> > I had it create the /etc/sysconfig/lm_sensors file, which looks like
> > this (sans the comments):
> > 
> >   MODULE_0=it87
> >   MODULE_1=k8temp
> > 
> > I then created the /etc/init.d/lm_sensors file (as per the instructions)
> > and started the service.
> > 
> > I ran sensors -s (as root), but when I run sensors, the only output
> > I get is this:
> > 
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +33.0°C
> > Core1 Temp:  +37.0°C
> > 
> > Well, this appears to be showing me good CPU temps, but where is
> > the rest of the it87 chip data? Did I miss a step?
> > 
> 
> The CentOS 2.6.18 kernel does not have the it87 driver.

Or, more likely, it has the it87 driver but that driver doesn't yet
support the ITE IT8716F. Looking at:
  http://www.lm-sensors.org/wiki/Devices
it says that support was added in kernel 2.6.19.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
