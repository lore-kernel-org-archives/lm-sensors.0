From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Mar 2010 10:18:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add basic support for LM64 to lm63.c
Message-Id: <20100319111831.3a21c245@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100318084135.15fb1996@hyperion.delvare>
	<1268919419-2125-1-git-send-email-mjg@redhat.com>
In-Reply-To: <1268919419-2125-1-git-send-email-mjg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg@redhat.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, 18 Mar 2010 09:36:59 -0400, Matthew Garrett wrote:
> The LM64 appears to be an LM63 with added GPIO lines. Add support for the
> hwmon functionality - GPIO can be added at some later stage if someone
> has a need for them.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> 
> Capitalisation fixes and remove an unused variable.

Applied, thanks!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
