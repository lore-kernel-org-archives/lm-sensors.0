From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Wed, 10 Dec 2008 10:10:05 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (k8temp) fix temperature
Message-Id: <20081210101005.GI19144@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081205175626.GE5581@alberich.amd.com>
In-Reply-To: <20081205175626.GE5581@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 09, 2008 at 11:38:14PM +0100, Rudolf Marek wrote:
> Huh interesting stuff. Any pointers to documentation please?

No pointer, sorry.

The AMD family 0Fh BKDG is incorrect wrt K8 RevG desktop CPUs.
I'll try to address this but I am not sure whether the documentation
will be updated.


Regards,
Andreas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
