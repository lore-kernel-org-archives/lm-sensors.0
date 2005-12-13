From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Dec 2005 22:03:24 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <20051213230324.3ca9d3fe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> > But..., a stupid question : what can I do with this i2c busses ?
> Now, I can see eeprom with xsensors.
> I have 4 x 1 GB (DDR2) on my mobo.
> xsensors displays I have 4 modules, yes,
> but with memory type of 8 and memory size of 14 MB !

xsensors most probably doesn't know about DDR2 memory modules. You may
try the following patch. That's a quick hack and I have no way to test
it (no DDR2 SDRAM here). Please let me know if it works. If it does,
I'll send it to Kris Kersey.

 src/gui.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- xsensors-0.47.orig/src/gui.c	2004-03-30 15:49:08.000000000 +0200
+++ xsensors-0.47/src/gui.c	2005-12-13 22:57:27.000000000 +0100
@@ -332,6 +332,19 @@
                                      widget->style->fg_gc[ GTK_WIDGET_STATE
                                      (widget) ], theme, 54, 150,
                                      161, 0, 75, 30 );
+                } else if ( current->curvalue = 8 ) {
+                    gdk_draw_drawable( widget->window,
+                                     widget->style->fg_gc[ GTK_WIDGET_STATE
+                                     (widget) ], theme, 55, 120,
+                                     0, 0, 57, 30 );
+                    gdk_draw_drawable( widget->window,
+                                     widget->style->fg_gc[ GTK_WIDGET_STATE
+                                     (widget) ], theme, 36, 0,
+                                     57, 0, 18, 30 );
+                    gdk_draw_drawable( widget->window,
+                                     widget->style->fg_gc[ GTK_WIDGET_STATE
+                                     (widget) ], theme, 112, 120,
+                                     75, 0, 104, 30 );
                 } else {
                     gdk_draw_drawable( widget->window, 
                                      widget->style->fg_gc[ GTK_WIDGET_STATE 
@@ -403,7 +416,7 @@
             } else {
                 sensors_get_feature( current->name, SENSORS_EEPROM_TYPE, 
                                      &tempD );
-                if ( tempD = 4.0 || tempD = 7.0 ) {
+                if ( tempD = 4.0 || tempD = 7.0 || tempD = 8.0 ) {
                     sensors_get_feature(current->name, SENSORS_EEPROM_ROWADDR, 
                                         &a);
                     sensors_get_feature(current->name, SENSORS_EEPROM_COLADDR, 
@@ -414,8 +427,12 @@
                                         &d);
                     result = (((int) a) & 0x0f) + (((int) b) & 0x0f) - 17;
 
-                    if(result > 0 && result <= 12 && c <= 8 && d <= 8)
-                        result = (1 << result) * ((int) c) * ((int) d);
+                    if ( tempD = 8.0 ) { /* DDR2 */
+                            result = (1 << result) * ((((int) c) & 0x07) + 1)
+                                     * ((int) d);
+
+                    } else if(result > 0 && result <= 12 && c <= 8 && d <= 8)
+                            result = (1 << result) * ((int) c) * ((int) d);
                 }
            
                 gdk_draw_drawable( widget->window, 


Note that eeproms are not sensors though, and our ultimate goal is to
drop support for non-sensors devices in libsensors.

-- 
Jean Delvare

