From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 07 Jul 2005 20:50:24 +0000
Subject: [lm-sensors] W83627thf
Message-Id: <42CD795A.7060805@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050707070237.63441.qmail@web60124.mail.yahoo.com>
In-Reply-To: <20050707070237.63441.qmail@web60124.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 Hi Mehran,

I think it has also W83792D on it. This chip is supported in 2.4 and for 2.6 some patches exists too. (not yet in mainline)
I belive you will need latest beta bios for k8n

	K8N 	1007.009 	K8N Beta BIOS 1007.009

http://support.asus.com/download/download_item.aspx?product=1&model=K8N&SLanguage=en-us

Then you will be able to "see" this chip on Linux.
If you have 2.4.x kernels go ahead with lm_sensors 2.9.1
If you have 2.6.x kernels you can try this http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/8dfe2e28/patch_w83792d-2.6.12-0001.gz
And this http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050706/3a674472/w83792d-driver-QUIET-2.6.x.patch-0001.gz
You will need lm_sensors CVS userspace utillites for this (make user; make user_install;)

Regards

Rudolf
