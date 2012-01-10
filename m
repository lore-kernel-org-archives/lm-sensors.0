From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 22:32:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon (k8temp): fix checkpatch issues
Message-Id: <20120110223225.GA7877@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326232900-326-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326232900-326-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 10, 2012 at 05:01:39PM -0500, Frans Meulenbroeks wrote:
> resolved:
> WARNING: line over 80 characters
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
>  drivers/hwmon/k8temp.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
Thanks, queued for -rc2.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
