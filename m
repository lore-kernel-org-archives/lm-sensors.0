From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 19 Dec 2010 18:11:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83795) Silent false warning from
Message-Id: <20101219181145.GB18424@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101219124332.24e084ca@endymion.delvare>
In-Reply-To: <20101219124332.24e084ca@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Dec 19, 2010 at 06:43:32AM -0500, Jean Delvare wrote:
> The code triggers a false warning with older versions of gcc:
> w83795.c: In function 'w83795_update_device':
> w83795.c:475: warning: 'lsb' may be used uninitialized in this function
> 
> I admit that the code is a little tricky, but I see no way to write it
> differently without hurting performance. So let's just silent the
> warning with a needless initialization.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
