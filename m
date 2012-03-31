From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 31 Mar 2012 03:56:55 +0000
Subject: Re: [lm-sensors] [PATCH-v2] hwmon: k10temp: Add support for AMD Trinity CPUs
Message-Id: <20120331035655.GA23892@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333140500-24383-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333140500-24383-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Mar 30, 2012 at 04:48:20PM -0400, Andre Przywara wrote:
> The on-chip northbridge's temperature sensor of the upcoming
> AMD Trinity CPUs works the same as for the previous CPUs.
> Since it has a different PCI-ID, we just add the new one to the list
> supported by k10temp.
> This allows to use the k10temp driver on those CPUs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@amd.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
