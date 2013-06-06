From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jun 2013 17:08:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1021) Strengthen chip detection for LM84 and MAX1617
Message-Id: <20130606190838.00ca69ce@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1370467996-27091-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 6 Jun 2013 09:55:12 -0700, Guenter Roeck wrote:
> On Thu, Jun 06, 2013 at 03:51:40PM +0200, Jean Delvare wrote:
> > Note that the LM84 also doesn't have registers at 0xFE and 0xFF, still
> > the detection function reads from these, apparently without trouble.
> 
> We don't really check if the reads return an error, though. 
> (...)
> Would it be acceptable to check if reading 0xfe and 0xff return an error ?
> That would help weeding out some chips (the JC42 chips on our board return
> an error when reading register 0x08, for example).

We should definitely check for error on all SMBus calls in the detect
function.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
