From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 26 Oct 2010 13:53:29 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <4CC6DD59.30903@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> > > Doh. You are aware that Core i7 CPUs are made by Intel and Family 10h
> > > (aka K10) CPUs are made by AMD, aren't you? They are different CPU
> > > models, they don't have to be designed the same way.
> > 
> > I know that :)
> > I thought maybe that is a standard and each cpu temperature must be show
> > separetly.
> 
> There is no such standard.

And on the newest CPUs, Intel has switched to one temperature sensor per
package.

> On Tue, 26 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:
> > One more question, Is it possible to find out which two modules are tied to one 
> > processor?
> 
> Modules?
> 
> > Currently there are:
> > k10temp-pci-00c3
> > temp1:       +27.0°C  (high = +70.0°C, crit = +70.0°C)
> > k10temp-pci-00cb
> > temp1:       +27.0°C  (high = +70.0°C)
> > k10temp-pci-00d3
> > temp1:       +26.0°C  (high = +70.0°C)
> > k10temp-pci-00db
> > temp1:       +26.0°C  (high = +70.0°C, crit = +70.0°C)
> >  
> > Is it true that [00c3 and 00cb] are for one physical cpu and [00d3 and 00db] are 
> > for the other cpu?

I conclude from this question that you have two CPUs, and that each CPU
has two temperature sensors.

The temperature sensor is part of the PCI device that associated with
the CPU's internal northbridge.  IIRC the six-core CPUs have two
northbridges, for whatever technical reason, so they present two
temparature sensors to the OS.

It looks as if the two sensors in each CPU have the same value.  Is this
always the case?

(I don't know where the c3/cb/d3/db names come from.)

> All entries in cpuinfo look the same, so I can't explain why some have
> the critical limit and some don't.

The limit is set by the BIOS.  I'd guess the BIOS knows that two sensors
are actually the same, an so doesn't bother to set the limit on the
superfluous ones.

I'll look into the datasheet to see if this situation (two northbridges
per CPU) is documented and can be detected so that the driver can ignore
these superfluous sensors.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
