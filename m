From: bob2@dsv.nl (Bob =?ISO-8859-1?Q?Schl=E4rmann?=)
Date: Fri, 19 Jan 2007 21:27:35 +0000
Subject: [lm-sensors] generic chip support for libsensors
Message-Id: <20070119222735.2f12ca0c@ws01.atreidis.nl.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list,

This patch makes it possible for libsensors to handle chips that aren't
in the static chip definitions list. It works by reading out the sysfs
directory of the device and filling up a sensors_chip_features
accordingly.

Note that printing in sensors only works with the -u switch or the
generic printing patches [1].

It has been verified to work on the following chipsets: fscher, it87
pc87366

Any comments are welcome,

--
Bob Schl?rmann (and the generic lmsensors team)

1: http://www.atreidis.nl.eu.org/lm_sensors/
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors_dynamic_chip_def.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070119/381772ac/attachment.pl 
