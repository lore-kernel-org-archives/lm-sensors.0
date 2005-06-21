From: fabien.pourias@thales-is.com (fabien.pourias)
Date: Tue, 21 Jun 2005 10:50:26 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <42AA93B8@mailmlk.tisfr.thales>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks a lot for the patch. It works pretty well (i.e. we see meaningful 
values when we run sensors -u) but the user tools are not up to date :
 - sensors-detect fails to detect the w83792d
 - the "sensors" output only includes the old w83627hf data

So we run sensors -u to get all the results. NOTE: we always use sensors -u 
since we need to postprocess the output and the "raw" results are usually 
better for that.

 sincerely,

    Fabien Pourias


