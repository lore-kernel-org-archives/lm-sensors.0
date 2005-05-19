From: vsu@altlinux.ru (Sergey Vlasov)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH] fix Perl syntax errors in fancontrol.pl
Message-Id: <20050501160501.GB2589@procyon.home>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello!

The prog/pwm/fancontrol.pl script has some obvious syntax errors:

$ perl -cT fancontrol.pl 
"my" variable $file masks earlier declaration in same scope at fancontrol.pl line 165.
"my" variable $file masks earlier declaration in same scope at fancontrol.pl line 167.
"my" variable $file masks earlier declaration in same statement at fancontrol.pl line 167.
"my" variable $file masks earlier declaration in same scope at fancontrol.pl line 168.
"our" variable $interval masks earlier declaration in same scope at fancontrol.pl line 172.
"my" variable $fcvcount masks earlier declaration in same scope at fancontrol.pl line 193.
syntax error at fancontrol.pl line 162, near "$)
sub loadconfig($)
"
Can't use global $! in "my" at fancontrol.pl line 168, near "$file: $!"
syntax error at fancontrol.pl line 214, near "}"
fancontrol.pl had compilation errors.

Looks like this is caused by some strange lines before "sub ..."
declarations, which apparently have been added in the last update at
2004/06/23 (hmm, if these errors are still there, probably nobody uses
this script).

The patch below is untested due to lack of hardware supporting PWM,
but at least "perl -cwT fancontrol.pl" passes now.

--- lm_sensors/prog/pwm/fancontrol.pl.alt-fix-fancontrol	2004-06-23 22:34:24 +0400
+++ lm_sensors/prog/pwm/fancontrol.pl	2004-10-10 22:19:13 +0400
@@ -157,7 +157,6 @@ while(1)
 1;
 
 ################################################################ 
-loadconfig($)
 sub loadconfig($)
 {
    my $file = shift;
@@ -215,7 +214,6 @@ $minstop);
 
 
 ################################################################ 
-pwmdisable($)
 sub pwmdisable($)
 {
    my $p = shift;
@@ -257,7 +255,6 @@ sub pwmdisable($)
 
 
 ################################################################# 
-pwmenable($)
 sub pwmenable($)
 {
    my $p = shift;
@@ -291,7 +288,6 @@ sub pwmenable($)
 
 
 ################################################################ 
-restorefans()
 sub restorefans()
 {
    $SIG{TERM} = 'IGNORE';
@@ -314,7 +310,6 @@ sub restorefans()
 
 
 ############################################################ 
-UpdateFanSpeeds()
 sub UpdateFanSpeeds()
 {
    my $fcvcount = 0;

-- 
Sergey Vlasov
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050501/48e27bff/attachment.bin
