From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 17:23:17 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/3] Add support for additional sysfs
Message-Id: <20120109182317.479bf33a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326068484-1898-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326068484-1898-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  8 Jan 2012 16:21:24 -0800, Guenter Roeck wrote:
> inX_average
> inX_lowest
> inX_highest
> tempX_lowest
> tempX_highest
> currX_average
> currX_lowest
> currX_highest
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v3:
> - Separated into two patches, one to automatically handle array sizes and one
>   to add new sensors.
> - Fixed array size calculations (in separate patch)
> - Removed code to display average power in addition to instantaneous power if
>   both are available.

Looks all OK now, thanks.

> - In doc/libsensors-API.txt, moved new attributes to new version entry.
>   Not sure what is correct here, and if the API version number needs to change.

That's the right thing to do. I'll attribute a new API/ABI version
number as I release lm-sensors version 3.3.2.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
