From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 24 Mar 2006 20:57:07 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: new vt1211 driver
Message-Id: <44245D23.9080304@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
In-Reply-To: <191fb4ca0602251324o560dcd61oc55dc703f452a570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

I'm attaching commented version in file.

Sometimes there are places with spaces and not tabs (especially in #define ) plus some operators like + dont have spaces around too.
I'm proposing that some of funcs can be done via macro or 2D array. This might help to shrink the source code a bit.
I'm not user about the runtime UCONFIG configuration. Perhaps cleanest solution would be to create/remove sysfs nodes
runtime instead of exporting them with zero.
Also I think several printks can be replaced with dev_err stuff.
Last thing to discuss is about the forced interrupt mode. I'm not sure if it is OK because it may affect the chip
pins.
I'm not too familiar with the platform stuff yet so I'm asking Jean to look into this.

Overall the code looks very good. I tried to read all the stuff carefuly but it is quite difficult not to miss anything.
(and even I spent like 3 hours just with reading and I'm not even sure :( )

Regards
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-vt1211-new-driver.patch
Type: text/x-patch
Size: 41217 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060324/46c3f4b5/hwmon-vt1211-new-driver-0001.bin
