From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 24 Mar 2006 04:04:14 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <4dfa50520603232004q3186d047xfeb457137c999eb2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I applied the patch in your email and tested it. It works fine. I
updated the regression test to match the new alarm sysfs entries.

David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 14798 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060324/e53d7e86/w83627ehf_regression.sh
