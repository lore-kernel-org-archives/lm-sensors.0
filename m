From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 17:59:26 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Display both instantaneous and
Message-Id: <20120109185926.20cf9538@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326130073-4791-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326130073-4791-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  9 Jan 2012 09:27:53 -0800, Guenter Roeck wrote:
> Some sensor chips report both instantaneous and average power.
> Add support to display both.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  prog/sensors/chips.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)
> (...)

Looks good, please commit.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
