From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: temperature monitor on my w83627hf-isa-0290
Message-Id: <mglq71dnq0o9v1e224rh0eclh2mnptca7a@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0505062352260.4119@c-24-130-248-54.hsd1.ca.comcast.net>
In-Reply-To: <Pine.LNX.4.61.0505062352260.4119@c-24-130-248-54.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 7 May 2005 14:16:59 -0700 (PDT), chekov@alum.wpi.edu wrote:

>I do have one more question though.  I noticed that when my CPU was running 
>hot, the kernel itself was reporting the high temp and further switching 
>into "modulated clock mode".  I assume this has something to do with the 
>CONFIG_ACPI_THERMAL or CONFIG_X86_MCE_P4THERMAL settings in the kernel.
>Since the kernel seems to know when my proc is running over temp, I have to 
>assume it either knows the temp itself or has some tie into the alarm.  any 
>way I could see into that stuff in userland?

CPU temp and some (very limited) other stuff gets reported through ACPI.

--Grant.
