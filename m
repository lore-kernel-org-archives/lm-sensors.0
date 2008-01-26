From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Jan 2008 16:40:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix Super-IO device ID
Message-Id: <20080126174027.520eee93@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
In-Reply-To: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 24 Jan 2008 09:42:52 -0800, Juerg Haefliger wrote:
> The dme1737 has a second place where the Super-IO device ID is
> checked. This has been missed by Jean's initial patch that adds
> support for user-controlled Super-IO device ID override. This patch
> fixes this issue.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

I'm confused. The patch you attached is exactly the same as the one I
sent originally. Did you send the wrong patch by any chance?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
