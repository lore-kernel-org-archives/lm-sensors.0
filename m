From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun, 02 Mar 2008 21:46:04 +0000
Subject: [lm-sensors] [PATCH] Update FSF address in headers
Message-Id: <20080302214604.GA18670@volta.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I have just noticed that the FSF address is the old one in all files
except COPYING. Please find a patch below to fix that.

Index: lib/error.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/error.h	(r=E9vision 5132)
+++ lib/error.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_ERROR_H
Index: lib/scanner.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/scanner.h	(r=E9vision 5132)
+++ lib/scanner.h	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_SCANNER_H
Index: lib/test/test-scanner.pl
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/test/test-scanner.pl	(r=E9vision 5132)
+++ lib/test/test-scanner.pl	(copie de travail)
@@ -14,7 +14,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
=20
 require 5.004;
Index: lib/test/test-scanner.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/test/test-scanner.c	(r=E9vision 5132)
+++ lib/test/test-scanner.c	(copie de travail)
@@ -13,7 +13,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdio.h>
Index: lib/sensors.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sensors.h	(r=E9vision 5132)
+++ lib/sensors.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_SENSORS_H
Index: lib/access.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.c	(r=E9vision 5132)
+++ lib/access.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdlib.h>
Index: lib/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/init.c	(r=E9vision 5132)
+++ lib/init.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdlib.h>
Index: lib/access.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/access.h	(r=E9vision 5132)
+++ lib/access.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_ACCESS_H
Index: lib/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.c	(r=E9vision 5132)
+++ lib/sysfs.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 /* this define needed for strndup() */
Index: lib/init.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/init.h	(r=E9vision 5132)
+++ lib/init.h	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_INIT_H
Index: lib/data.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/data.c	(r=E9vision 5132)
+++ lib/data.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 /* this define needed for strndup() */
Index: lib/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/Module.mk	(r=E9vision 5132)
+++ lib/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Note that MODULE_DIR (the directory in which this file resides) is a
 # 'simply expanded variable'. That means that its value is substituted
Index: lib/sysfs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/sysfs.h	(r=E9vision 5132)
+++ lib/sysfs.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef SENSORS_LIB_SYSFS_H
Index: lib/general.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/general.c	(r=E9vision 5132)
+++ lib/general.c	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include "error.h"
Index: lib/data.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/data.h	(r=E9vision 5132)
+++ lib/data.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_DATA_H
Index: lib/general.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/general.h	(r=E9vision 5132)
+++ lib/general.h	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_GENERAL
Index: lib/conf-parse.y
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/conf-parse.y	(r=E9vision 5132)
+++ lib/conf-parse.y	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #define YYERROR_VERBOSE
Index: lib/conf-lex.l
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/conf-lex.l	(r=E9vision 5132)
+++ lib/conf-lex.l	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdlib.h>
Index: lib/error.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/error.c	(r=E9vision 5132)
+++ lib/error.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdlib.h>
Index: lib/conf.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- lib/conf.h	(r=E9vision 5132)
+++ lib/conf.h	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef LIB_SENSORS_CONF_H
Index: prog/init/lm_sensors.init.suse
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/init/lm_sensors.init.suse	(r=E9vision 5132)
+++ prog/init/lm_sensors.init.suse	(copie de travail)
@@ -27,7 +27,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
=20
 # See also the lm_sensors homepage at:
 #     http://www.lm-sensors.org
Index: prog/init/lm_sensors.init
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/init/lm_sensors.init	(r=E9vision 5132)
+++ prog/init/lm_sensors.init	(copie de travail)
@@ -16,7 +16,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
=20
 # See also the lm_sensors homepage at:
 #     http://www.lm-sensors.org
Index: prog/pwm/fancontrol
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/fancontrol	(r=E9vision 5132)
+++ prog/pwm/fancontrol	(copie de travail)
@@ -36,7 +36,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
 #
=20
Index: prog/pwm/pwmconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/pwmconfig	(r=E9vision 5132)
+++ prog/pwm/pwmconfig	(copie de travail)
@@ -23,7 +23,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
 #
 echo 'This program will search your sensors for pulse width modulation (pw=
m)'
Index: prog/pwm/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/Module.mk	(r=E9vision 5132)
+++ prog/pwm/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 MODULE_DIR :=3D prog/pwm
 PROGPWMDIR :=3D $(MODULE_DIR)
