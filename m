From: Brett Beach <bbeach@ciprico.com>
Date: Tue, 07 Aug 2007 13:54:44 +0000
Subject: [lm-sensors] PCA954x chip driver
Message-Id: <loom.20070807T154944-400@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Can anyone tell me the state of this driver.  I do not have the part (9544A) to
try at this time.  It looks complete and implements a virtual bus that
represents each of the muxed busses.  Does the virtual bus mechanism work?  I
assume that after this driver is started a sensors-detect pass would find
additional busses?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
