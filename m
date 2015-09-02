From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 02 Sep 2015 08:45:01 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add support for NCT6793D
Message-Id: <20150902104501.021c3985@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 31 Aug 2015 16:57:33 -0700, Guenter Roeck wrote:
> NCT6793D is register compatible with NCT6792D.
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/nct6775 |  4 ++++
>  drivers/hwmon/Kconfig       |  4 ++--
>  drivers/hwmon/nct6775.c     | 29 ++++++++++++++++++++++-------
>  3 files changed, 28 insertions(+), 9 deletions(-)
> (...)

Looks good to me (didn't check the datasheet, trusting you on the fact
that the chips are compatible) except that you forgot to add a name
string for the new chip to nct6775_sio_names[].

With that fixed:
Reviewed-by: Jean Delvare <jdelvare@suse.de>

Note: given that enum kinds is used to index nct6775_sio_names[], it
would feel safer to have nct6775_sio_names[] defined closer to enum
kinds, as nct6775_device_names[] is already.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
