From: deant@hawaii.rr.com (Dean Takemori)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <274D1E7E-C25E-11D8-BCE6-000A95AF6760@hawaii.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jun 19, 2004, at 11:55 AM, Jean Delvare wrote:

> Hi Dean,
>
>> Add END {} block to restore fans on many kinds of errors/interrupts.
>> Remove arugment from restorefans

> Two questions:
>
> 1* What cases are you trying to catch? You already seem to be catching
> all possible signals.

It's really kind of a catchall block for testing/development.  There
were a few kinds of runtime errors I ran into during tests that left the
fans in a slower state so it seemed prudent to put in some sort of
catchall and run restorefans() on exit as often as possible.

> 2* I suspect that the restorefans() function will be called twice more
> often than not. Since the END block is executed on exit, and
> restorefans() exits, won't it call itself each time?

You're partly right here.

END blocks are not run if the script is exiting due to a signal, so if
restorefans() is being called from one of the signal handlers, the END
block is not run when exit() is reached.

However, you're right about calling restorefans() or die/exit elsewhere.
I didn't know END blocks could be called from END blocks like that.

The patch should be backed out.  (The second part of the patch, which
removes the $sigtype = shift; is harmless)

Bleeding-edge souls could try the (mostly untested) patch at the end of
this post.

-dean takemori

PS.  For anyone who's interested, I have an /etc/init.d/fancontrol
start/stop script suitable for Fedora Core 1 for use with this perl
script (probably also good for FC2 and recent RedHat type distros)


--- fancontrol.pl  2004-06-19 15:41:23.000000000 -1000
+++ fancontrol-patched.pl  2004-06-19 15:48:57.000000000 -1000
@@ -72,6 +72,7 @@
  sub restorefans();
  sub calc(@);
  sub UpdateFanSpeeds();
+END { restorefans(); }

  our $opt_d;
  getopts('d');
@@ -138,10 +139,7 @@
    {
      $pwmo = $afcpwm[$fcvcount];
      unless (pwmenable($pwmo))
-      {
-        print("Error enabling PWM on $dir/$pwmo : $!\n");
-        restorefans();
-      }
+      { die("Error enabling PWM on $dir/$pwmo : $!\n"); }
      $fcvcount++;
    }

@@ -268,10 +266,7 @@
                close(F);
              }
            else
-            {
-              print("$dir/$p : $!\n");
-              restorefans();
-            }
+            { die("$dir/$p : $!\n"); }
          }
      }
    else
@@ -282,10 +277,7 @@
            close(F);
          }
        else
-        {
-          print("$dir/$p : $!\n");
-          restorefans();
-        }
+        { die("$dir/$p : $!\n"); }
      }
    return(1);
  }
@@ -294,8 +286,6 @@
  ################################################################ 
restorefans()
  sub restorefans()
  {
-  my $sigtype = shift;
-
    $SIG{TERM} = 'IGNORE';
    $SIG{HUP}  = 'IGNORE';
    $SIG{INT}  = 'IGNORE';
@@ -311,7 +301,7 @@
        $fcvcount++;
      }
    print("Verify fans have returned to full speed\n");
-  exit(0);
+  POSIX:_exit(0);
  }


@@ -338,10 +328,7 @@
            close(F);
          }
        else
-        {
-          print("Error reading temperature from $dir/$tsens");
-          restorefans();
-        }
+        { die("Error reading temperature from $dir/$tsens"); }
        $tval =~ /([.\d]+)\s*$/;
        $tval = int($1);
        if ($sysfs = 1)
@@ -355,10 +342,7 @@
            close(F);
          }
        else
-        {
-          print("Error reading PWM value from $dir/$pwmo");
-          restorefans();
-        }
+        { die("Error reading PWM value from $dir/$pwmo"); }
        ($pwmpval) = split(/\s/, $pwmpval);

        ### fanval
@@ -369,10 +353,7 @@
            close(F);
          }
        else
-        {
-          print("Error reading Fan value from $dir/$fan");
-          restorefans();
-        }
+        { die("Error reading Fan value from $dir/$fan"); }
        $fanval =~ /(\d+)\s$/;
        $fanval = $1;

@@ -411,10 +392,7 @@
                    close(F);
                  }
                else
-                {
-                  print("Error writing PWM value to $dir/$pwmo : 
$!\n");
-                  restorefans();
-                }
+                { die("Error writing PWM value to $dir/$pwmo : $!\n"); 
}
                sleep 1;
              }
          }
@@ -425,10 +403,7 @@
            close(F);
          }
        else
-        {
-          print("Error writing PWM value to $dir/$pwmo : $!\n");
-          restorefans();
-        }
+        { die("Error writing PWM value to $dir/$pwmo : $!\n"); }

        if (DEBUG = 1)
          { print("new pwmval = $pwmval\n"); }
