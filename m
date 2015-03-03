From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 03 Mar 2015 08:15:09 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Nuvoton chip updates
Message-Id: <20150303091509.52f67e90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404094141-28146-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 27 Feb 2015 13:38:14 -0800, Guenter Roeck wrote:
> Document driver support for NCT7802Y.
> Add detection of NCT7904D.
> 
> Cc: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  CHANGES                    |  2 ++
>  prog/detect/sensors-detect | 33 ++++++++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> (...)

Looks good to me, please commit.

Do you have a full register dump of the NCT7904D that you could share
with me? Or maybe Vadim does?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
