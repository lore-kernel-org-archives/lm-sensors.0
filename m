From: timm@fnal.gov (Steven Timm)
Date: Tue, 31 Oct 2006 14:25:17 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <Pine.LNX.4.64.0610310823500.10589@snowball.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Is the w83792d chip one of those supported in the newer 2.6 kernels?
that's the main one I need that the current redhat distro kernel doesn't 
have.

Also, which version of the Linus' 2.6 kernel tree should I point them at
to get the current production code level?

Steve Timm


On Tue, 31 Oct 2006, Jean Delvare wrote:

>
> Hi Steven,
>
> On 10/30/2006, Steven Timm wrote:
>> J. Baron's latest patch still reflects a pre-2.9.x version of
>> lm_sensors as far as I can tell.  I will try to open
>> a ticket with Red Hat on this.  Thanks
>
> It's important that you understand that there is no relation between the
> drivers in the lm_sensors package, which are for Linux 2.4, and the i2c
> and hardware monitoring drivers in the Linux 2.6 kernel tree. This is
> completely different code, and support for some chips is available on
> one side and not on the other side. And this is going to diverge even
> more in the future, as the 2.4 kernel driver set is more or less in
> maintenance mode and newer hardware is rather unlikely to be ever
> supported on 2.4 kernels.
>
> So if you're going to ask Red Hat to add support for some hardware
> monitoring devices to their RHEL4 product, do not ask them to add
> lm_sensors 2.10.x drivers, it simply doesn't make sense. Instead, ask
> them to backport hardware monitoring drivers from later 2.6 kernels.
>
> They might have to also update user-space support from the lm_sensors
> project for these backported drivers, but that's a separate issue.
>
> --
> Jean Delvare
>

-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm at fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

