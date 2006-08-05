From: stelian@popies.net (Stelian Pop)
Date: Sat, 05 Aug 2006 07:26:00 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <1154762761.755.1.camel@deep-space-9.dsnet>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le samedi 05 ao?t 2006 ? 01:03 +0200, Michael Hanselmann a ?crit :
> On Fri, Aug 04, 2006 at 03:19:52PM -0700, Andrew Morton wrote:
> > Could I please be sent a new copy of the whole patch, with the appropriate
> > acked-bys, signed-off-bys, etc?
> 
> Sure, here we go.
> 
> - Rename exported variable "ams" to "ams_info"
> - Fix leaked input device on error
> - Change I?C read code to use schedule_timeout instead of msleep() in
>   case the first read failed
> 
> Signed-off-by: Michael Hanselmann <linux-kernel at hansmi.ch>
> Signed-off-by: Aristeu Sergio Rozanski Filho <aris at cathedrallabs.org>
> Acked-by: Ren? Nussbaumer <linux-kernel at killerfox.forkbomb.ch>

You can also add my 
	Signed-off-by: Stelian Pop <stelian at popies.net>
to the whole ams patch.

Thanks,

Stelian.
-- 
Stelian Pop <stelian at popies.net>


