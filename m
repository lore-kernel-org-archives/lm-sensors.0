From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-Id: <200405071242.i47CgHPE027360@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20040505221804.GE29885@kroah.com>
References: <20040502220632.06cefb60.khali@linux-fr.org>
In-Reply-To: <20040502220632.06cefb60.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>


>> Greg, please apply if it looks good to you. Sorry for introducing the
>> leak in the first place...
>
>Looks a bit odd, but ok.

Odd? Why that? If you can think of something better, just tell me. The
only other way I could think of was faking subclient's private data so
that it points to the i2c_client structure itself. That way, freeing
i2c_get_clientdata(client) would always work. However, I was fearing
some side effect. Maybe the code makes use of the NULL data for
remembering which clients are subclients at some point? I think I
remember that the 2.4 drivers did, but maybe the 2.6 ones don't. I can
take another look and propose that different solution if you want.

Thanks.
