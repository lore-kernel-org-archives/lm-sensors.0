From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 13:05:11 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon/sch5627: Add sch5627_send_cmd
Message-Id: <20110511150511.1af77e4e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305117101-4325-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1305117101-4325-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2011 14:31:40 +0200, Hans de Goede wrote:
> This patch generalizes sch5627_read_virtual_reg so that it can
> be used to write virtual regs too.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hwmon/sch5627.c |   23 +++++++++++++++++++----
>  1 files changed, 19 insertions(+), 4 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
