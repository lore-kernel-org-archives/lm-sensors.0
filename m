From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Wed, 10 Dec 2008 10:03:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (k8temp) adapt cpuid handling,
Message-Id: <20081210100333.GH19144@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081205174612.GB5581@alberich.amd.com>
In-Reply-To: <20081205174612.GB5581@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 09, 2008 at 11:12:39PM +0100, Rudolf Marek wrote:
> Hello,
>
> Sorry for the delay.
>
>> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
>
> Maybe also some desc. Well the reason why the code below looks like is that
>
> 1) avoid very old systems - the idea that revs of CPU will be similar/same
> 2) get the cpuid from PCI. This is good, because some CPU may have the 
> problem, some other may not.

Jean gave examples of a systems where the PCI will not work. Thus
it isn't a reliable way to get CPUID. By problem you mean certain
erratum.  But this can only happen on systems with an unspported mixed
silicon setup.  E.g. combining K8 RevE with K8 RevF which is
(according to AMD's documentation) not a supported setup.

> Your patch reduces this to boot CPU checks. The idea was to have the driver 
> know exact CPUID for each PCI driver instance. It was prepared to situation 
> when some CPU steppings will have the fix, some not.
>
> Please tell me why it is not necessary or why you changed that ;)

For mixed silicon systems certain restrictions apply.
The allowed mixed silicon revisions for K8 and family 0x10 show
that it completely suffices for k8temp to check the revision of
the boot CPU.

E.g. if boot CPU is >= K8 RevC all other processors should be >=RevC <=RevE
If boot CPU is RevF all other processors should be RevF.
(Similar for family 0x10 RevB or RevC.)

And last not least K8 RevG is desktop/mobile only -- so no mixed setup
here at all.

Thus all relevant CPUID checks in k8temp can reliably be performed
with boot CPU information and no additional CPUID evaluation code is
needed in k8temp.


Regards,
Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
