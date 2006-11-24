From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 24 Nov 2006 12:57:59 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <4566EC57.6040607@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Ulrich,

> I have an ASUS P5B-VM with an E6600 and would like to monitor the CPU
> temperatures. Sensors-detect only finds an LM78 chip which has only one
> temparature sensor. The temperature shown by sensors is obviously the
> Mobo-temperature (same as in BIOS).

The LM-78 is a misdetection. Please try latest sensors-detect (check the devices 
page on our web)

I bet you have W83627DHG, you will need a patch for this chip. Here is 
preliminary patch:

http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj



> I have read that Conroes possess integrated
> read out directly from CPU registers.
> a) Is this correct?

Yes

> b) Is this implemented in lm-sensors?

Yes but not yet in kernel. You will need latest SVN snapshot of lm-sensors (make 
user_install) and also this set of patches:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018100.html

(some of the patch files are posted TWICE, please use the latest version - click 
on mail thread to check what is latest)

> c) If yes, what do I have to do to get sensors show the CPU temperatures of the
> two cores?

CHeck above. You will have more than one sensor ;)

> Thank you for reply. If you need further info, please let me know.

Please let me know if it works OK, and David too.

Regards
Rudolf

