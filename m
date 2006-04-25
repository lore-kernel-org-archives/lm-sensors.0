From: galak@kernel.crashing.org (Kumar Gala)
Date: Tue, 25 Apr 2006 16:58:55 +0000
Subject: [lm-sensors] [PATCH] I2C PCA954x: Fix initial access to first
Message-Id: <Pine.LNX.4.44.0604251157350.31640-100000@gate.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, lm-sensors@lm-sensors.org

The first mux/switch port would not get selected if it was the first port to be
accessed because the code believed it already had.  We now initialize the last
channel to a bogus value to ensure the first access will properly select the
channel.

Signed-off-by: Kumar Gala <galak at kernel.crashing.org>

---
commit 9040559b19987489000a75a5f8b4957ecbb0fa7f
tree 63056d09c30f32b71bf0a2a3d57a42c2380a9dd8
parent c2f0d4dc88921bb6bed9e289fbda132f587a4306
author Kumar Gala <galak at kernel.crashing.org> Tue, 25 Apr 2006 11:58:51 -0500
committer Kumar Gala <galak at kernel.crashing.org> Tue, 25 Apr 2006 11:58:51 -0500

 drivers/i2c/chips/pca954x.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/pca954x.c b/drivers/i2c/chips/pca954x.c
index f300493..4ee38bc 100644
--- a/drivers/i2c/chips/pca954x.c
+++ b/drivers/i2c/chips/pca954x.c
@@ -234,6 +234,10 @@ static int pca954x_detect(struct i2c_ada
 
 	data->chip_offset = i;
 
+	/* Set last_chan to an invalid channel to force an initial setting
+	 * of the mux/switch on the first select_chan */
+	data->last_chan = 0xff;
+
 	if ((ret = i2c_attach_client(client)))
 		goto exit_free;
 



