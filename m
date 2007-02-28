From: mpiktas@gmail.com (Vaidotas Zemlys)
Date: Wed, 28 Feb 2007 15:01:26 +0000
Subject: [lm-sensors] support for Asus F3Jp laptop
Message-Id: <e47808320702280701i14a0ee20vb4745361c55d09bb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I recently bought Asus F3Jp laptop. I've already installed Linux
(Ubuntu 6.10 Edgy Eft) and now I am in the process of discovering what
sensors are available. This laptop has T7200 Intel Core 2 Duo
processor and Ati x1700 graphics card, I am running linux kernel
2.6.17 supplied by Ubuntu, and I have lm-sensors 2.10.0 installed also
supplied by Ubuntu. I ran sensors-detect, and it detected and loaded
bus support for Intel ICH7. But when I ran sensors, I received a
message that i2c is not available and I should check wheher I have
sysfs. I googled this message and found various responses, usually
telling that it is a sign that lm-sensors do not support my system.
Hence I am writing this letter.

I tried downloading and compiling latest lm-sensors, but it failed
after make user, with message that there is no make rule for file
stdio.h or something like that. I ran newest sensors-detect as told in
installation wizard, and it also detected  that I should load coretemp
kernel module. Now this module is in lm-sensors source, or I should
compile a new kernel?

Currently I can see only the temperature reading from
/proc/acpi/thermal_zone/THRM/temperature. I have module fan loaded but
directory /proc/acpi/fan is empty. I am not very knowledgeable in
details which drivers control what, but I want to find what sensors I
can read on this laptop. I am willing to test new software and give as
much information as possible.

Vaidotas Zemlys

PS I was vague on error message details, because I do not have the
laptop at hand I will post followup with detailed error messages.

