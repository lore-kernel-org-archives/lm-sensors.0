From: nick@linicks.net (Nick Warne)
Date: Fri, 17 Feb 2006 13:09:17 +0000
Subject: [lm-sensors] [HWMON] Add LM82 support
Message-Id: <7c3341450602170509l122247f8y@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060216175930.GE20157@cosmic.amd.com>
In-Reply-To: <20060216175930.GE20157@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, Jean Delvare <khali@linux-fr.org>

'
>                 if (kind <= 0) { /* identification failed */
> @@ -296,10 +318,15 @@ static int lm83_detect(struct i2c_adapte
>         if (kind = lm83) {
>                 name = "lm83";
>         }
> +       else if (kind = lm82) {
> +               name = "lm82";
> +       }

Is that a '=' typo in the 'else if' there?

Nick

