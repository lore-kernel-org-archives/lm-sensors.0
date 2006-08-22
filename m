From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 22 Aug 2006 05:21:54 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <4dfa50520608212221v5fe060cdmccfb3b8b7df86e22@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Attached is a patch for 2.6.18-rc4 as well as the complete driver
(w83627ehf.c). It tests the return value when device_create_file() is
called. I would like to add sysfs_create_group() calls with another
patch. Anyone who would like to test the patch, please do.

Sylvain, if you are running a 2.4-series kernel, take a look at
i2c-isa_return_attach_adapter.patch as well (in this thread). I do not
know if this will backport to the 2.4 kernel successfully. I have also
attached a regression test script (w83627ehf_regression.sh) which
matches this driver. There is not a way to script a test for the
changes made to correctly handle device_create_file() errors, so this
regression test is the same as previous tests.

Thanks,
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_unchecked_device_create_file.patch
Type: application/octet-stream
Size: 5584 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060821/9c4b9641/attachment-0002.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf.c
Type: application/octet-stream
Size: 43824 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060821/9c4b9641/attachment-0003.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 16224 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060821/9c4b9641/attachment-0001.sh 
