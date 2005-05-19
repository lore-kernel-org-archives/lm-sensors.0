From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4] (dynamic sysfs callbacks) adm1026 (2nd try)
Message-Id: <2538186705051113106f6f14fd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
	 <20050511170750.GE15398@kroah.com>
In-Reply-To: <20050511170750.GE15398@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Justin Thiessen <jthiessen@penguincomputing.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

Attached is the corrected adm1026 patch (incorrect casting of void *
argument in callbacks). Justin if you have the ability to test this
patch that would be much appreciated.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 adm1026.c |  235
++++++++++++++++++++------------------------------------------ 1 files
changed, 78 insertions(+), 157 deletions(-)
---
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026.diff
Type: text/x-patch
Size: 21737 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050511/5afb2d01/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-adm1026.bin
