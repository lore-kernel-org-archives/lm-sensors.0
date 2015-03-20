From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 20 Mar 2015 20:49:16 +0000
Subject: Re: [lm-sensors] [PATCH v4 1/5] util_macros.h: add find_closest() macro
Message-Id: <20150320134916.c81986f9ff43bd86f3b0d5cd@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1426786065-9798-1-git-send-email-bgolaszewski@baylibre.com>
	<1426786065-9798-2-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1426786065-9798-2-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Steven Rostedt <rostedt@goodmis.org>

On Thu, 19 Mar 2015 18:27:41 +0100 Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> Searching for the member of an array closest to 'x' is
> duplicated in several places.

Linear search is pretty nasty.  lib/bsearch.c could do this
with a bit of tweaking.  But that's a separate project.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
