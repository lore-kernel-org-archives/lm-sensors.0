From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Nov 2008 10:50:05 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <20081118115005.74686b6c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 18 Nov 2008 10:34:13 +0100, Andreas Herrmann wrote:
> On Mon, Nov 10, 2008 at 10:34:10AM +0100, Jean Delvare wrote:
> > On Thu, 02 Oct 2008 00:20:38 +0200, Rudolf Marek wrote:
> > > What do you think?
> > 
> > Looking at your patch, there doesn't seem to be much in common between
> > the family 0Fh and the family 10h. The temperature conversion formula
> > is different, the registers are different... And I seem to understand
> > that the family 10h has a single sensor? In the end your patch is
> > larger than the k8temp driver itself. So I am wondering, does it really
> > make sense to support both families with the same driver?
> 
> IMHO this makes sense. The user just needs to switch on
> CONFIG_SENSORS_K8TEMP on a system with newer AMD CPUs (regardless
> whether the CPU is family 0xf, 0x10 or 0x11) and the driver is able to
> handle the CPU temperature sensor.

The default user really doesn't care. He/she runs a distribution with
all hwmon drivers compiled as modules, and the k8temp driver loads
automatically as needed. A potential fam10temp driver would also be
compiled as a module by default and would also load automatically, just
as the k8temp driver does. The user really doesn't care whether there
is one driver or two, he/she doesn't care how the drivers are named,
he/she doesn't even need to know that there _are_ drivers.

The advanced user doesn't care, either. He/she knows enough to enable
the right driver in all cases.

The rationale to add support to an existing driver vs. writing a new
driver is how much do these devices have in common. In the case of the
K8 vs. fam10h, the answer, as far as I can see, is: not much (see
details in my original reply above.)

> It's the same with powernow-k8. This cpufreq driver is used for all
> newer AMD CPU families as well.

Well, maybe the cpufreq interface to fam10h CPUs is the same as those
to K8 temp CPUs? In which case it makes sense to have a single driver.

Anyway, what the cpufreq people decided to do is not exactly relevant.
We don't have to follow them if we don't want to.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
