From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 16:18:28 +0000
Subject: Re: [lm-sensors] [PATCH RESEND 3] hwmon/dme1737: add sch311x support
Message-Id: <20071009181828.37bec781@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710072127j7113780dx8a60b475d7a8f772@mail.gmail.com>
In-Reply-To: <191fb4ca0710072127j7113780dx8a60b475d7a8f772@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 7 Oct 2007 21:27:35 -0700, Juerg Haefliger wrote:
> 3rd iteration of the patch:
> - fixed header comment
> - replaced dme1737_update_device with dev_get_drvdata in show_name
> - replaced class_dev with hwmon_dev
> 
> 
> This patch adds support for the SMSC SCH3112, SCH3114, and SCH3116 Super-I/O
> chips. These chips feature identical hardware monitoring capabilites with the
> exception that some of the fan inputs and pmw outputs don't exist.
> 
> The hardware monitoring features of the SCH311x chips can only be accessed via
> the ISA bus. The driver therefore registers as a platform driver, if such a
> chip is detected.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

No more comments.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
