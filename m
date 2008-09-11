From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 11 Sep 2008 02:23:56 +0000
Subject: Re: [lm-sensors] [patch 2.6.27-rc6 2/6] hwmon/pc87360 separate
Message-Id: <20080910192356.08fe0bcc.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C79487.1010105@gmail.com>
In-Reply-To: <48C79487.1010105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 10 Sep 2008 20:16:43 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:

> 
> static ssize_t 
> show_in_max_alarm(struct device *dev, struct device_attribute *devattr, char *buf)

yes, that's a fairly common way of fixing a slightly-exceeds-80-cols problem.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
