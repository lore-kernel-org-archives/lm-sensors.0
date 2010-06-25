From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Jun 2010 14:49:36 +0000
Subject: Re: [lm-sensors] ASUS P7P55D PRO
Message-Id: <20100625164936.608f7754@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
In-Reply-To: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Jun 2010 15:24:45 +0200, Luca Tettamanti wrote:
> On Fri, Jun 25, 2010 at 10:38 AM, David Cussans
> <David.Cussans@bristol.ac.uk> wrote:
> >
> > Luca,
> >    Many thanks for your mail, and the information that where is an ACPI
> > driver that should work.
> >
> >    Alas, I am using Scientific Linux 5.4 ( a variant of RHEL 5.x ) which
> > uses kernel version 2.6.18, where this driver isn't present. Although I am
> > very keen to find out how hot the CPU is running I doubt I will have time to
> > back-port the asus_atk0110 driver and I am reluctant to risk breaking a lot
> > of other things by moving away from a locally supported platform.
> >
> >    I don't really understand which firmware is using the hardware monitoring
> > device (W83667HG-B ? ).
> 
> ACPI (i.e. the your BIOS). Furthermore IIRC your board has an EC
> (external controller - basically another chip running its own
> firmware) which polls the hwmon chip on its own.
> 
> > Forgive my confusion, but is it possible, even in
> > theory, to write a user-space lm_sensors driver for this motherboard?
> 
> You can't do that in userspace, but yorur chip should be supported by
> w83627ehf in recent kernels, you can try and backport it (it should be
> fairly self-contained, while asus_atk0110 requires modification in
> core ACPI code).

No, the W83667HG-B isn't supported yet. Still David can takes his
chance and force W83667HG operation - at his own risks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