Index: prog/dump/isadump.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/dump/isadump.c	(r=E9vision 5132)
+++ prog/dump/isadump.c	(copie de travail)
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 /*
Index: prog/dump/superio.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/dump/superio.c	(r=E9vision 5132)
+++ prog/dump/superio.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdlib.h>
Index: prog/dump/isaset.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/dump/isaset.c	(r=E9vision 5132)
+++ prog/dump/isaset.c	(copie de travail)
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 /*
Index: prog/dump/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/dump/Module.mk	(r=E9vision 5132)
+++ prog/dump/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Note that MODULE_DIR (the directory in which this file resides) is a
 # 'simply expanded variable'. That means that its value is substituted
Index: prog/dump/superio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/dump/superio.h	(r=E9vision 5132)
+++ prog/dump/superio.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef _SUPERIO_H
Index: prog/tellerstats/tellerstats.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/tellerstats/tellerstats.sh	(r=E9vision 513=
2)
+++ prog/tellerstats/tellerstats.sh	(copie de travail)
@@ -17,7 +17,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
=20
 # generic tellerstats init BEGIN
Index: prog/tellerstats/gather.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/tellerstats/gather.sh	(r=E9vision 5132)
+++ prog/tellerstats/gather.sh	(copie de travail)
@@ -20,7 +20,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
=20
 # generic tellerstats init BEGIN
Index: prog/rrd/sens_update_rrd
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/rrd/sens_update_rrd	(r=E9vision 5132)
+++ prog/rrd/sens_update_rrd	(copie de travail)
@@ -23,7 +23,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
 #################################################################
 #
Index: prog/rrd/sens_create_rrd
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/rrd/sens_create_rrd	(r=E9vision 5132)
+++ prog/rrd/sens_create_rrd	(copie de travail)
@@ -18,7 +18,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
 RRDPATH=3D/usr/bin
 RRDB=3D$1
Index: prog/detect/sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect	(r=E9vision 5132)
+++ prog/detect/sensors-detect	(copie de travail)
@@ -17,7 +17,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
=20
 # TODO: Better handling of chips with several addresses
@@ -5945,7 +5946,8 @@
 #
 #    You should have received a copy of the GNU General Public License
 #    along with this program; if not, write to the Free Software
-#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#    MA 02110-1301 USA.
 #
 #
 # See also the lm_sensors homepage at:
Index: prog/detect/sensors-detect-stat.pl
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/sensors-detect-stat.pl	(r=E9vision =
5132)
+++ prog/detect/sensors-detect-stat.pl	(copie de travail)
@@ -17,7 +17,8 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
-# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA 02110-1301 USA.
=20
 use strict;
 use vars qw(%histo $chips $file $skip);
Index: prog/detect/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/detect/Module.mk	(r=E9vision 5132)
+++ prog/detect/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Note that MODULE_DIR (the directory in which this file resides) is a
 # 'simply expanded variable'. That means that its value is substituted
Index: prog/sensors/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/main.c	(r=E9vision 5132)
+++ prog/sensors/main.c	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdio.h>
Index: prog/sensors/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/chips.c	(r=E9vision 5132)
+++ prog/sensors/chips.c	(copie de travail)
@@ -16,7 +16,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #include <stdio.h>
Index: prog/sensors/main.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/main.h	(r=E9vision 5132)
+++ prog/sensors/main.h	(copie de travail)
@@ -14,7 +14,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef PROG_SENSORS_MAIN_H
Index: prog/sensors/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/Module.mk	(r=E9vision 5132)
+++ prog/sensors/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Note that MODULE_DIR (the directory in which this file resides) is a
 # 'simply expanded variable'. That means that its value is substituted
Index: prog/sensors/chips.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensors/chips.h	(r=E9vision 5132)
+++ prog/sensors/chips.h	(copie de travail)
@@ -15,7 +15,8 @@
=20
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+    MA 02110-1301 USA.
 */
=20
 #ifndef PROG_SENSORS_CHIPS_H
Index: prog/sensord/sensord.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/sensord.h	(r=E9vision 5132)
+++ prog/sensord/sensord.h	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include "lib/sensors.h"
Index: prog/sensord/chips.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/chips.c	(r=E9vision 5132)
+++ prog/sensord/chips.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <stdio.h>
Index: prog/sensord/lib.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/lib.c	(r=E9vision 5132)
+++ prog/sensord/lib.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <stdio.h>
Index: prog/sensord/rrd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/rrd.c	(r=E9vision 5132)
+++ prog/sensord/rrd.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 /*
Index: prog/sensord/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/Module.mk	(r=E9vision 5132)
+++ prog/sensord/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # The round robin database (RRD) development headers and libraries are
 # REQUIRED. Get this package from:
Index: prog/sensord/args.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/args.c	(r=E9vision 5132)
+++ prog/sensord/args.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <stdio.h>
Index: prog/sensord/sense.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/sense.c	(r=E9vision 5132)
+++ prog/sensord/sense.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <stdio.h>
Index: prog/sensord/sensord.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/sensord/sensord.c	(r=E9vision 5132)
+++ prog/sensord/sensord.c	(copie de travail)
@@ -17,7 +17,8 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA 02110-1301 USA.
  */
=20
 #include <stdio.h>
Index: etc/Module.mk
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- etc/Module.mk	(r=E9vision 5132)
+++ etc/Module.mk	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Note that MODULE_DIR (the directory in which this file resides) is a
 # 'simply expanded variable'. That means that its value is substituted
Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- Makefile	(r=E9vision 5132)
+++ Makefile	(copie de travail)
@@ -13,7 +13,8 @@
 #
 #  You should have received a copy of the GNU General Public License
 #  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+#  MA 02110-1301 USA.
=20
 # Everything you may want to change is in the top of this file. Usually, y=
ou
 # can just use the defaults, fortunately.

--=20
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
