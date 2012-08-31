From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Aug 2012 16:04:39 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add Maxim MAX197 support
Message-Id: <20120831160439.GA5756@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1346377377-24717-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1346377377-24717-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org

On Thu, Aug 30, 2012 at 09:42:57PM -0400, Vivien Didelot wrote:
> The MAX197 is an A/D converter, made by Maxim. This driver currently
> supports the MAX197, and MAX199. They are both 8-Channel, Multi-Range,
> 5V, 12-Bit DAS with 8+4 Bus Interface and Fault Protection.
> 
> The available ranges for the MAX197 are {0,-5V} to 5V, and {0,-10V} to
> 10V, while they are {0,-2V} to 2V, and {0,-4V} to 4V on the MAX199.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
