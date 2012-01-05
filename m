From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 05 Jan 2012 17:44:45 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] lm80.c: add error handling
Message-Id: <20120105174445.GB9257@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325770914-23620-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325770914-23620-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jan 05, 2012 at 08:41:53AM -0500, Frans Meulenbroeks wrote:
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
> 
> Tested with actual system
> 
>  drivers/hwmon/lm80.c |  132 ++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 101 insertions(+), 31 deletions(-)
> 
Looks ok to me. I'll add it for a release candidate after the commit window for 3.3
closes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
