From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Jul 2013 12:17:18 +0000
Subject: Re: [lm-sensors] [PATCH] Avoiding warnings when piping to sensors-detect
Message-Id: <20130728141718.6dde5368@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
In-Reply-To: <699701256.6909990.1374770991358.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Fri, 26 Jul 2013 10:31:02 -0400 (EDT), Jaromir Capik wrote:
> > Yes, I understand that. However I'm not sure we want to encourage
> > people to use this.
> 
> > But I do agree that the warnings are ugly and should be avoided in all
> > cases. My proposal would be to first detect when <STDIN> can't be read
> > (eof(STDIN) should do) and bail out with an error message pointing the
> > user to the new --auto parameter.
> > 
> > Would it be OK with you? Or do you prefer that we keep supporting the
> > old way, even if it was never documented? If so, we could still print a
> > warning but go on, and remove support for piping in a couple years,
> > when everyone have updated their scripts.
> 
> I prefer to keep support for the old way -AND- write a message instructing
> users to use the --auto switch instead. The message should be displayed
> at the bottom of the listing. Such way is the least invasive one.
> We'll not break the current solutions running with redirection while
> encouraging users to use the new way. Preventing users from using /dev/null
> as the input source would cause unwanted regressions in their current
> solutions and we don't want to make them angry, right? :]
> 
> Please, let me know about your decision.

Fair enough. eof() did not work (it blocked when STDIN was not
redirected) but I found another way to implement your proposal in the
Perl Cookbook. What do you think? If you can find a better wording,
please let me know.

sensors-detect: Detect incorrect non-interactive runs

It is better to use option --auto for non-interactive runs of the
sensors-detect script than faking an input to get the default answers
to all questions.
---
 prog/detect/sensors-detect |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2013-07-27 17:46:45.193801963 +0200
+++ lm-sensors/prog/detect/sensors-detect	2013-07-28 14:12:02.481430020 +0200
@@ -2518,7 +2518,7 @@ sub read_answer
 		print "\n";
 		return "";
 	}
-	return <STDIN>;
+	return <STDIN> || "";
 }
 
 ###################
@@ -7011,6 +7011,13 @@ sub main
 	}
 
 	unload_modules();
+
+	# Check if running non-interactively without --auto
+	if (!$opt_auto && ! -t STDIN) {
+		print "Warning: the preferred way to run this script non-interactively\n".
+		      "is with option --auto. Other methods are discouraged and may\n".
+		      "stop working at some point in the future.\n\n";
+	}
 }
 
 sub cleanup_on_int


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
