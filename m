From: Andre Prendel <andre_prendel@gmx.de>
Date: Mon, 06 Apr 2009 07:56:58 +0000
Subject: [lm-sensors] [PATCH 4/8] sensord: Fix switch statement
Message-Id: <20090406075658.GD4734@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Removed useless breaks after some exit() calls.
---

 args.c |    4 ----
 1 file changed, 4 deletions(-)

--- quilt-sensors.orig/prog/sensord/args.c	2009-03-24 16:37:00.000000000 +0100
+++ quilt-sensors/prog/sensord/args.c	2009-03-24 16:51:25.000000000 +0100
@@ -221,23 +221,19 @@
 		case 'v':
 			printf("sensord version %s\n", LM_VERSION);
 			exit(EXIT_SUCCESS);
-			break;
 		case 'h':
 			printf("Syntax: %s {options} {chips}\n%s", argv[0],
 			       daemonSyntax);
 			exit(EXIT_SUCCESS);
-			break;
 		case ':':
 		case '?':
 			printf("Try `%s --help' for more information.\n",
 			       argv[0]);
 			return -1;
-			break;
 		default:
 			fprintf(stderr,
 				"Internal error while parsing options.\n");
 			return -1;
-			break;
 		}
 	}
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
