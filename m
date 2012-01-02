From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 02 Jan 2012 16:53:33 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] drivers/hwmon/lm80: fix line exceeds
Message-Id: <20120102165333.GD17788@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-4-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-4-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 02, 2012 at 06:03:23AM -0500, Frans Meulenbroeks wrote:
> as reported by cleanfile
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

checkpatch -f reports 23 errors and 18 warnings on lm80,c, and it reports
8 errors on your patch alone (missing spaces).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
