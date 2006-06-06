From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 06 Jun 2006 18:56:28 +0000
Subject: [lm-sensors] FYI: [ patch 00/19 ] chardev: GPIO support for SCx200
Message-Id: <4485CFDC.7080002@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi folks,

I recently posted a patchset to kernel-mentors,
which modernizes scx200_gpio and adds pc8736x_gpio.

http://www.selenic.com/pipermail/kernel-mentors/2006-May/000474.html

Its evidently somewhat on-topic here, and its been languishing over there,
so I figured Id invite you all to review it.

I took a timid legacy-updates approach to this, hoping to
streamline the review by avoiding controversy like what a
shiny new sysfs GPIO interface would look like. (Ooops ;-)

Should I repost the patch-set here ?
Or is it unrealistic to hope for room in the current review backlog,
    esp given the relative newness of gpio within hwmon/



