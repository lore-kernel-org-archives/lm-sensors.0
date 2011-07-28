From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 05:54:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm78) Avoid forward
Message-Id: <20110728055400.GA21792@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jul 23, 2011 at 12:07:35PM -0400, Jean Delvare wrote:
> Move code around to avoid several forward declarations. Also group
> ISA-related functions together, to make future changes easier.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Dean Nelson <dnelson@redhat.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
