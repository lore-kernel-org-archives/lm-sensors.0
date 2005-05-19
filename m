From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Setting w83627hf fan divisor 128 fails.
Message-Id: <c2u481598oe7tdrt0nkacjro7mvabe753n@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050508193026.GA777@smooth.piipiip.net>
In-Reply-To: <20050508193026.GA777@smooth.piipiip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2005 20:15:51 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Same for both the w83627hf and w83781d drivers in Linux 2.6 as far as I
>can see. 
>
>Could anyone please check and provide patches for these as well?

And I'm planning to put auto fan_div in one day soon :)

Removing all that old set_fan_div...

--Grant.
