From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 21 Jun 2005 08:49:05 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42B7B838.9010802@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,
>>to
>>monitor the temperature on the SuperMicro P8SCT motherboard that my
> 
> team is
> 
>>evaluating.

I have ready a patch for 2.6.x kernels (2.6.11, 2.6.12 older might work too) please see the attachment.
And also you need to use CVS version of lm_sensors.Download from here:
http://secure.netroedge.com/~lm78/archive/lm_sensors-daily.tar.gz
and compile with:
make user; make user_install

Please let us know how it works.

> I have finished the porting of w83792d driver to the 2.6 kernel, and
> submitted
> it to the lm_sensors group. Rudolf, the member of lm_sensors group
> helped me
> to finish the documents and will submit it to the kernel term for me in
> the
> near future, I think.

Yes I will work on it today. It is nearly ready and soon it will go to -mm- series of kernels.
There were some sysfs callbacks changes in -mm- and this needs to be incorporated to the driver.

Regards
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch_w83792d-2.6.12.gz
Type: application/x-gzip
Size: 14396 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/8dfe2e28/patch_w83792d-2.6.12-0001.gz
