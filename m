From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 22:32:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon (lm83): fix checkpatch issues
Message-Id: <20120110223242.GB7877@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326232900-326-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326232900-326-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 10, 2012 at 05:01:40PM -0500, Frans Meulenbroeks wrote:
> resolved:
> ERROR: trailing whitespace
> WARNING: please, no spaces at the start of a line
> WARNING: simple_strtol is obsolete, use kstrtol instead
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
>  drivers/hwmon/lm83.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
Thanks, queued for -rc2.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
