From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2015 20:27:44 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (atxp1) Drop FSF mailing address
Message-Id: <1432931265-21499-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The FSF mailing address may change and does not provide any real value.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/atxp1.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
index 4c829bb2f9db..78edc56b59e5 100644
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -11,11 +11,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #include <linux/kernel.h>
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
