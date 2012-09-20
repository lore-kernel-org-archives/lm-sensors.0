From: Andreas Hartmann <andihartmann@01019freenet.de>
Date: Thu, 20 Sep 2012 16:26:01 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon, fam15h_power: Tweak runavg_range on resume
Message-Id: <505B4399.7070708@01019freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120920103408.GD4602@alberich>
In-Reply-To: <20120920103408.GD4602@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Andreas,

Andreas Herrmann wrote:
> 
> The quirk introduced with commit
> 00250ec90963b7ef6678438888f3244985ecde14 (hwmon: fam15h_power: fix
> bogus values with current BIOSes) is not only required during driver
> load but also when system resumes from suspend. The BIOS might set the
> previously recommended (but unsuitable) initilization value for the
> running average range register during resume.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>


I could test your patch successfully with kernel 3.4.11. The reported
power consumption

fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       28.45 W

works now as expected.


Thanks,
kind regards,
Andreas Hartmann


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
