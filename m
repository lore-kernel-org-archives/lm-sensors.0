From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 02 Jun 2005 07:24:26 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm1 0/3] i2c: new sysfs class
Message-Id: <ah5t9154qag9j47qlmr51qqe0m6aujojdi@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602032840.GA4906@jupiter.solarsys.private>
In-Reply-To: <20050602032840.GA4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 1 Jun 2005 23:28:40 -0400, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
>With these patches applied, 'tree -d /sys/class/hwmon' looks like this:
>
>/sys/class/hwmon
>`-- w83627thf-0
              ^^-- is it possible / make any sense, to not append anything 
                   for the first (usually only) device? eg. "", "-1", "-2"...
>    `-- device -> ../../../devices/platform/i2c-1/1-0290

--Grant.

